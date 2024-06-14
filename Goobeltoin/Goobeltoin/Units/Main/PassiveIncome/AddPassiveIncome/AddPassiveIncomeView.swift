//
//  AddPassiveIncomeView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 14.06.2024.
//

import SwiftUI

struct AddPassiveIncomeView: View {
    @StateObject private var viewModel = AddPassiveIncomeViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Asset.background1.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 47) {
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
                
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 54) {
                            HStack {
                                Text("Добавление прибыли")
                                    .foregroundStyle(Colors.blackCustom.swiftUIColor)
                                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 28))
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(viewModel.passiveIncomeItems, id: \.rawValue) { item in
                                        
                                        let isSelected = viewModel.compareIncomeItems(input: item)
                                        
                                        Button {
                                            withAnimation {
                                                viewModel.selectedPassiveIncomeItem = item
                                            }
                                        } label: {
                                            PassiveIncomeOptionCell(item: item)
                                                .overlay {
                                                    if isSelected {
                                                        RoundedRectangle(cornerRadius: 48)
                                                            .stroke(.black, lineWidth: 1)
                                                    }
                                                }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.vertical)
                        
                        VStack(spacing: 20) {
                            InputFieldView(title: "Название источника доходов",
                                           text: $viewModel.name)
                            
                            InputFieldView(title: "Размер дохода",
                                           text: $viewModel.amountText)
                            .keyboardType(.numberPad)
                        }
                    }
                    
                    BlueButton(title: "Внести данные") {
                        viewModel.onSaveData {
                            dismiss.callAsFunction()
                        }
                    }
                    .padding()
                    .padding(.bottom,
                             UIScreen.main.bounds.height * 0.1)
                }
                .padding()
                .background(.white)
                .cornerRadius(48, corners: [.topLeft, .topRight])
                
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    AddPassiveIncomeView()
}
