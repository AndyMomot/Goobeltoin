//
//  AnalysisView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 19.06.2024.
//

import SwiftUI

struct AnalysisView: View {
    @StateObject private var viewModel = AnalysisViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Asset.background2.swiftUIImage
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 18) {
                    HStack {
                        Spacer()
                        TopButtonsView { item in
                            viewModel.onTopItemTapped(item)
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Анализ доходов и прогноз прибыли")
                                .foregroundStyle(Colors.blackCustom.swiftUIColor)
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 24))
                                .padding(.top)
                            
                            Text("Мы подсчитали ваш среднемесячный пасивный доход и ваша прогнозированая прибыль составляет: \(viewModel.totalIncome.string())")
                                .foregroundStyle(Colors.blackCustom.swiftUIColor)
                                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                            
                            if viewModel.showChart {
                                PieChartCustomView(
                                    values: viewModel.values,
                                    titles: viewModel.titles,
                                    names: viewModel.names,
                                    formatter: {
                                        value in String(format: "$%.2f", value)
                                    },
                                    colors: viewModel.colors,
                                    images: viewModel.images,
                                    backgroundColor: .white
                                )
                                
                                if !viewModel.values.isEmpty {
                                    PieChartRows(
                                        colors: viewModel.colors,
                                        images: viewModel.images,
                                        titles: viewModel.titles,
                                        names: viewModel.names,
                                        values: viewModel.values.map {
                                            $0.string()
                                        },
                                        percents: viewModel.values.map {
                                            String(format: "%.0f%%", $0 * 100 / viewModel.values.reduce(0, +))
                                        })
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(48, corners: [.topLeft, .topRight])
                }
            }
            .onAppear {
                viewModel.setData()
            }
            .navigationDestination(isPresented: $viewModel.showProfile) {
                ProfileView()
            }
        }
    }
}

#Preview {
    AnalysisView()
}
