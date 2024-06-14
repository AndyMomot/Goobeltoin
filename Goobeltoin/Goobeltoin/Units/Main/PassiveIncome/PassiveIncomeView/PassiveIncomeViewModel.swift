//
//  PassiveIncomeViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import Foundation

extension PassiveIncomeView {
    final class PassiveIncomeViewModel: ObservableObject {
        @Published var searchText = ""
        @Published var showAddPassiveIncome = false
    }
}

extension PassiveIncomeView {
    struct PassiveIncomeItem: Identifiable, Codable {
        private(set) var id = UUID().uuidString
        private(set) var date = Date()
        var type: ItemType
        var title: String
        var income: Double
    }
}

extension PassiveIncomeView.PassiveIncomeItem {
    enum ItemType: String, Codable, CaseIterable {
        case bankDeposit
        case buyingBonds
        case cryptocurrency
        case business
        case vendingMachines
        case rentingHousing
        case rentingEquipmentTransport
        case advertisingCars
        case infoProducts
        case intellectualProperty
        
        var title: String {
            switch self {
            case .bankDeposit:
                return "Банковский вклад"
            case .buyingBonds:
                return "Покупка облигаций"
            case .cryptocurrency:
                return "Криптовалюта"
            case .business:
                return "Бизнес"
            case .vendingMachines:
                return "Торговые автоматы"
            case .rentingHousing:
                return "Сдача жилья в аренду"
            case .rentingEquipmentTransport:
                return "Сдача в аренду техники, транспорта"
            case .advertisingCars:
                return "Реклама на авто"
            case .infoProducts:
                return "Инфопродукты"
            case .intellectualProperty:
                return "Интелектуальная собственность"
            }
        }
        
        var image: String {
            rawValue
        }
    }
}
