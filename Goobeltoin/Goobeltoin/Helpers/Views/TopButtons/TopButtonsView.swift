//
//  TopButtonsView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import SwiftUI

struct TopButtonsView: View {
    var onSelect: (Item) -> Void
    
    @State private var items: [Item] = [
        .profile,
        .notifications
    ]
    
    @State private var profileImage: Image = Asset.profileIcon.swiftUIImage
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(items, id: \.rawValue) { item in
                Button {
                    onSelect(item)
                } label: {
                    if item == .profile {
                        profileImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 41, height: 41)
                            .clipShape(Circle())
                            .overlay {
                                Circle()
                                    .stroke(.white, lineWidth: 3)
                            }
                    } else {
                        Image(item.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 41, height: 41)
                            .clipShape(Circle())
                    }
                }
            }
        }
        .onAppear {
            DispatchQueue.main.async {
                withAnimation {
                    self.getProfileImage()
                }
            }
        }
    }
}

private extension TopButtonsView {
    func getProfileImage() {
        guard let pathID = DefaultsService.profile?.id else {
            profileImage = Asset.profileIcon.swiftUIImage
            return
        }
        let path = FileManagerService.Keys.profileImage(id: pathID).path
        guard let data = FileManagerService().getFile(forPath: path),
              let uiImage = UIImage(data: data)
        else {
            profileImage = Asset.profileIcon.swiftUIImage
            return
        }
        
        profileImage = Image(uiImage: uiImage)
    }
}

extension TopButtonsView {
    enum Item: String {
        case profile
        case notifications
        
        var image: String {
            switch self {
            case .profile:
                return Asset.profileIcon.name
            case .notifications:
                return Asset.notificationsIcon.name
            }
        }
    }
}

#Preview {
    TopButtonsView() { _ in }
}
