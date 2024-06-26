//
//  MealDetailViewModel.swift
//  fetchchallenge
//
//  Created by octopus on 6/10/24.
//

import Foundation

class MealDetailViewModel: ObservableObject {
    @Published var viewState: ViewState<MealDetail> = .loading
    
    private let networkingService: NetworkingServiceProtocol
    
    init(networkingService: NetworkingServiceProtocol = NetworkingService.shared) {
        self.networkingService = networkingService
    }

    func fetchMealDetail(mealID: String) async {
        DispatchQueue.main.async {
            self.viewState = .loading
        }

        guard let url = URL(string: APIConfig.mealDetailURL(for: mealID)) else {
            DispatchQueue.main.async {
                self.viewState = .failure("Invalid URL")
            }
            return
        }

        do {
            let mealResponse: [String: [MealDetail]] = try await networkingService.fetchData(from: url)
            if let mealDetail = mealResponse["meals"]?.first {
                DispatchQueue.main.async {
                    self.viewState = .success(mealDetail)
                }
            } else {
                throw NSError(domain: "No meals found", code: -1, userInfo: nil)
            }
        } catch {
            DispatchQueue.main.async {
                self.viewState = .failure(error.localizedDescription)
            }
        }
    }
}
