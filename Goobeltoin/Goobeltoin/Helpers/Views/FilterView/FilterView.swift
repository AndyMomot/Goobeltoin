//
//  FilterView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import SwiftUI

struct FilterView: View {
    
    @State private var showItems = false
    @State private var items = Item.allCases
    @State private var selectedItem: Item?
    
    var onSelect: (Item) -> Void
    
    init(items: [Item] = Item.allCases, onSelect: @escaping (Item) -> Void) {
        self.items = items
        self.onSelect = onSelect
    }
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Сортировать")
                    .foregroundStyle(.black)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 12))
                
                Spacer()
                
                Button {
                    withAnimation {
                        showItems.toggle()
                    }
                } label: {
                    Asset.arrowDown.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24)
                        .padding(.horizontal)
                        .rotationEffect(.degrees(showItems ? 180 : 0))
                }
            }
            
            if showItems {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(items, id: \.rawValue) { item in
                            var isSelectedItem: Bool {
                                guard let selectedItem = selectedItem,
                                      item.rawValue == selectedItem.rawValue
                                else { return false }
                                return true
                            }
                            
                            Button {
                                selectedItem = item
                                onSelect(item)
                                withAnimation {
                                    showItems.toggle()
                                }
                            } label: {
                                HStack {
                                    Text(item.rawValue)
                                        .foregroundStyle(
                                            isSelectedItem ? .white : .black
                                        )
                                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 12))
                                        .padding(.horizontal, 8)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                                .padding(.vertical, 10)
                                .background {
                                    isSelectedItem ? Colors.blueCustom.swiftUIColor : .clear
                                }
                                .cornerRadius(8, corners: .allCorners)
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .background(Colors.grayCustom.swiftUIColor)
        .cornerRadius(48, corners: .allCorners)
    }
}

extension FilterView {
    enum Item: String, CaseIterable {
        case az = "А - Я"
        case za = "Я - А"
        case firstBankDeposits = "Сначала Банковские вклады"
        case firstBuyBonds = "Сначала Покупка облигаций"
        case firstCryptocurrency = "Сначала Криптовалюта"
        case businessFirst = "Сначала Бизнес"
        case firstVendingMachines = "Сначала Торговые автоматы"
        case firstRentingOutYourHome = "Сначала Сдача жилья в аренду"
        case firstRentingEquipmentTransport = "Сначала Сдача в аренду техники, транспорта"
        case firstAdvertisingCars = "Сначала Реклама на авто"
        case firstInformationProducts = "Сначала Инфопродукты"
        case firstIntellectualProperty = "Сначала Интеллектуальная собственность"
    }
}

#Preview {
    FilterView() { _ in }
}
