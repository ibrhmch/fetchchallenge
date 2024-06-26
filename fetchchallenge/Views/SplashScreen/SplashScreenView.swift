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
            withAnimation(.easeIn(duration: 1.2)) {
                ContentView()
            }
        } else {
            VStack {
                VStack {
                    Image(systemName: "carrot.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.primary)
                    Text("Fetch a Meal")
                        .font(.system(size: 30, weight: .ultraLight, design: .monospaced))
                        .foregroundColor(.primary)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
