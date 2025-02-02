//
//  NewsTypeButtonView.swift
//  InstantNews
//
//  Created by Lucas on 31/01/2025.
//

import SwiftUI

struct NewsTypeButtonView: View {
    let isSelected: Bool

    let name: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(name.capitalized)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(isSelected ? .white : .darkCharcoal)
                .padding(.vertical, 8)
                .padding(.horizontal)
                .background(isSelected ? .darkCharcoal : .white)
                .clipShape(.rect(cornerRadius: 10))
        }
        .sensoryFeedback(.impact(flexibility: .soft, intensity: 1), trigger: isSelected)
    }
}

#Preview {
    NewsTypeButtonView(isSelected: true, name: "Tous", action: {})
}
