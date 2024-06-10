//
//  MealDetail.swift
//  fetchchallenge
//
//  Created by octopus on 6/9/24.
//

struct MealDetail: Codable {
    let id: String
    let name: String
    let category: String
    let area: String
    let instructions: String
    let thumbnail: String?
    let tags: String?
    let youtubeURL: String?
    let source: String?
    let ingredients: [String]
    let measurements: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case category = "strCategory"
        case area = "strArea"
        case instructions = "strInstructions"
        case thumbnail = "strMealThumb"
        case tags = "strTags"
        case youtubeURL = "strYoutube"
        case source = "strSource"
        case ingredients = "strIngredient1"
        // Ingredients continue through strIngredient20
        case measurements = "strMeasure1"
        // Measurements continue through strMeasure20
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        category = try container.decode(String.self, forKey: .category)
        area = try container.decode(String.self, forKey: .area)
        instructions = try container.decode(String.self, forKey: .instructions)
        thumbnail = try container.decodeIfPresent(String.self, forKey: .thumbnail)
        tags = try container.decodeIfPresent(String.self, forKey: .tags)
        youtubeURL = try container.decodeIfPresent(String.self, forKey: .youtubeURL)
        source = try container.decodeIfPresent(String.self, forKey: .source)
        
        // Dynamic ingredient and measurement decoding
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
