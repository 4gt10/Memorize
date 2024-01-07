//
//  Pie.swift
//  Memorize
//
//  Created by 4gt10 on 07.01.2024.
//

import SwiftUI

struct Pie: Shape {
    let fillPercentage: Double
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let startAngleDegrees = -90.0
            path.move(to: center)
            path.addArc(
                center: center,
                radius: min(rect.width, rect.height) / 2,
                startAngle: .degrees(startAngleDegrees),
                endAngle: .degrees((360.0  * fillPercentage) + startAngleDegrees),
                clockwise: false
            )
        }
    }
}

#Preview {
    Pie(fillPercentage: 0.5)
        .fill(Color.blue)
}
