//
//  ProfileViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 18.06.2024.
//

import Foundation
import SwiftUI

extension ProfileView {
    final class ProfileViewModel: ObservableObject {
        @Published var isEditing = false
        @Published var showImagePicker = false
        
        @Published var profileImage: UIImage = Asset.profileIcon.image
        @Published var fullName = ""
        @Published var phone = ""
        @Published var email = ""
        @Published var profile: ProfileModel?
        @Published var itemTypes: [PassiveIncomeView.PassiveIncomeItem.ItemType] = []
        
        var isValidFields: Bool {
            !fullName.isEmpty && !phone.isEmpty && !email.isEmpty
        }
        
        func getProfile() {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.profile = DefaultsService.profile
                self.fullName = profile?.fullName ?? ""
                self.phone = profile?.phone ?? ""
                self.email = profile?.email ?? ""
                self.getProfileImage()
                
                if self.profile == nil {
                    isEditing = true
                }
            }
        }
        
        func setProfile(completion: @escaping () -> Void) {
            guard isValidFields else { return }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                guard var oldProfile = DefaultsService.profile else {
                    var newProfile = ProfileView.ProfileModel()
                    newProfile.fullName = self.fullName
                    newProfile.phone = self.phone
                    newProfile.email = self.email
                    
                    DefaultsService.profile = newProfile
                    self.setProfileImage(pathID: newProfile.id)
                    
                    self.getProfile()
                    completion()
                    return
                }
                
                oldProfile.fullName = self.fullName
                oldProfile.phone = self.phone
                oldProfile.email = self.email
                DefaultsService.profile = oldProfile
                self.setProfileImage(pathID: oldProfile.id)
                
                self.getProfile()
                completion()
            }
        }
        
        func setProfileImage(pathID: String) {
            guard profileImage != Asset.profilePlaceholder.image,
                  let imageData = self.profileImage.jpegData(compressionQuality: 1),
                  UIImage(data: imageData) != nil
            else {
                return
            }
            
            let path = FileManagerService.Keys.profileImage(id: pathID).path
            FileManagerService().saveFile(data: imageData, forPath: path)
        }
        
        func getProfileImage() {
            guard let pathID = profile?.id else {
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
                self?.itemTypes = DefaultsService.passiveIncomes.map {
                    $0.type
                }
            }
        }
        
        func deleteProfile() {
            DispatchQueue.main.async { [weak self] in
                DefaultsService.removeAll()
                
                self?.getProfile()
                self?.getIncomeItems()
            }
        }
    }
}


extension ProfileView {
    struct ProfileModel: Codable {
        private(set) var id = UUID().uuidString
        var fullName, phone, email: String?
    }
}
