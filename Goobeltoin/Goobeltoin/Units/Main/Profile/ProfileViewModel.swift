//
//  ProfileViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 18.06.2024.
//

import Foundation

extension ProfileView {
    final class ProfileViewModel: ObservableObject {
        @Published var profileImage = Asset.profilePlaceholder.swiftUIImage
        @Published var fullName = "Джон Доу"
        @Published var phone = "+777777777777"
        @Published var email = "johndoe@gmail.com"
        
        @Published var itemTypes: [PassiveIncomeView.PassiveIncomeItem.ItemType] = []
        
        func getIncomeItems() {
            DispatchQueue.main.async { [weak self] in
                self?.itemTypes = DefaultsService.passiveIncomes.map {
                    $0.type
                }
            }
        }
    }
}
