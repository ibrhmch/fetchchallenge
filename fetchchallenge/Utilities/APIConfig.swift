//
//  APIConfig.swift
//  fetchchallenge
//
//  Created by octopus on 6/10/24.
//

import Foundation

struct APIConfig {
    static let baseURL = "https://themealdb.com/api/json/v1/1/"
    
    static var dessertMealsURL: String {
        return "\(baseURL)filter.php?c=Dessert"
    }
    
    static func mealDetailURL(for mealID: String) -> String {
        return "\(baseURL)lookup.php?i=\(mealID)"
    }
}
