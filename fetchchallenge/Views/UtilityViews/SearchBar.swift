//
//  SearchBar.swift
//  fetchchallenge
//
//  Created by octopus on 6/9/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String = "Search"

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField(placeholder, text: $text)
            }
            
            if !text.isEmpty {
                Button("Cancel") {
                    text = ""
                }
                .foregroundColor(Color.primary)
                .padding(.vertical, 6)
                .padding(.horizontal, 7)
                .background(Color(UIColor.systemBackground))
                .cornerRadius(7)
                
                Spacer()
            }
        }
        .underlineTextField()
        .padding()
        .background(Color(UIColor.systemBackground))
    }
}

#Preview {
    SearchBar(text: .constant(""))
}
