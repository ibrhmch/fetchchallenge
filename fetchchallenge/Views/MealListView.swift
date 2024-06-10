//
//  MealListView.swift
//  fetchchallenge
//
//  Created by octopus on 6/9/24.
//

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
                    List(viewModel.meals) { meal in
                        HStack {
                            AsyncImage(url: URL(string: meal.thumbnail))
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text(meal.name)
                        }
                    }
                }
            }
            .navigationTitle("Dessert Meals")
            .task {
                await viewModel.fetchMeals()
            }
        }
    }
}

#Preview {
    MealListView()
}
