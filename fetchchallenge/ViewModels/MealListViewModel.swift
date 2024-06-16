import Foundation
import Combine

@MainActor
class MealListViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var searchText: String = "" {
        didSet {
            filterMeals()
        }
    }
    
    var hasLoadedMeals = false
    @Published var filteredMeals: [Meal] = []
    
    init() {
        // Initial filter
        filterMeals()
    }

    func fetchMeals() async {
        guard !hasLoadedMeals else { return } //only fetch if meals have not been fetched yet
        
        isLoading = true
        errorMessage = nil
        
        guard let url = URL(string: APIConfig.dessertMealsURL) else {
            self.errorMessage = "Invalid URL"
            self.isLoading = false
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            let decoder = JSONDecoder()
            let mealResponse = try decoder.decode(MealResponse.self, from: data)
            DispatchQueue.main.async {
                // ensuring meals are sorted and stored in alphabetical order
                self.meals = mealResponse.meals.sorted(by: { $0.name.lowercased() < $1.name.lowercased() })
                self.filteredMeals = self.meals
                self.isLoading = false
                self.hasLoadedMeals = true
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    private func filterMeals() {
        if searchText.isEmpty {
            filteredMeals = meals
        } else {
            filteredMeals = meals.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
}
