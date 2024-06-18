//
//  PassiveIncomeView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import SwiftUI

struct PassiveIncomeView: View {
    @StateObject private var viewModel = PassiveIncomeViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Asset.background1.swiftUIImage
                    .resizable()
                    .ignoresSafeArea()
                
                
                VStack(spacing: 18) {
                    HStack {
                        Spacer()
                        TopButtonsView { item in
                            
                        }
                    }
                    .padding(.horizontal)
                    
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 24) {
                            HStack {
                                Text("Ваши пасивные доходы")
                                    .foregroundStyle(Colors.blackCustom.swiftUIColor)
                                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 24))
                                Spacer()
                            }
                            
                            HStack(alignment: .top) {
                                FilterView() { item in
                                    withAnimation {
                                        viewModel.sortIncomeItems(with: item)
                                    }
                                }
                                
                                Spacer()
                                
                                VStack {
                                    SearchView() { searchText in
                                        if searchText.isEmpty {
                                            viewModel.getIncomeItems()
                                        } else {
                                            viewModel.search(containing: searchText)
                                        }
                                    }
                                    Spacer()
                                }
                            }
                            
                            ScrollView(showsIndicators: false) {
                                VStack(spacing: 10) {
                                    ForEach(viewModel.incomeItems) { item in
                                        PassiveIncomeCell(item: item) { action in
                                            viewModel.onPassiveIncomeCell(action: action)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(48, corners: [.topLeft, .topRight])
                    .overlay {
                        VStack {
                            Spacer()
                            
                            Button {
                                viewModel.showAddPassiveIncome.toggle()
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill(Colors.grayCustom.swiftUIColor)
                                        .frame(
                                            width: UIScreen.main.bounds.width * 0.2)
                                        .overlay {
                                            Circle().stroke(Color.white, lineWidth: 7)
                                                .overlay {
                                                    Image(systemName: "plus")
                                                        .foregroundStyle(.black)
                                                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 28))
                                                }
                                        }
                                }
                            }
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $viewModel.showAddPassiveIncome) {
                AddNewPassiveIncomeView {
                    viewModel.getIncomeItems()
                    viewModel.successScreenText = "Ваш новый доход успешно добавлен!"
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        viewModel.showSuccessScreen.toggle()
                    }
                }
            }
            .navigationDestination(isPresented: $viewModel.showEditPassiveIncome) {
                if let item = viewModel.passiveIncomeToEdit {
                    EditPassiveIncomeView(item: item) {
                        viewModel.getIncomeItems()
                        viewModel.successScreenText = "Вашы данные  успешно внесены!"
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            viewModel.showSuccessScreen.toggle()
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $viewModel.showSuccessScreen) {
                SuccessView(text: viewModel.successScreenText)
            }
        }
        .onAppear {
            viewModel.getIncomeItems()
        }
    }
}

#Preview {
    PassiveIncomeView()
}
