//
//  ThemedDivider.swift
//  Retriever
//
//  Created by Kyle Rohr on 4/12/2024.
//

import SwiftUI

struct ThemedDivider: View {
    let color: Color

    init(color: Color = .gray) {
        self.color = color
    }

    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: 1)
    }
}

#Preview {
    ThemedDivider()
}
