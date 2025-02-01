//
//  CustomTabBar.swift
//  InstantNews
//
//  Created by Lucas on 30/01/2025.
//

import SwiftUI

enum TabBarType: CaseIterable {
    case news, favorite
}

struct CustomTabBar: View {
    @Binding var selectedTab: TabBarType
    
    var body: some View {
        HStack(spacing: 45) {
            ForEach(TabBarType.allCases, id: \.self) { tab in
                Image(systemName: fetchIconName(type: tab))
                    .scaleEffect(tab == selectedTab ? 1.1 : 1.0)
                    .foregroundColor(tab == selectedTab ? .white : .black.opacity(0.8))
                    .font(.system(size: 18))
                    .onTapGesture {
                        withAnimation(.spring(response: 0.2, dampingFraction: 0.9, blendDuration: 0)) {
                            selectedTab = tab
                        }
                    }
                    .padding(.vertical)
                    .padding(.horizontal, tab == selectedTab ? 40 : 15)
                    .background(tab == selectedTab ? LinearGradient(colors: [.darkCharcoal.opacity(0.8), .white.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing) : nil)
                    .clipShape(.capsule)
            }
        }
        .frame(height: 60)
        .padding(.horizontal, 4.5)
        .background(.white)
        .clipShape(.capsule)
        .shadow(color: .darkCharcoal.opacity(0.25), radius: 5)
        .padding(.horizontal, 25)
    }
    
    func fetchIconName(type: TabBarType) -> String {
        var imageName = ""
        switch type {
        case .news: imageName = "house"
        case .favorite: return "heart"
        }
        
        if type == selectedTab {
            imageName += ".fill"
        }
        
        return imageName
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(.news))
}
