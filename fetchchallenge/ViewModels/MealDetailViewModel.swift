//
//  MealDetailViewModel.swift
//  fetchchallenge
//
//  Created by octopus on 6/10/24.
//

import Foundation

@MainActor
class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealDetail?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func fetchMealDetail(mealID: String) async {
        isLoading = true
        errorMessage = nil

        guard let url = URL(string: APIConfig.mealDetailURL(for: mealID)) else {
            self.errorMessage = "Invalid URL"
            self.isLoading = false
            return
        }

        do {
            let mealResponse: [String: [MealDetail]] = try await NetworkingService.shared.fetchData(from: url)
            if let mealDetail = mealResponse["meals"]?.first {
                DispatchQueue.main.async {
                    self.mealDetail = mealDetail
                    self.isLoading = false
                }
            } else {
                throw NSError(domain: "No meals found", code: -1, userInfo: nil)
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}
