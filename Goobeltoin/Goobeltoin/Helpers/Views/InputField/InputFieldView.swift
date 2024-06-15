//
//  InputFieldView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 14.06.2024.
//

import SwiftUI

struct InputFieldView: View {
    var title: String
    @Binding var text: String
    var isRightButton = false
    
    var onRightButton: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .foregroundStyle(Colors.blueLite.swiftUIColor)
            RoundedCorner(radius: 15, corners: .allCorners)
                .foregroundStyle(.white)
                .frame(height: 70)
                .overlay {
                    RoundedCorner(radius: 15, corners: .allCorners)
                        .stroke(Colors.blueDark.swiftUIColor,
                                lineWidth: 1.0)
                }
                .overlay {
                    HStack {
                        if isRightButton {
                            Text(text)
                                .foregroundStyle(Colors.blackCustom.swiftUIColor)
                                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                                .onTapGesture {
                                    onRightButton?()
                                }
                            
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    onRightButton?()
                                }
                            } label: {
                                Asset.arrowDown.swiftUIImage
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24)
                                    .padding(.horizontal)
                            }
                        } else {
                            TextField(text: $text) {
                                Text("Введите данные...")
                                    .foregroundStyle(Colors.blueDark.swiftUIColor)
                                    .font(Fonts.SFProDisplay.lightItalic.swiftUIFont(size: 16))
                                    
                            }
                            .foregroundStyle(Colors.blackCustom.swiftUIColor)
                            .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                        }
                    }
                    .padding(.horizontal)
                }
        }
    }
}

#Preview {
    InputFieldView(title: "Размер дохода", text: .constant(""))
}
