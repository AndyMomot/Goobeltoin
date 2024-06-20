//
//  AnalysisViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 19.06.2024.
//

import Foundation
import SwiftUI

extension AnalysisView {
    final class AnalysisViewModel: ObservableObject {
        @Published var showChart = false
        @Published var showProfile = false
        
        @Published var totalIncome: Double = 0
        @Published var values: [Double] = [0]
        @Published var titles: [String] = [""]
        @Published var names: [String] = [""]
        @Published var images: [Image] = [.init(systemName: "custom.doc.fill")]
        @Published var colors: [Color] = [.white]
        
        func setData() {
            let passiveIncomes = DefaultsService.passiveIncomes
            let incomeValues = passiveIncomes.map { $0.incomePerMonth }
            let titlesValues = passiveIncomes.map { $0.title }
            let namesValues = passiveIncomes.map { $0.type.title }
            let imageValues = passiveIncomes.map { Image($0.type.image) }
            let colorValues = passiveIncomes.map { $0.type.color }
            
            values = incomeValues.isEmpty ? [0] : incomeValues
            titles = titlesValues.isEmpty ? [""] : titlesValues
            names = namesValues.isEmpty ? [""] : namesValues
            images = imageValues.isEmpty ? [.init(systemName: "custom.doc.fill")] : imageValues
            colors = colorValues.isEmpty ? [.white] : colorValues
            
            totalIncome = values.reduce(0) { $0 + $1 }
            showChart = true
        }
        
        func onTopItemTapped(_ item: TopButtonsView.Item) {
            switch item {
            case .profile:
                showProfile.toggle()
            case .notifications:
                break
            }
        }
    }
}
