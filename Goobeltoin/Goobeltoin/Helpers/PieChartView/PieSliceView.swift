//
//  PieSliceView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 20.06.2024.
//


import SwiftUI

struct PieCustomSlice: View {
    var pieSliceData: PieSliceData
    
    var midRadians: Double {
        return Double.pi / 2.0 - (pieSliceData.startAngle + pieSliceData.endAngle).radians / 2.0
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path { path in
                    let width: CGFloat = min(geometry.size.width,
                                             geometry.size.height)
                    let height = width
                    path.move(
                        to: CGPoint(
                            x: width * 0.5,
                            y: height * 0.5
                        )
                    )
                    
                    path.addArc(
                        center: CGPoint(
                            x: width * 0.5,
                            y: height * 0.5),
                        radius: width * 0.5,
                        startAngle: Angle(degrees: -89.0) + pieSliceData.startAngle,
                        endAngle: Angle(degrees: -91.0) + pieSliceData.endAngle, 
                        clockwise: false)
                    
                }
                .fill(pieSliceData.color)
                
                Text(pieSliceData.text)
                    .foregroundColor(Colors.blackCustom.swiftUIColor)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 12))
                    .padding(10)
                    .background(.white)
                    .cornerRadius(48, corners: .allCorners)
                    .position(
                        x: geometry.size.width * 0.5 * CGFloat(1.0 + 0.78 * cos(self.midRadians)),
                        y: geometry.size.height * 0.5 * CGFloat(1.0 - 0.78 * sin(self.midRadians))
                    )
                    
                    
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

struct PieSliceData {
    var startAngle: Angle
    var endAngle: Angle
    var text: String
    var color: Color
}

struct PieSlice_Previews: PreviewProvider {
    static var previews: some View {
        PieCustomSlice(pieSliceData: PieSliceData(startAngle: Angle(degrees: 0.0), endAngle: Angle(degrees: 120.0), text: "30%", color: Color.black))
    }
}

