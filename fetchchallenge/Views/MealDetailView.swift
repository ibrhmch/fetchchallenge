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
                MealDetailCardView(mealDetail: mealDetail)
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
