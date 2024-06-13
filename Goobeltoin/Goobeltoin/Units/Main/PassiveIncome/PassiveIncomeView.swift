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
                                
                            }
                            
                            Spacer()
                            
                            VStack {
                                SearchView(text: $viewModel.searchText)
                                Spacer()
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical)
                }
                .padding()
                .background(.white)
                .cornerRadius(48, corners: [.topLeft, .topRight])
                .ignoresSafeArea(edges: .bottom)
                .overlay {
                    VStack {
                        Spacer()
                        
                        Button {
                            print("plus")
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
    }
}

#Preview {
    PassiveIncomeView()
}
