//
//  MealDetailCardView.swift
//  fetchchallenge
//
//  Created by octopus on 6/10/24.
//

import SwiftUI

struct MealDetailCardView: View {
    let mealDetail: MealDetail
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let imageUrl = mealDetail.thumbnail, let url = URL(string: imageUrl) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                                     .aspectRatio(contentMode: .fill)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(height: 300)
                            .cornerRadius(10)
                            .padding(.horizontal)
                        }

                        Text(mealDetail.name)
                            .font(.title)
                            .bold()

            if !mealDetail.instructions.isEmpty {
                            Text("Instructions")
                                .font(.headline)
                                .padding(.top, 10)
                            Text(mealDetail.instructions)
                        }

            if !mealDetail.ingredients.isEmpty,
               !mealDetail.measurements.isEmpty {
                            Divider()
                            VStack(alignment: .leading) {
                                Text("Ingredients")
                                    .font(.headline)
                                    .padding(.vertical, 5)
                                ForEach(Array(zip(mealDetail.ingredients, mealDetail.measurements)), id: \.0) { ingredient, measurement in
                                    Text("\(measurement) of \(ingredient)")
                                }
                            }
                        }

                        if let youtubeURL = mealDetail.youtubeURL, let url = URL(string: youtubeURL) {
                            Link("Watch on YouTube", destination: url)
                                .font(.headline)
                                .foregroundColor(.blue)
                                .padding(.top, 20)
                        }
                    }
                    .padding()
    }
}

#Preview {
    MealDetailCardView(mealDetail: sampleMealDetail())
}

func sampleMealDetail() -> MealDetail {
    let json = """
    {
        "meals": [
            {
                "idMeal": "52788",
                "strMeal": "Christmas Pudding Flapjack",
                "strDrinkAlternate": null,
                "strCategory": "Dessert",
                "strArea": "British",
                "strInstructions": "Preheat the oven to 180\\u00b0C\\/fan 160\\u00b0C\\/gas mark 4 and grease and line a 25cm x 20cm tin. Melt the butter, sugar, syrup and orange zest in a large saucepan over a medium heat. The aim is to dissolve all the ingredients so that they are smooth, but to not lose any volume through boiling so be careful not to overheat.\\r\\n\\r\\nAdd the oats and stir well until evenly coated. Stir through the leftover Christmas pudding and tip into the prepared tin. Use a spoon to flatten the top and bake for 40 minutes until the edges start to brown. Whilst still warm in the tin, score into 12 squares. Allow to cool completely before cutting along the scores.\\r\\n\\r\\nKeeps for 5 days in an air tight tin or freeze for up to 1 month.",
                "strMealThumb": "https://www.themealdb.com/images/media/meals/vvusxs1483907034.jpg",
                "strTags": "Snack,Cake",
                "strYoutube": "https://www.youtube.com/watch?v=OaqvGvEiwzU",
                "strIngredient1": "salted butter",
                "strIngredient2": "dark soft brown sugar",
                "strIngredient3": "golden syrup",
                "strIngredient4": "orange",
                "strIngredient5": "rolled oats",
                "strIngredient6": "Christmas pudding",
                "strIngredient7": "",
                "strIngredient8": "",
                "strIngredient9": "",
                "strIngredient10": "",
                "strIngredient11": "",
                "strIngredient12": "",
                "strIngredient13": "",
                "strIngredient14": "",
                "strIngredient15": "",
                "strIngredient16": "",
                "strIngredient17": "",
                "strIngredient18": "",
                "strIngredient19": "",
                "strIngredient20": "",
                "strMeasure1": "250g",
                "strMeasure2": "225g",
                "strMeasure3": "150g",
                "strMeasure4": "Zest of 1",
                "strMeasure5": "500g",
                "strMeasure6": "250g",
                "strMeasure7": "",
                "strMeasure8": "",
                "strMeasure9": "",
                "strMeasure10": "",
                "strMeasure11": "",
                "strMeasure12": "",
                "strMeasure13": "",
                "strMeasure14": "",
                "strMeasure15": "",
                "strMeasure16": "",
                "strMeasure17": "",
                "strMeasure18": "",
                "strMeasure19": "",
                "strMeasure20": "",
                "strSource": "",
                "strImageSource": null,
                "strCreativeCommonsConfirmed": null,
                "dateModified": null
            }
        ]
    }
    """
    
    let data = Data(json.utf8)
    let decoder = JSONDecoder()
    do {
        let mealResponse = try decoder.decode(MealResponseOne.self, from: data)
        return mealResponse.meals[0]
    } catch {
        fatalError("Failed to decode JSON: \(error)")
    }
}

struct MealResponseOne: Codable {
    let meals: [MealDetail]
}

//#Preview {
//    let jsonString = """
//    {
//        "meals": [
//            {
//                "idMeal": "52788",
//                "strMeal": "Christmas Pudding Flapjack",
//                "strDrinkAlternate": null,
//                "strCategory": "Dessert",
//                "strArea": "British",
//                "strInstructions": "Preheat the oven to 180°C/fan 160°C/gas mark 4 and grease and line a 25cm x 20cm tin. Melt the butter, sugar, syrup and orange zest in a large saucepan over a medium heat. The aim is to dissolve all the ingredients so that they are smooth, but to not lose any volume through boiling so be careful not to overheat.\\n\\nAdd the oats and stir well until evenly coated. Stir through the leftover Christmas pudding and tip into the prepared tin. Use a spoon to flatten the top and bake for 40 minutes until the edges start to brown. Whilst still warm in the tin, score into 12 squares. Allow to cool completely before cutting along the scores.\\n\\nKeeps for 5 days in an air tight tin or freeze for up to 1 month.",
//                "strMealThumb": "https://www.themealdb.com/images/media/meals/vvusxs1483907034.jpg",
//                "strTags": "Snack,Cake",
//                "strYoutube": "https://www.youtube.com/watch?v=OaqvGvEiwzU",
//                "strIngredient1": "salted butter",
//                "strIngredient2": "dark soft brown sugar",
//                "strIngredient3": "golden syrup",
//                "strIngredient4": "orange",
//                "strIngredient5": "rolled oats",
//                "strIngredient6": "Christmas pudding",
//                "strIngredient7": "",
//                "strIngredient8": "",
//                "strIngredient9": "",
//                "strIngredient10": "",
//                "strIngredient11": "",
//                "strIngredient12": "",
//                "strIngredient13": "",
//                "strIngredient14": "",
//                "strIngredient15": "",
//                "strIngredient16": "",
//                "strIngredient17": "",
//                "strIngredient18": "",
//                "strIngredient19": "",
//                "strIngredient20": "",
//                "strMeasure1": "250g",
//                "strMeasure2": "225g",
//                "strMeasure3": "150g",
//                "strMeasure4": "Zest of 1",
//                "strMeasure5": "500g",
//                "strMeasure6": "250g",
//                "strMeasure7": "",
//                "strMeasure8": "",
//                "strMeasure9": "",
//                "strMeasure10": "",
//                "strMeasure11": "",
//                "strMeasure12": "",
//                "strMeasure13": "",
//                "strMeasure14": "",
//                "strMeasure15": "",
//                "strMeasure16": "",
//                "strMeasure17": "",
//                "strMeasure18": "",
//                "strMeasure19": "",
//                "strMeasure20": "",
//                "strSource": "",
//                "strImageSource": null,
//                "strCreativeCommonsConfirmed": null,
//                "dateModified": null
//            }
//        ]
//    }
//    """
//    let jsonDecoder = JSONDecoder()
//    let mealData = jsonDecoder.decode(MealDetail.self, from: Data(jsonString.utf8))
//    MealDetailCardView(mealDetail: mealData)
//}
