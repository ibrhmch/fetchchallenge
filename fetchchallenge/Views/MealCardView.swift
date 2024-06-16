//
//  MealViewCard.swift
//  fetchchallenge
//
//  Created by octopus on 6/9/24.
//

import SwiftUI
import Kingfisher

struct MealCardView: View {
    let meal: Meal
    
    var body: some View {
        ZStack(alignment: .bottom) {
            KFImage(URL(string: meal.thumbnail))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipped()
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal)

            Text(meal.name)
                .font(.headline)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(LinearGradient(gradient: Gradient(colors: [.black.opacity(0.8), .clear]), startPoint: .bottom, endPoint: .top))
        }
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}

#Preview {
    MealCardView(meal: Meal(id: "1", name: "Sample Meal", thumbnail: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"))
}
