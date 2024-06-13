//
//  PreloaderView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 10.06.2024.
//

import SwiftUI

struct PreloaderView: View {
    @StateObject private var viewModel = PreloaderViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Asset.loadingBackground.swiftUIImage
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 34) {
                Spacer()
                
                Asset.logo.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 100)
                
                Asset.logoTitle.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 106)
                
                Spacer()
            }
            
            VStack {
                Spacer()
                
                VStack(alignment: .center, spacing: 17) {
                    Text("Загрузка...")
                        .foregroundStyle(Colors.blueCustom.swiftUIColor)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(fixedSize: 16))
                    
                    ProgressView(value: viewModel.progress)
                        .tint(Colors.blueCustom.swiftUIColor)
                        .frame(height: 8)
                }
                .padding(.horizontal, 18)
                .padding(.bottom, 130)
            }
        }
        .onReceive(viewModel.timer) { input in
            DispatchQueue.main.async {
                withAnimation {
                    viewModel.updateProgress()
                }
            }
        }
    }
}

#Preview {
    PreloaderView()
}
