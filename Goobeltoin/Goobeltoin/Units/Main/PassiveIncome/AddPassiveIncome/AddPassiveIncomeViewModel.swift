//
//  AddPassiveIncomeViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 14.06.2024.
//

import Foundation

extension AddPassiveIncomeView {
    final class AddPassiveIncomeViewModel: ObservableObject {
        let passiveIncomeItems = PassiveIncomeView.PassiveIncomeItem.ItemType.allCases
        @Published var selectedPassiveIncomeItem: PassiveIncomeView.PassiveIncomeItem.ItemType?
        @Published var name = ""
        @Published var amountText = ""
        
        func compareIncomeItems(input: PassiveIncomeView.PassiveIncomeItem.ItemType) -> Bool {
            guard let selectedPassiveIncomeItem = self.selectedPassiveIncomeItem else {
                return false
            }
            return input.rawValue == selectedPassiveIncomeItem.rawValue
        }
        
        func onSaveData(completion: @escaping () -> Void) {
            guard let itemType = selectedPassiveIncomeItem,
                  !name.isEmpty,
                  !amountText.isEmpty,
                  let amount = Double(amountText),
                  amount > .zero
            else { return }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                let model = PassiveIncomeView.PassiveIncomeItem(
                    type: itemType,
                    title: name,
                    income: amount
                )
                
                DefaultsService.addPassiveIncome(item: model)
                completion()
            }
        }
    }
}
