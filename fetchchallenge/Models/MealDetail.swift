//
//  MealDetail.swift
//  fetchchallenge
//
//  Created by octopus on 6/9/24.
//

struct MealDetail: Codable {
    let name: String
    let instructions: String
    let ingredients: [String]
    let measurements: [String]
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case instructions = "strInstructions"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        instructions = try container.decode(String.self, forKey: .instructions)
        
        // Ingredients and Measurements
        var ingredients: [String] = []
        var measurements: [String] = []
        
        let dynamicContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        for i in 1...20 {
            if let ingredientKey = DynamicCodingKeys(stringValue: "strIngredient\(i)"),
               let ingredient = try? dynamicContainer.decodeIfPresent(String.self, forKey: ingredientKey),
               !ingredient.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                ingredients.append(ingredient.trimmingCharacters(in: .whitespacesAndNewlines))
            }
            
            if let measurementKey = DynamicCodingKeys(stringValue: "strMeasure\(i)"),
               let measurement = try? dynamicContainer.decodeIfPresent(String.self, forKey: measurementKey),
               !measurement.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                measurements.append(measurement.trimmingCharacters(in: .whitespacesAndNewlines))
            }
        }
        
        self.ingredients = ingredients
        self.measurements = measurements
    }
}

// Helper struct for dynamic coding keys
struct DynamicCodingKeys: CodingKey {
    var stringValue: String
    var intValue: Int? { nil }
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    init?(intValue: Int) {
        return nil
    }
}
