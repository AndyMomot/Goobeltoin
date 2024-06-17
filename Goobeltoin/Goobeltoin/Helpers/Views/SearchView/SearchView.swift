//
//  SearchView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import SwiftUI

struct SearchView: View {
    
    var onTextChanged: (String) -> Void
    
    @State private var text: String = ""
    @State private var showTextField = false
    
    var body: some View {
        HStack(spacing: 10) {
            
            if showTextField {
                TextField(text: $text) {
                    Text("Введите первую букву...")
                        .foregroundStyle(Colors.whiteDark.swiftUIColor)
                        .font(Fonts.SFProDisplay.thinItalic.swiftUIFont(size: 10))
                        .opacity(0.5)
                        .onChange(of: text) { value in
                            onTextChanged(text)
                        }
                }
                .foregroundStyle(.black)
                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 12))
            }
            
            Button {
                withAnimation {
                    showTextField.toggle()
                }
            } label: {
                Asset.searchIcon.swiftUIImage
            }

        }
        .padding()
        .background(Colors.grayCustom.swiftUIColor)
        .cornerRadius(48, corners: .allCorners)
    }
}

#Preview {
    SearchView() { _ in }
}
