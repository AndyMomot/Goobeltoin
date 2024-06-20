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
    
    var body: some View {
        ZStack {
            Asset.background2.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            Rectangle()
                .foregroundStyle(.white)
                .cornerRadius(48, corners: [.topLeft, .topRight])
                .padding(.top, 70)
            
            VStack(spacing: 30) {
                HStack {
                    Asset.pencile.swiftUIImage
                        .padding()
                        .hidden()
                    
                    Spacer()
                    Image(uiImage: viewModel.profileImage)
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
                        .overlay {
                            if viewModel.isEditing {
                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        Button {
                                            viewModel.showImagePicker.toggle()
                                        } label: {
                                            Asset.camera.swiftUIImage
                                                .shadow(color: .white,
                                                        radius: 3)
                                        }
                                    }
                                }
                                .padding()
                            }
                        }
                    Spacer()
                    
                    Button {
                        withAnimation {
                            viewModel.isEditing.toggle()
                        }
                    } label: {
                        Asset.pencile.swiftUIImage
                    }
                    .padding()
                    .hidden(viewModel.profile == nil)
                }
                .padding(.top, bounds.width * 0.1)
                
                ScrollView(showsIndicators: false) {
                    if viewModel.isEditing {
                        VStack(alignment: .center, spacing: 17) {
                            InputFieldView(
                                title: "ФИО",
                                text: $viewModel.fullName
                            )
                            
                            InputFieldView(
                                title: "Телефон",
                                text: $viewModel.phone
                            )
                            
                            InputFieldView(
                                title: "Mail",
                                text: $viewModel.email
                            )
                            
                            
                            Button {
                                viewModel.setProfile {
                                    withAnimation {
                                        viewModel.isEditing.toggle()
                                    }
                                }
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("Сохранить")
                                        .foregroundStyle(Colors.blueCustom.swiftUIColor)
                                        .font(Fonts.SFProDisplay.medium.swiftUIFont(fixedSize: 20))
                                        .multilineTextAlignment(.center)
                                    Spacer()
                                }
                            }
                            .padding()
                            .opacity(viewModel.isValidFields ? 1 : 0.5)
                            
                        }
                        .padding(.horizontal)
                    } else {
                        VStack(alignment: .center, spacing: 17) {
                            if !viewModel.fullName.isEmpty {
                                Text(viewModel.fullName)
                            }
                            if !viewModel.phone.isEmpty {
                                Text(viewModel.phone)
                            }
                            if !viewModel.email.isEmpty {
                                Text(viewModel.email)
                            }
                        }
                        .foregroundStyle(Colors.blackCustom.swiftUIColor)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(fixedSize: 20))
                        .multilineTextAlignment(.center)
                    }
                    
                    if !viewModel.itemTypes.isEmpty {
                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                Text("Ваши действующие виды пасивного дохода")
                                    .foregroundStyle(Colors.blackCustom.swiftUIColor)
                                    .font(Fonts.SFProDisplay.bold.swiftUIFont(fixedSize: 22))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                                
                                Spacer()
                            }
                            LazyVGrid(columns: (0..<2).map { _ in GridItem(.flexible()) }, spacing: 10) {
                                ForEach(viewModel.itemTypes) { item in
                                    PassiveIncomeOptionCell(item: item)
                                }
                            }
                        }
                        .padding()
                    }
                }
                
                if viewModel.profile != nil || !viewModel.itemTypes.isEmpty {
                    Button {
                        viewModel.deleteProfile()
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
            
            VStack {
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
                
                Spacer()
            }
        }
        .onAppear {
            viewModel.getProfile()
            viewModel.getIncomeItems()
        }
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(selectedImage: $viewModel.profileImage)
        }
    }
}

#Preview {
    ProfileView()
}
