//
//  PieChartView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 20.06.2024.
//

import SwiftUI

struct PieChartCustomView: View {
    let values: [Double]
    let titles: [String]
    let names: [String]
    let formatter: (Double) -> String
    
    var colors: [Color]
    var images: [Image]
    var backgroundColor: Color
    
    var widthFraction: CGFloat
    var innerRadiusFraction: CGFloat
    
    @State private var activeIndex: Int = -1
    
    var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var slices: [PieSliceData] {
        let sum = values.reduce(0, +)
        var endDeg: Double = 0
        var tempSlices: [PieSliceData] = []
        
        for (i, value) in values.enumerated() {
            let degrees: Double = value * 360 / sum
            tempSlices.append(
                PieSliceData(startAngle: Angle(degrees: endDeg),
                             endAngle: Angle(degrees: endDeg + degrees), text: String(format: "%.0f%%", value * 100 / sum), color: self.colors[i]))
            endDeg += degrees
        }
        return tempSlices
    }
    
    init(values:[Double],
         titles: [String],
         names: [String],
         formatter: @escaping (Double) -> String,
         colors: [Color] = [Color.blue, Color.green, Color.orange],
         images: [Image] = [
            Asset.bankDeposit.swiftUIImage,
            Asset.cryptocurrency.swiftUIImage,
            Asset.rentingHousing.swiftUIImage,
         ],
         backgroundColor: Color = .white,
         widthFraction: CGFloat = 0.9,
         innerRadiusFraction: CGFloat = 0.35) {
        
        self.values = values
        self.titles = titles
        self.names = names
        self.formatter = formatter
        
        self.colors = colors
        self.images = images
        self.backgroundColor = backgroundColor
        self.widthFraction = widthFraction
        self.innerRadiusFraction = innerRadiusFraction
    }
    
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                let arrange = Array(0..<self.values.count)
                ForEach(arrange, id: \.self) { index in
                    PieCustomSlice(pieSliceData: self.slices[index])
                        .scaleEffect(self.activeIndex == index ? 1.03 : 1)
                }
                .frame(width: widthFraction * bounds.width, height: widthFraction * bounds.width)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            let radius = 0.5 * widthFraction * bounds.width
                            let diff = CGPoint(x: value.location.x - radius, y: radius - value.location.y)
                            let dist = pow(pow(diff.x, 2.0) + pow(diff.y, 2.0), 0.5)
                            if (dist > radius || dist < radius * innerRadiusFraction) {
                                withAnimation {
                                    self.activeIndex = -1
                                }
                                return
                            }
                            var radians = Double(atan2(diff.x, diff.y))
                            if (radians < 0) {
                                radians = 2 * Double.pi + radians
                            }
                            
                            for (i, slice) in slices.enumerated() {
                                if (radians < slice.endAngle.radians) {
                                    withAnimation {
                                        self.activeIndex = i
                                    }
                                    break
                                }
                            }
                        }
                        .onEnded { value in
                            withAnimation {
                                self.activeIndex = -1
                            }
                        }
                )
                Circle()
                    .fill(Colors.blueCustom.swiftUIColor)
                    .frame(width: widthFraction * bounds.width * innerRadiusFraction, height: widthFraction * bounds.width * innerRadiusFraction)
                    .overlay {
                        Circle()
                            .stroke(.white, lineWidth: 4)
                    }
                
                
                VStack {
                    if self.activeIndex != -1 {
                        VStack {
                            Text(titles[self.activeIndex])
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 20))
                            .foregroundStyle(.white)
                            
                            Text(names[self.activeIndex])
                                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                                .foregroundStyle(Colors.grayCustom.swiftUIColor)
                        }
                    }
                    
                    Text(self.formatter(self.activeIndex == -1 ? values.reduce(0, +) : values[self.activeIndex]))
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 20))
                        .foregroundStyle(.white)
                }
            }
            .frame(minHeight: bounds.width)
        }
        .padding(.horizontal)
        .background(self.backgroundColor)
        .foregroundColor(Color.white)
    }
}

struct PieChartRows: View {
    var colors: [Color]
    var images: [Image]
    var titles: [String]
    var names: [String]
    var values: [String]
    var percents: [String]
    
    var body: some View {
        VStack {
            let arrange = Array(0..<self.values.count)
            ForEach(arrange, id: \.self) { index in
                HStack {
                    
                    images[index]
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Circle()
                                .foregroundStyle(colors[index])
                                .frame(width: 16)
                            
                            Text(self.titles[index])
                                .foregroundStyle(Colors.blackCustom.swiftUIColor)
                            .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 18))
                        }
                        
                        Text(self.names[index])
                            .foregroundStyle(Colors.grayCustom.swiftUIColor)
                            .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 18))
                    }
                    
                    Spacer(minLength: 20)
                    
                    VStack(alignment: .trailing) {
                        Text(self.values[index])
                        Text(self.percents[index])
                        
                    }
                    .foregroundColor(Colors.grayCustom.swiftUIColor)
                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                }
            }
        }
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartCustomView(
            values: [1300, 500, 300],
            titles: [
                "Аренда авто",
                "Проезд в метро",
                "Покупка книг"
            ],
            names: ["Rent", "Transport", "Education Education Education"], formatter: {value in String(format: "$%.2f", value)})
    }
}



