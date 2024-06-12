//
//  BlueButton.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 12.06.2024.
//

import SwiftUI

struct BlueButton: View {
    var title: String
    var onPress: () -> Void
    
    var body: some View {
        Button {
            onPress()
        } label: {
            HStack {
                Spacer()
                Text(title)
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 24))
                Spacer()
            }
            .padding(.vertical)
            .background(Colors.blue.swiftUIColor)
            .cornerRadius(8, corners: .allCorners)
        }

    }
}

#Preview {
    BlueButton(title: "Press me") {}
}
