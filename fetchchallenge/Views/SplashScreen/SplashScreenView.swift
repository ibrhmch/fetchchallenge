//
//  SplashScreenView.swift
//  fetchchallenge
//
//  Created by octopus on 6/10/24.
//


import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack {
                Image(systemName: "hare.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.green)
                Text("Fetch Challenge")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
            }
            .scaleEffect(size)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeIn(duration: 1.2)) {
                    self.size = 1.0
                    self.opacity = 1.0
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
