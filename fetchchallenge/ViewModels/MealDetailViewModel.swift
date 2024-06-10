//
//  MealDetailViewModel.swift
//  fetchchallenge
//
//  Created by octopus on 6/10/24.
//

import Foundation

class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealDetail?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func fetchMealDetail(mealID: String) async {
        isLoading = true
        errorMessage = nil

        let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)"
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
            let mealResponse = try decoder.decode([String: [MealDetail]].self, from: data)
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
