//
//  TabBarCustomView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import SwiftUI

struct TabBarCustomView: View {
    @Binding var selectedItem: Int
    
    @State private var items: [TabBar.Item] = [
        .init(imageName: Asset.tab1.name),
        .init(imageName: Asset.tab2.name),
        .init(imageName: Asset.tab3.name)
    ]
    
    private var arrange: [Int] {
        Array(0..<items.count)
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 48)
            .foregroundStyle(Colors.blueCustom.swiftUIColor)
            .overlay {
                HStack {
                    ForEach(arrange, id: \.self) { index in
                        let item = items[index]
                        let isSelectedItem = index == selectedItem
                        
                        Button {
                            selectedItem = index
                        } label: {
                            Image(item.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 40)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 14)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(
                                            isSelectedItem ? .white : .clear,
                                            lineWidth: 1
                                        )
                                }
                        }
                        
                        if index < arrange.count - 1 {
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal)
            }
    }
}

#Preview {
    TabBarCustomView(selectedItem: .constant(0))
        .previewLayout(.fixed(width: 393, height: 48))
}
