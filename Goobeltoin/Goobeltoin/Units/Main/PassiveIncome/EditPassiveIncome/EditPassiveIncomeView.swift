//
//  EditPassiveIncomeView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 14.06.2024.
//

import SwiftUI

struct EditPassiveIncomeView: View {
    
    var item: PassiveIncomeView.PassiveIncomeItem
    var onDismiss: ((Bool) -> Void)?
    
    @StateObject private var viewModel = EditPassiveIncomeViewModel()
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
                        onDismiss?(false)
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
                        
                        InputFieldView(title: "Размер дохода",
                                       text: $viewModel.amountText)
                        .keyboardType(.numberPad)
                    }
                    
                    BlueButton(title: "Внести данные") {
                        viewModel.onUpdate(item: item) {
                            dismiss.callAsFunction()
                            onDismiss?(true)
                        }
                    }
                    .padding()
                    .padding(.bottom)
                }
                .padding()
                .background(.white)
                .cornerRadius(48, corners: [.topLeft, .topRight])
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.selectedPassiveIncomeItem = item.type
            viewModel.amountText = item.income.string()
        }
    }
}

#Preview {
    EditPassiveIncomeView(item: .init(
        type: .bankDeposit,
        title: "Test",
        income: 1000,
        incomePeriod: .month)) {_ in}
}
