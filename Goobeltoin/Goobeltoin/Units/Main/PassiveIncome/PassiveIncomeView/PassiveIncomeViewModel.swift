//
//  PassiveIncomeViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import Foundation

extension PassiveIncomeView {
    final class PassiveIncomeViewModel: ObservableObject {
        @Published var showAddPassiveIncome = false
        @Published var showEditPassiveIncome = false
        @Published var incomeItems: [PassiveIncomeView.PassiveIncomeItem] = []
        
        var passiveIncomeToEdit: PassiveIncomeView.PassiveIncomeItem?
        
        func getIncomeItems() {
            DispatchQueue.main.async { [weak self] in
                self?.incomeItems = DefaultsService.passiveIncomes
            }
        }
        
        func sortIncomeItems(with sort: FilterView.Item) {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                let passiveIncomes = DefaultsService.passiveIncomes
                
                switch sort {
                case .az:
                    self.incomeItems = passiveIncomes.sorted {
                        $0.title.localizedCompare($1.title) == .orderedAscending
                    }
                case .za:
                    self.incomeItems = passiveIncomes.sorted {
                        $0.title.localizedCompare($1.title) == .orderedDescending
                    }
                case .firstBankDeposits:
                    self.incomeItems = passiveIncomes.sorted { (itemOne, itemTwo) -> Bool in
                        let isTypeOne = itemOne.type == .bankDeposit
                        let isTypeTwo = itemTwo.type == .bankDeposit
                        
                        if isTypeOne && !isTypeTwo {
                            return true
                        } else if !isTypeOne && isTypeTwo {
                            return false
                        } else {
                            return itemOne.title.localizedCompare(itemTwo.title) == .orderedAscending
                        }
                    }
                case .firstBuyBonds:
                    self.incomeItems = passiveIncomes.sorted { (itemOne, itemTwo) -> Bool in
                        let isTypeOne = itemOne.type == .buyingBonds
                        let isTypeTwo = itemTwo.type == .buyingBonds
                        
                        if isTypeOne && !isTypeTwo {
                            return true
                        } else if !isTypeOne && isTypeTwo {
                            return false
                        } else {
                            return itemOne.title.localizedCompare(itemTwo.title) == .orderedAscending
                        }
                    }
                case .firstCryptocurrency:
                    self.incomeItems = passiveIncomes.sorted { (itemOne, itemTwo) -> Bool in
                        let isTypeOne = itemOne.type == .cryptocurrency
                        let isTypeTwo = itemTwo.type == .cryptocurrency
                        
                        if isTypeOne && !isTypeTwo {
                            return true
                        } else if !isTypeOne && isTypeTwo {
                            return false
                        } else {
                            return itemOne.title.localizedCompare(itemTwo.title) == .orderedAscending
                        }
                    }
                case .businessFirst:
                    self.incomeItems = passiveIncomes.sorted { (itemOne, itemTwo) -> Bool in
                        let isTypeOne = itemOne.type == .business
                        let isTypeTwo = itemTwo.type == .business
                        
                        if isTypeOne && !isTypeTwo {
                            return true
                        } else if !isTypeOne && isTypeTwo {
                            return false
                        } else {
                            return itemOne.title.localizedCompare(itemTwo.title) == .orderedAscending
                        }
                    }
                case .firstVendingMachines:
                    self.incomeItems = passiveIncomes.sorted { (itemOne, itemTwo) -> Bool in
                        let isTypeOne = itemOne.type == .vendingMachines
                        let isTypeTwo = itemTwo.type == .vendingMachines
                        
                        if isTypeOne && !isTypeTwo {
                            return true
                        } else if !isTypeOne && isTypeTwo {
                            return false
                        } else {
                            return itemOne.title.localizedCompare(itemTwo.title) == .orderedAscending
                        }
                    }
                case .firstRentingOutYourHome:
                    self.incomeItems = passiveIncomes.sorted { (itemOne, itemTwo) -> Bool in
                        let isTypeOne = itemOne.type == .rentingHousing
                        let isTypeTwo = itemTwo.type == .rentingHousing
                        
                        if isTypeOne && !isTypeTwo {
                            return true
                        } else if !isTypeOne && isTypeTwo {
                            return false
                        } else {
                            return itemOne.title.localizedCompare(itemTwo.title) == .orderedAscending
                        }
                    }
                case .firstRentingEquipmentTransport:
                    self.incomeItems = passiveIncomes.sorted { (itemOne, itemTwo) -> Bool in
                        let isTypeOne = itemOne.type == .rentingEquipmentTransport
                        let isTypeTwo = itemTwo.type == .rentingEquipmentTransport
                        
                        if isTypeOne && !isTypeTwo {
                            return true
                        } else if !isTypeOne && isTypeTwo {
                            return false
                        } else {
                            return itemOne.title.localizedCompare(itemTwo.title) == .orderedAscending
                        }
                    }
                case .firstAdvertisingCars:
                    self.incomeItems = passiveIncomes.sorted { (itemOne, itemTwo) -> Bool in
                        let isTypeOne = itemOne.type == .advertisingCars
                        let isTypeTwo = itemTwo.type == .advertisingCars
                        
                        if isTypeOne && !isTypeTwo {
                            return true
                        } else if !isTypeOne && isTypeTwo {
                            return false
                        } else {
                            return itemOne.title.localizedCompare(itemTwo.title) == .orderedAscending
                        }
                    }
                case .firstInformationProducts:
                    self.incomeItems = passiveIncomes.sorted { (itemOne, itemTwo) -> Bool in
                        let isTypeOne = itemOne.type == .infoProducts
                        let isTypeTwo = itemTwo.type == .infoProducts
                        
                        if isTypeOne && !isTypeTwo {
                            return true
                        } else if !isTypeOne && isTypeTwo {
                            return false
                        } else {
                            return itemOne.title.localizedCompare(itemTwo.title) == .orderedAscending
                        }
                    }
                case .firstIntellectualProperty:
                    self.incomeItems = passiveIncomes.sorted { (itemOne, itemTwo) -> Bool in
                        let isTypeOne = itemOne.type == .intellectualProperty
                        let isTypeTwo = itemTwo.type == .intellectualProperty
                        
                        if isTypeOne && !isTypeTwo {
                            return true
                        } else if !isTypeOne && isTypeTwo {
                            return false
                        } else {
                            return itemOne.title.localizedCompare(itemTwo.title) == .orderedAscending
                        }
                    }
                }
            }
        }
        
        func search(containing character: String)  {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                let passiveIncomes = DefaultsService.passiveIncomes
                self.incomeItems = passiveIncomes.filter {
                    $0.title.localizedCaseInsensitiveContains(character) ||
                    $0.type.title.localizedCaseInsensitiveContains(character)
                }
            }
        }
    }
}

extension PassiveIncomeView {
    struct PassiveIncomeItem: Identifiable, Codable {
        private(set) var id = UUID().uuidString
        private(set) var date = Date()
        var type: ItemType
        var title: String
        var income: Double
        var incomePeriod: IncomePeriod
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
    
    enum IncomePeriod: String, Codable, CaseIterable {
        case week = "Неделя"
        case month = "Месяц"
        case quarter = "Квартал"
        case sixMonths = "Полгода"
        case year = "Год"
    }
}
