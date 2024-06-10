//
//  MealViewCard.swift
//  fetchchallenge
//
//  Created by octopus on 6/9/24.
//

import SwiftUI

struct MealCardView: View {
    let meal: Meal
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: meal.thumbnail)) { phase in
                switch phase {
                case .empty:
                    Color.gray.opacity(0.3)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                case .failure:
                    Color.red.opacity(0.3)
                @unknown default:
                    Color.gray.opacity(0.3)
                }
            }
            .frame(height: 200)
            .clipped()
            
            Text(meal.name)
                .font(.headline)
                .fontWeight(.thin)
                .foregroundColor(.white)
                .padding()
                .background(Color.black.opacity(0.7))
                .cornerRadius(10)
                .padding(4)
        }
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
#Preview {
    MealCardView(meal: Meal(id: "1", name: "Sample Meal", thumbnail: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"))
}
