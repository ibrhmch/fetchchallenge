import SwiftUI

struct MealListView: View {
    @State private var searchText = ""
    @StateObject private var viewModel = MealListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading meals...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                } else {
                    SearchBar(text: $searchText)
                    
                    List(viewModel.meals) { meal in
                        MealCardView(meal: meal)
                    }
                }
            }
            .navigationBarTitle("Dessert Meals", displayMode: .inline)
            .task {
                await viewModel.fetchMeals()
            }
        }
    }
}

#Preview {
    MealListView()
}
