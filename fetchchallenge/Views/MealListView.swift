import SwiftUI

struct MealListView: View {
    @StateObject private var viewModel = MealListViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading Meals")
                        .progressViewStyle(CircularProgressViewStyle())
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                } else {
                    List(viewModel.filteredMeals) { meal in
                        NavigationLink(destination: MealDetailView(mealID: meal.id)) {
                            MealCardView(meal: meal)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .searchable(text: $searchText, prompt: "Search meals")
                    .onChange(of: searchText) { newValue in
                        viewModel.searchText = newValue
                    }
                }
            }
            .navigationBarTitle("Dessert Meals", displayMode: .inline)
            .task {
                if !viewModel.hasLoadedMeals {
                    await viewModel.fetchMeals()
                }
            }
        }
    }
}

#Preview {
    MealListView()
}
