//
//  AnalysisAndTipsView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 21.06.2024.
//

import SwiftUI

struct AnalysisAndTipsView: View {
    @StateObject private var viewModel = AnalysisAndTipsViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
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
                
                // Profile image
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
                .padding(.top, bounds.width * 0.1)
                
                ScrollView(showsIndicators: false) {
                    if !viewModel.itemTypes.isEmpty {
                        VStack(alignment: .leading, spacing: 26) {
                            
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Наивысшая эфективность")
                                    .foregroundStyle(Colors.blackCustom.swiftUIColor)
                                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                                    .padding(.horizontal)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 16) {
                                        ForEach(viewModel.itemTypes) { item in
                                            PassiveIncomeOptionCell(item: item)
                                        }
                                    }
                                }
                                .padding(.leading)
                            }
                                
                                Text("""
                                     Проанализировав все вашы виды пасивного дохода, мы сделали вывод, что,  одним из наиболее ефективных есть \(viewModel.itemTypes.first?.title ?? "???"). Поэтому для вас будет выгодно инвестировать в этом направлении, так как этот вид дохода приносит вам наибольший доход.
                                     """)
                                .foregroundStyle(Colors.blackCustom.swiftUIColor)
                                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                                .padding(.horizontal)
                                
                                if let topIncome = viewModel.incomeItems.first {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack {
                                            PassiveIncomeOptionCell(item: topIncome.type)
                                            
                                            VStack(alignment: .leading) {
                                                Text(topIncome.incomePerMonth.string())
                                                Text("в месяц")
                                            }
                                            .foregroundStyle(Colors.blackCustom.swiftUIColor)
                                            .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 10))
                                            
                                            Spacer()
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Самая низкая эфективность")
                                    .foregroundStyle(Colors.blackCustom.swiftUIColor)
                                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                                    .padding(.horizontal)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 16) {
                                        ForEach(viewModel.itemTypes.reversed()) { item in
                                            PassiveIncomeOptionCell(item: item)
                                        }
                                    }
                                }
                                .padding(.leading)
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
            
            // Navigation button layer
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
            viewModel.getProfileImage()
            viewModel.getIncomeItems()
        }
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(selectedImage: $viewModel.profileImage)
        }
    }
}

#Preview {
    AnalysisAndTipsView()
}
