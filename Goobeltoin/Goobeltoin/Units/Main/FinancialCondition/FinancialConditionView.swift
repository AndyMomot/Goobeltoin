//
//  FinancialConditionView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 21.06.2024.
//

import SwiftUI
import Charts

struct FinancialConditionView: View {
    @StateObject private var viewModel = FinancialConditionViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Asset.background2.swiftUIImage
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 40) {
                    HStack {
                        Spacer()
                        TopButtonsView { item in
                            viewModel.onTopItemTapped(item)
                        }
                    }
                    .padding(.horizontal)
                    
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 40) {
                            HStack {
                                Text("Анализ вашего финансового состояния и советы по его улучшению")
                                    .foregroundStyle(Colors.blackCustom.swiftUIColor)
                                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 24))
                                .padding(.top)
                                
                                Spacer()
                            }
                            
                            VStack(spacing: 10) {
                                HStack {
                                    CustomSwitcher(title: viewModel.date.toString(format: .yyyy)) { action in
                                        viewModel.onYearAction(action)
                                    }
                                    
                                    Spacer()
                                    
                                    CustomSwitcher(title: viewModel.date.toString(format: .month)) { action in
                                        viewModel.onMonthAction(action)
                                    }
                                }
                                .foregroundStyle(.white)
                                
                                Chart {
                                    let arrange = Array(0..<viewModel.chartItems.count)
                                    ForEach(arrange, id: \.self) { index in
                                        let item = viewModel.chartItems[index]
                                        BarMark(
                                            x: .value("Title", item.title),
                                            y: .value("Amount", item.amount))
                                        .annotation(position: index % 2 == 0 ? .top : .bottom) {
                                            Image(item.image)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 23, height: 23)
                                                .clipShape(Circle())
                                                .overlay {
                                                    Circle()
                                                        .stroke(.black, lineWidth: 1)
                                                }
                                        }
                                        .foregroundStyle(Colors.blackCustom.swiftUIColor.gradient)
                                        .cornerRadius(8)
                                    }
                                }
                                .chartXAxis(.hidden)
                                .chartYAxis {
                                    AxisMarks { mark in
                                        AxisGridLine()
                                            .foregroundStyle(.white)
                                    }
                                }
                                .frame(maxHeight: 100)
                            }
                            .padding()
                            .background(Colors.blueCustom.swiftUIColor)
                            .cornerRadius(29, corners: .allCorners)
                            
                            if !viewModel.mostEffectiveIncomeTypes.isEmpty {
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Наивысшая эфективность")
                                        .foregroundStyle(Colors.blackCustom.swiftUIColor)
                                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                                    
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 16) {
                                            ForEach(viewModel.mostEffectiveIncomeTypes) { item in
                                                PassiveIncomeOptionCell(item: item)
                                            }
                                        }
                                    }
                                }
                            }
                            
                            Button {
                                viewModel.showAnalize.toggle()
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("Расширенный анализ и советы")
                                        .foregroundStyle(Colors.blueLite.swiftUIColor)
                                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                                        .underline()
                                    
                                    Image(systemName: "arrow.right")
                                    Spacer()
                                }
                            }

                        }
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(48, corners: [.topLeft, .topRight])
                }
            }
            .navigationDestination(isPresented: $viewModel.showProfile) {
                ProfileView()
            }
            .navigationDestination(isPresented: $viewModel.showAnalize) {
                AnalysisAndTipsView()
            }
            .onAppear {
                viewModel.getChartItems()
                viewModel.getIncomeItems()
            }
        }
    }
}

#Preview {
    FinancialConditionView()
}
