//
//  PassiveIncomeCell.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 15.06.2024.
//

import SwiftUI

struct PassiveIncomeCell: View {
    var item: PassiveIncomeView.PassiveIncomeItem
    var onPlus: () -> Void
    
    var body: some View {
        HStack(spacing: 20) {
            Image(item.type.image)
                .resizable()
                .scaledToFit()
                .cornerRadius(48, corners: .allCorners)
            
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(item.type.title)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 14))
                    Text(item.title)
                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 10))
                }
                .foregroundStyle(Colors.blackCustom.swiftUIColor)
                
                Text(item.income.string() + " | \(item.incomePeriod.rawValue)")
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 10))
                    .foregroundStyle(Colors.blackCustom.swiftUIColor)
                
                HStack {
                    Spacer()
                    Button {
                        onPlus()
                    } label: {
                        Circle()
                            .foregroundStyle(Colors.blueLite.swiftUIColor)
                            .frame(width: 41)
                            .overlay {
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(.white)
                                    .padding(10)
                                    
                            }
                    }

                }
            }
            .padding(.trailing)
        }
        .background(Colors.grayCustom.swiftUIColor)
        .cornerRadius(48, corners: .allCorners)
    }
}

#Preview {
    PassiveIncomeCell(item: .init(
        type: .bankDeposit,
        title: "Вклад в СберБанк",
        income: 500, 
        incomePeriod: .month)
    ) {}
}
