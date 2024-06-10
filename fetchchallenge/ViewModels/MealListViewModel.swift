import Foundation

class MealListViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    func fetchMeals() async {
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
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}
