//
//  IncomeTypeDropDownView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 15.06.2024.
//

import SwiftUI

struct IncomeTypeDropDownView: View {
    var onSelect: (PassiveIncomeView.PassiveIncomeItem.ItemType) -> Void
    
    private let items = PassiveIncomeView.PassiveIncomeItem.ItemType.allCases
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(items, id: \.rawValue) { item in
                Button {
                    onSelect(item)
                } label: {
                    HStack(spacing: 15) {
                        Image(item.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                        
                        Text(item.title)
                            .foregroundStyle(Colors.blackCustom.swiftUIColor)
                            .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 12))
                        
                        Spacer()
                    }
                }

            }
            .padding(.vertical, 4)
            .padding(.horizontal)
        }
        .padding()
        .background(.white)
        .cornerRadius(48, corners: .allCorners)
        .overlay {
            RoundedRectangle(cornerRadius: 48)
                .stroke(
                    Colors.blueDark.swiftUIColor, 
                    lineWidth: 1.0
                )
        }
    }
}

#Preview {
    IncomeTypeDropDownView { _ in
        
    }
}
