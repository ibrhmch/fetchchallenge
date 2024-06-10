import SwiftUI

struct MealListView: View {
    @StateObject private var viewModel = MealListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading meals...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                } else {
                    SearchBar(text: $viewModel.searchText)
                    
                    Spacer()
                    
                    List(viewModel.filteredMeals) { meal in
                        NavigationLink(destination: MealDetailView(mealID: meal.id)) {
                            MealCardView(meal: meal)
                        }
                    }
                    .listStyle(PlainListStyle())
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
