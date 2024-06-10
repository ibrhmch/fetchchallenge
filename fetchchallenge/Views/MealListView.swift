import SwiftUI

struct MealListView: View {
    @State private var searchText = ""
    @StateObject private var viewModel = MealListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                
                if viewModel.isLoading {
                    ProgressView("Loading meals...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                } else {
                    List(viewModel.meals) { meal in
                        ZStack {
                            AsyncImage(url: URL(string: meal.thumbnail)) { phase in
                                switch phase {
                                case .empty:
                                    Color.gray.opacity(0.3)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(height: 200)
                                        .clipped()
                                case .failure:
                                    Color.red.opacity(0.3)
                                @unknown default:
                                    Color.gray.opacity(0.3)
                                }
                            }
                            .frame(height: 200)
                            .clipped()
                            
                            Text(meal.name)
                                .font(.headline)
                                .fontWeight(.thin)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .cornerRadius(10)
                                .padding(4)
                        }
                        .cornerRadius(10)
                        .shadow(radius: 5)
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
