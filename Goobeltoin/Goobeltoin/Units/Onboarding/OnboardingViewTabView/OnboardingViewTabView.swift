//
//  OnboardingViewTabView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 12.06.2024.
//

import SwiftUI

struct OnboardingViewTabView: View {
    @State private var currentPageIndex = 0
    
    var body: some View {
        TabView(selection: $currentPageIndex) {
            OnboardingView(item: .first)
                .tag(0)
            
            OnboardingView(item: .second)
                .tag(1)
            
            OnboardingView(item: .third)
                .tag(2)
        }
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .indexViewStyle(.page(backgroundDisplayMode: .never))
    }
}

#Preview {
    OnboardingViewTabView()
}
