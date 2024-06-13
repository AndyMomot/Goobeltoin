//
//  TabBarViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import Foundation

extension TabBar {
    final class TabBarViewModel: ObservableObject {
        @Published var selection = TabBarSelectionView.passiveIncome.rawValue
    }
}

extension TabBar {
    enum TabBarSelectionView: Int {
        case analysis = 0
        case passiveIncome
        case financialCondition
    }
    
    struct Item: Identifiable {
        private(set) var id = UUID()
        var imageName: String
    }
}
