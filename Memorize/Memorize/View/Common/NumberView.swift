//
//  NumberView.swift
//  Memorize
//
//  Created by 4gt10 on 07.01.2024.
//

import SwiftUI

struct NumberView: View {
    let number: Int
    
    var body: some View {
        if number != 0 {
            Text(number, format: .number.sign(strategy: .always()))
                .font(.largeTitle)
                .foregroundStyle(number > 0 ? .green : .red)
                .shadow(radius: 1, x: 1, y: 1)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
    }
}

#Preview {
    HStack {
        NumberView(number: -1)
        NumberView(number: +1)
        NumberView(number: 0)
    }
}
