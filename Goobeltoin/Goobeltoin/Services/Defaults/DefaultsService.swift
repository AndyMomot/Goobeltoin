//
//  DefaultsService.swift
//
//  Created by Andrii Momot on 16.04.2024.
//

import Foundation

final class DefaultsService {
    static let standard = UserDefaults.standard
    private init() {}
}

extension DefaultsService {
    static var flow: ContentView.ViewState {
        get {
            let name = standard.string(forKey: Keys.flow.rawValue) ?? ""
            return ContentView.ViewState(rawValue: name) ?? .onboarding
        }
        set {
            standard.set(newValue.rawValue, forKey: Keys.flow.rawValue)
        }
    }
    
    static var passiveIncomes: [PassiveIncomeView.PassiveIncomeItem] {
        get {
            if let data = standard.object(forKey: Keys.passiveIncome.rawValue) as? Data {
                let items = try? JSONDecoder().decode([PassiveIncomeView.PassiveIncomeItem].self, from: data)
                return items ?? []
            }
            return []
        }
        set {
            let items = newValue.sorted(by: { $0.date > $1.date })
            if let data = try? JSONEncoder().encode(items) {
                standard.setValue(data, forKey: Keys.passiveIncome.rawValue)
            }
        }
    }
    
    static func addPassiveIncome(item: PassiveIncomeView.PassiveIncomeItem) {
        var items = passiveIncomes
        items.append(item)
        passiveIncomes = items
    }
    
    static func deletePassiveIncome(item: PassiveIncomeView.PassiveIncomeItem) {
        if let index = passiveIncomes.firstIndex(where: {
            $0.id == item.id
        }) {
            var items = passiveIncomes
            items.remove(at: index)
            passiveIncomes = items
        }
    }
}

extension DefaultsService {
    static var profile: ProfileView.ProfileModel? {
        get {
            if let data = standard.object(forKey: Keys.profile.rawValue) as? Data {
                let profile = try? JSONDecoder().decode(ProfileView.ProfileModel.self, from: data)
                return profile
            }
            return nil
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                standard.setValue(data, forKey: Keys.profile.rawValue)
            }
        }
    }
}

extension DefaultsService {
    static func removeAll() {
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            standard.removePersistentDomain(forName: bundleIdentifier)
            FileManagerService().removeAllFiles()
        }
    }
}

// MARK: - Keys
extension DefaultsService {
    enum Keys: String {
        case flow
        case passiveIncome
        case profile
    }
}
