//
//  CustomSwitcher.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 21.06.2024.
//

import SwiftUI

struct CustomSwitcher: View {
    var title: String
    var onTap: (Action) -> Void
    
    var body: some View {
        HStack {
            Button {
                onTap(.left)
            } label: {
                Asset.arrowDown.swiftUIImage
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .rotationEffect(.degrees(90))
                    .frame(width: 24)
            }

            Text(title)
                .foregroundStyle(.white)
                .font(Fonts.SFProDisplay.regular.swiftUIFont(fixedSize: 12))
            
            Button {
                onTap(.right)
            } label: {
                Asset.arrowDown.swiftUIImage
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .rotationEffect(.degrees(-90))
                    .frame(width: 24)
            }
            
        }
    }
}

extension CustomSwitcher {
    enum Action {
        case left
        case right
    }
}

#Preview {
    CustomSwitcher(title: Date().toString(format: .yyyy)) { _ in
        
    }
    .background(Colors.blueCustom.swiftUIColor)
}
