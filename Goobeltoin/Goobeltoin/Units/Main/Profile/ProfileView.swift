//
//  ProfileView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 18.06.2024.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ProfileViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            Asset.background2.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 67) {
                HStack {
                    Button {
                        dismiss.callAsFunction()
                    } label: {
                        Asset.arrowDown.swiftUIImage
                            .rotationEffect(.degrees(90))
                            .padding()
                    }
                    
                    Spacer()
                }
                
                Rectangle()
                    .foregroundStyle(.white)
                    .cornerRadius(48, corners: [.topLeft, .topRight])
            }
            
            VStack(spacing: 60) {
                
                VStack(alignment: .center, spacing: 35) {
                    viewModel.profileImage
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: bounds.width * 0.4,
                            height: bounds.width * 0.4
                        )
                        .clipShape(Circle())
                        .overlay {
                            Circle()
                                .stroke(.white, lineWidth: 8)
                        }
                        .padding(.top, bounds.width * 0.1)
                    
                    VStack(alignment: .center, spacing: 17) {
                        Text(viewModel.fullName)
                        Text(viewModel.phone)
                        Text(viewModel.email)
                    }
                    .foregroundStyle(Colors.blackCustom.swiftUIColor)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(fixedSize: 20))
                    .multilineTextAlignment(.center)
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text("Ваши действующие виды пасивного дохода")
                            .foregroundStyle(Colors.blackCustom.swiftUIColor)
                            .font(Fonts.SFProDisplay.bold.swiftUIFont(fixedSize: 22))
                            .lineLimit(2)
                            .minimumScaleFactor(0.5)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    ScrollView {
                        LazyVGrid(columns: (0..<2).map { _ in GridItem(.flexible()) }, spacing: 10) {
                            ForEach(viewModel.itemTypes) { item in
                                PassiveIncomeOptionCell(item: item)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Spacer()
                            Text("УДАЛИТЬ ПРОФИЛЬ")
                                .foregroundStyle(Colors.redCustom.swiftUIColor)
                                .font(Fonts.SFProDisplay.medium.swiftUIFont(fixedSize: 20))
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            viewModel.getIncomeItems()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ProfileView()
}
