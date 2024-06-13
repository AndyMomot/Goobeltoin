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
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(items, id: \.rawValue) { item in
                Button {
                    onSelect(item)
                } label: {
                    Image(item.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 41, height: 41)
                }

            }
        }
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
