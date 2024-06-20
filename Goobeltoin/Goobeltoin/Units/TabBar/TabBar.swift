//
//  TabBar.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import SwiftUI

struct TabBar: View {
    @StateObject private var viewModel = TabBarViewModel()
    
    var body: some View {
        TabView(selection: $viewModel.selection) {
            AnalysisView()
                .tag(TabBarSelectionView.analysis.rawValue)
            
            PassiveIncomeView()
                .tag(TabBarSelectionView.passiveIncome.rawValue)
            
            Text("Financial Condition")
                .tag(TabBarSelectionView.financialCondition.rawValue)
        }
        .edgesIgnoringSafeArea(.bottom)
        .overlay {
            VStack {
                Spacer()
                TabBarCustomView(selectedItem: $viewModel.selection)
                    .frame(height: UIScreen.main.bounds.height * 0.1)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

#Preview {
    TabBar()
}
