//
//  EditPassiveIncomeViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 14.06.2024.
//

import Foundation

extension EditPassiveIncomeView {
    final class EditPassiveIncomeViewModel: ObservableObject {
        let passiveIncomeItems = PassiveIncomeView.PassiveIncomeItem.ItemType.allCases
        @Published var selectedPassiveIncomeItem: PassiveIncomeView.PassiveIncomeItem.ItemType?
        @Published var amountText = ""
        
        func compareIncomeItems(input: PassiveIncomeView.PassiveIncomeItem.ItemType) -> Bool {
            guard let selectedPassiveIncomeItem = self.selectedPassiveIncomeItem else {
                return false
            }
            return input.rawValue == selectedPassiveIncomeItem.rawValue
        }
        
        func onUpdate(item: PassiveIncomeView.PassiveIncomeItem, completion: @escaping () -> Void) {
            guard let itemType = selectedPassiveIncomeItem,
                  let amount = Double(amountText),
                  amount > .zero
            else { return }
            
            DispatchQueue.main.async {
                var newItem = item
                newItem.type = itemType
                newItem.income = amount
                
               var passiveIncomes = DefaultsService.passiveIncomes
                
                if let index = passiveIncomes.firstIndex(where: {
                    $0.id == item.id
                }) {
                    passiveIncomes[index] = newItem
                    DefaultsService.passiveIncomes = passiveIncomes
                    completion()
                }
            }
        }
    }
}
