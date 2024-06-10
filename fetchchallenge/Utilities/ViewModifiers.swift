//
//  ViewModifiers.swift
//  fetchchallenge
//
//  Created by octopus on 6/9/24.
//

import SwiftUI

extension View {
    func underlineTextField() -> some View {
        self
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .foregroundColor(.gray)
            .padding(10)
    }
}
