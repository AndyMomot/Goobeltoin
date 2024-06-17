//
//  PassiveIncomeOptionCell.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 14.06.2024.
//

import SwiftUI

struct PassiveIncomeOptionCell: View {
    var item: PassiveIncomeView.PassiveIncomeItem.ItemType
    
    var body: some View {
        HStack(spacing: 10) {
            Image(item.image)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 23, height: 23)
                .overlay {
                    Circle()
                        .stroke(.black, lineWidth: 1)
                }
            
            Text(item.title)
                .foregroundStyle(.black)
                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 10))
        }
        .padding()
        .background(Colors.grayCustom.swiftUIColor)
        .cornerRadius(48, corners: .allCorners)
        .shadow(radius: 2)
    }
}

#Preview {
    PassiveIncomeOptionCell(item: .cryptocurrency)
        .previewLayout(.fixed(width: 144, height: 41))
}
