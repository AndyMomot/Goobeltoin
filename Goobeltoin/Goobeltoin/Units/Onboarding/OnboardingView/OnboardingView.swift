//
//  OnboardingView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 12.06.2024.
//

import SwiftUI

struct OnboardingView: View {
    var item: OnboardingView.OnboardingItem
    
    @EnvironmentObject private var rootViewModel: ContentView.ContentViewModel
    @StateObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 50) {
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                        
                        VStack(spacing: 20) {
                            Text(item.title)
                            Text(item.subtitle)
                        }
                        .foregroundStyle(.black)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 18))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 18)
                        
                        let arrange = Array(0..<item.count)
                        HStack(spacing: 14) {
                            Spacer()
                            ForEach(arrange, id: \.self) { index in
                                var color: Color {
                                    if index == item.position {
                                        return Colors.blue.swiftUIColor
                                    } else {
                                        return Colors.grayCustom.swiftUIColor
                                    }
                                }
                                
                                Circle()
                                    .foregroundStyle(color)
                                    .frame(width: 12)
                            }
                            Spacer()
                        }
                        
                        VStack(spacing: 16) {
                            BlueButton(title: "Начать") {
                                rootViewModel.setFlow(.main)
                            }
                            .padding(.horizontal)
                            
                            Button {
                                viewModel.showPrivacyPolicy.toggle()
                            } label: {
                                VStack(spacing: 4) {
                                    Text("Выбрав “Начать” Я согласен с")
                                        .foregroundStyle(Colors.blackCustom.swiftUIColor)
                                    
                                    Text("политикой конфиденциальности")
                                        .foregroundStyle(Colors.blueLite.swiftUIColor)
                                }
                                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 14))
                                .multilineTextAlignment(.center)
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .ignoresSafeArea(edges: .top)
        }
        .sheet(isPresented: $viewModel.showPrivacyPolicy) {
            if let url = viewModel.privacyPolicyURL {
                WebView(url: viewModel.privacyPolicyURL)
            }
        }
    }
}

#Preview {
    OnboardingView(item: .first)
}
