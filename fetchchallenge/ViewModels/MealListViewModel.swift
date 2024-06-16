import Foundation
import Combine

class MealListViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var viewState: ViewState<[Meal]> = .loading
    @Published var searchText: String = "" {
        didSet {
            filterMeals()
        }
    }
    
    var hasLoadedMeals = false
    @Published var filteredMeals: [Meal] = []
    
    init() {
        filterMeals()
    }

    func fetchMeals() async {
        guard !hasLoadedMeals else { return } //only fetch if meals have not been fetched yet
        
        DispatchQueue.main.async {
            self.viewState = .loading
        }
        
        guard let url = URL(string: APIConfig.dessertMealsURL) else {
            DispatchQueue.main.async {
                self.viewState = .failure("Invalid URL")
            }
            return
        }
        
        do {
            let mealResponse: MealResponse = try await NetworkingService.shared.fetchData(from: url)
            DispatchQueue.main.async {
                self.meals = mealResponse.meals.sorted(by: { $0.name.lowercased() < $1.name.lowercased() })
                self.filteredMeals = self.meals
                self.viewState = .success(self.filteredMeals)
                self.hasLoadedMeals = true
            }
        } catch {
            DispatchQueue.main.async {
                self.viewState = .failure(error.localizedDescription)
            }
        }
    }
    
    private func filterMeals() {
        if searchText.isEmpty {
            filteredMeals = meals
        } else {
            filteredMeals = meals.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        if hasLoadedMeals {
            DispatchQueue.main.async {
                self.viewState = .success(self.filteredMeals)
            }
        }
    }
}
