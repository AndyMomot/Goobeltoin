//
//  ContentViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 12.06.2024.
//

import Foundation

extension ContentView {
    final class ContentViewModel: ObservableObject {
        @Published var showPreloader = true
        
        @Published var viewState: ViewState = .onboarding
        
        func getFlow() {
            viewState = DefaultsService.flow
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                guard let self = self else { return }
                self.showPreloader = false
            }
        }
        
        func setFlow(_ flow: ViewState) {
            DispatchQueue.main.async { [weak self] in
                DefaultsService.flow = flow
                self?.getFlow()
            }
        }
    }
}

extension ContentView {
    enum ViewState: String {
        case onboarding
        case main
    }
}