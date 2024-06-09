//
//  MEAL.swift
//  fetchchallenge
//
//  Created by octopus on 6/9/24.
//

import Foundation

struct Meal: Codable, Identifiable {
    let id: String
    let name: String
    let thumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnail = "strMealThumb"
    }
}
