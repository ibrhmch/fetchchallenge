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
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if viewModel.isLoading {
                    ProgressView("Loading Meal Details")
                        .progressViewStyle(CircularProgressViewStyle())
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .bold()
                        .padding()
                } else if let mealDetail = viewModel.mealDetail {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(mealDetail.name)
                            .font(.title)
                            .bold()
                            .padding(.top, 20)

                        if !mealDetail.instructions.isEmpty {
                            Text("Instructions")
                                .font(.headline)
                                .padding(.top, 10)
                            Text(mealDetail.instructions)
                        }

                        if !mealDetail.ingredients.isEmpty {
                            Divider()
                            Text("Ingredients")
                                .font(.headline)
                                .padding(.vertical, 5)
                            ForEach(Array(zip(mealDetail.ingredients, mealDetail.measurements)), id: \.0) { ingredient, measurement in
                                HStack {
                                    Text(ingredient)
                                    Spacer()
                                    Text(measurement)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                    .padding()
                }
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
