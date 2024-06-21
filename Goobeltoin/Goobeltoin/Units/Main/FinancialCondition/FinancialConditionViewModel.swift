//
//  FinancialConditionViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 21.06.2024.
//

import Foundation

extension FinancialConditionView {
    final class FinancialConditionViewModel: ObservableObject {
        
        @Published var date = Date()
        
        @Published var showProfile = false
        @Published var showAnalize = false
        
        @Published var incomeItems: [PassiveIncomeView.PassiveIncomeItem] = []
        @Published var chartItems: [ChartModel] = []
        @Published var mostEffectiveIncomeTypes: [PassiveIncomeView.PassiveIncomeItem.ItemType] = []
        
        func onTopItemTapped(_ item: TopButtonsView.Item) {
            switch item {
            case .profile:
                showProfile.toggle()
            case .notifications:
                break
            }
        }
        
        func getIncomeItems() {
            DispatchQueue.main.async { [weak self] in
                let passiveIncomes = DefaultsService.passiveIncomes
                self?.incomeItems = passiveIncomes
                self?.mostEffectiveIncomeTypes = passiveIncomes.sorted(by: {
                    $0.incomePerMonth > $1.incomePerMonth
                }).map { $0.type }
            }
        }
        
        func getChartItems() {
            chartItems.removeAll()
            
            var chartsData: [ChartModel] = []
            for income in DefaultsService.passiveIncomes {
                chartsData.append(.init(
                    date: income.date,
                    image: income.type.image,
                    title: income.type.title,
                    amount: income.incomePerMonth
                ))
            }
            
            let filtredChartsData = chartsData.filter {
                $0.date.toString(format: .yyyy) == date.toString(format: .yyyy)
            }.filter {
                $0.date.toString(format: .mmYY) == date.toString(format: .mmYY)
            }
            
            chartItems = filtredChartsData
        }
        
        func onYearAction(_ action: CustomSwitcher.Action) {
            switch action {
            case .left:
                date = date.addOrSubtract(component: .year, value: -1)
            case .right:
                date = date.addOrSubtract(component: .year, value: 1)
            }
            
            getChartItems()
        }
        
        func onMonthAction(_ action: CustomSwitcher.Action) {
            switch action {
            case .left:
                date = date.addOrSubtract(component: .month, value: -1)
            case .right:
                date = date.addOrSubtract(component: .month, value: 1)
            }
            
            getChartItems()
        }
    }
}

extension FinancialConditionView {
    struct ChartModel: Identifiable {
        private(set) var id = UUID().uuidString
        var date: Date
        var image: String
        var title: String
        var amount: Double
    }
}
