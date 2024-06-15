//
//  AddNewPassiveIncomeView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 15.06.2024.
//

import SwiftUI

struct AddNewPassiveIncomeView: View {
    @StateObject private var viewModel = AddNewPassiveIncomeViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var onDismiss: (() -> Void)?
    
    var body: some View {
        ZStack {
            Asset.background1.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 47) {
                HStack {
                    Button {
                        dismiss.callAsFunction()
                        onDismiss?()
                    } label: {
                        Asset.arrowDown.swiftUIImage
                            .rotationEffect(.degrees(90))
                            .padding()
                    }

                    Spacer()
                }
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 14) {
                        HStack {
                            Spacer()
                            Text("Добавление нового пасивного дохода")
                                .foregroundStyle(Colors.blackCustom.swiftUIColor)
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 24))
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                        
                        InputFieldView(
                            title: "Название вашего дохода",
                            text: $viewModel.incomeName
                        )
                        
                        InputFieldView(
                            title: "Тип дохода",
                            text: $viewModel.incomeTypeName,
                            isRightButton: true
                        ) {
                            withAnimation {
                                viewModel.showDropDown.toggle()
                            }
                        }
                        
                        if viewModel.showDropDown {
                            IncomeTypeDropDownView { item in
                                withAnimation {
                                    viewModel.incomeTypeName = item.title
                                    viewModel.showDropDown.toggle()
                                }
                                viewModel.selectedItemType = item
                            }
                        }
                        
                        InputFieldView(
                            title: "Приблизительная сумма дохода",
                            text: $viewModel.incomeAmountText
                        )
                        .keyboardType(.numberPad)
                        
                        InputFieldView(
                            title: "Частота дохода",
                            text: $viewModel.incomePeriod,
                            isRightButton: true
                        ) {
                            withAnimation {
                                viewModel.showIncomePeriodDropDown.toggle()
                            }
                        }
                        
                        if viewModel.showIncomePeriodDropDown {
                            IncomePeriodDropDownView { item in
                                withAnimation {
                                    viewModel.incomePeriod = item.rawValue
                                    viewModel.showIncomePeriodDropDown.toggle()
                                }
                                viewModel.selectedIncomePeriod = item
                            }
                        }
                        
                        BlueButton(title: "Добавить") {
                            viewModel.onAddTapped {
                                dismiss.callAsFunction()
                                onDismiss?()
                            }
                        }
                    }
                    .padding(.top, 35)
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .background(.white)
                .cornerRadius(48, corners: [.topLeft, .topRight])
            }
        }
        .navigationBarBackButtonHidden()
        .onTapGesture {
            hideKeyboard()
        }
    }
}

#Preview {
    AddNewPassiveIncomeView()
}
