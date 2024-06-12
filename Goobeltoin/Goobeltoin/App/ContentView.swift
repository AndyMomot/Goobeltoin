//
//  ContentView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 10.06.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    var body: some View {
        Group {
            if viewModel.showPreloader {
                PreloaderView()
            } else {
                switch viewModel.viewState {
                case .onboarding:
                    OnboardingViewTabView()
                        .environmentObject(viewModel)
                case .main:
                    Text("Tab Bar")
//                    TabBar()
//                        .environmentObject(viewModel)
                }
            }
        }
        .onAppear {
            withAnimation {
                self.viewModel.getFlow()
            }
        }
    }
}

#Preview {
    ContentView()
}
