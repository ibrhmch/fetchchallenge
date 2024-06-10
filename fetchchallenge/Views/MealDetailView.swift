//
//  MealDetailView.swift
//  fetchchallenge
//
//  Created by octopus on 6/10/24.
//

import SwiftUI

struct MealDetailView: View {
    @StateObject private var viewModel = MealDetailViewModel()
    let mealID: String

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading meal details...")
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
            } else if let mealDetail = viewModel.mealDetail {
                VStack(alignment: .leading, spacing: 16) {
                    Text(mealDetail.name)
                        .font(.largeTitle)
                        .bold()
                    Text("Instructions")
                        .font(.headline)
                    Text(mealDetail.instructions)
                    Text("Ingredients")
                        .font(.headline)
                    ForEach(Array(zip(mealDetail.ingredients, mealDetail.measurements)), id: \.0) { ingredient, measurement in
                        HStack {
                            Text(ingredient)
                            Spacer()
                            Text(measurement)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarTitle("Meal Details", displayMode: .inline)
        .task {
            await viewModel.fetchMealDetail(mealID: mealID)
        }
    }
}

#Preview {
    MealDetailView(mealID: "53049")
}
