//
//  AddNewPassiveIncomeViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 15.06.2024.
//

import Foundation

extension AddNewPassiveIncomeView {
    final class AddNewPassiveIncomeViewModel: ObservableObject {
        @Published var incomeName = ""
        @Published var incomeTypeName = "Введите название..."
        @Published var showDropDown = false
        @Published var incomeAmountText = ""
        @Published var incomePeriod = "Введите название..."
        @Published var showIncomePeriodDropDown = false
        
        var selectedItemType: PassiveIncomeView.PassiveIncomeItem.ItemType?
        var selectedIncomePeriod: PassiveIncomeView.PassiveIncomeItem.IncomePeriod?
        
        func onAddTapped(completion: @escaping () -> Void) {
            guard isValidData() else { return }
            guard let type = selectedItemType,
                  !incomeName.isEmpty,
                  let income = Double(incomeAmountText),
                  income > .zero,
                  let incomePeriod = selectedIncomePeriod
            else { return }
            
            let model = PassiveIncomeView.PassiveIncomeItem(
                type: type,
                title: incomeName,
                income: income,
                incomePeriod: incomePeriod)
            
            DefaultsService.addPassiveIncome(item: model)
            completion()
        }
        
        private func isValidData() -> Bool {
            let incomeAmount = Double(incomeAmountText) ?? .zero
            return !incomeName.isEmpty &&
            selectedItemType != nil &&
            incomeAmount > .zero &&
            selectedIncomePeriod != nil
        }
    }
}
