import Foundation

class MealListViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var searchText: String = ""
    
    var hasLoadedMeals = false
    
    var filteredMeals: [Meal] {
        if searchText.isEmpty {
            return meals
        } else {
            return meals.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    func fetchMeals() async {
        guard !hasLoadedMeals else { return } //only fetch if meals have not been fetched yet
        
        isLoading = true
        errorMessage = nil
        
        let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        guard let url = URL(string: urlString) else {
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
                self.meals = mealResponse.meals
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
}
