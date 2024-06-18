//
//  SuccessView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 18.06.2024.
//

import SwiftUI

struct SuccessView: View {
    var text: String
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Asset.background1.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                Spacer()
                
                Asset.logo.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 112)
                
                Text(text)
                    .minimumScaleFactor(0.5)
                    .foregroundStyle(Colors.blackCustom.swiftUIColor)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 37))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Asset.success.swiftUIImage
                    .resizable()
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.dismiss.callAsFunction()
            }
        }
    }
}

#Preview {
    SuccessView(text: "Ваш новый доход успешно добавлен!")
}
