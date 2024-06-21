//
//  AnalysisAndTipsViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 21.06.2024.
//

import Foundation
import SwiftUI

extension AnalysisAndTipsView {
    final class AnalysisAndTipsViewModel: ObservableObject {
        @Published var isEditing = false
        @Published var showImagePicker = false
        
        @Published var profileImage: UIImage = Asset.profileIcon.image
        
        @Published var incomeItems: [PassiveIncomeView.PassiveIncomeItem] = []
        @Published var itemTypes: [PassiveIncomeView.PassiveIncomeItem.ItemType] = []
        
        func getProfileImage() {
            guard let pathID = DefaultsService.profile?.id else {
                profileImage = Asset.profileIcon.image
                return
            }
            let path = FileManagerService.Keys.profileImage(id: pathID).path
            guard let data = FileManagerService().getFile(forPath: path),
                  let uiImage = UIImage(data: data)
            else {
                profileImage = Asset.profileIcon.image
                return
            }
            
            profileImage = uiImage
        }
        
        func getIncomeItems() {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.incomeItems = DefaultsService.passiveIncomes.sorted(by: {
                    $0.incomePerMonth > $1.incomePerMonth
                })
                self.itemTypes = incomeItems.map { $0.type }
            }
        }
    }
}

