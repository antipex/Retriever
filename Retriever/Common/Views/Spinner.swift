//
//  Spinner.swift
//  Retriever
//
//  Created by Kyle Rohr on 4/12/2024.
//

import SwiftUI

struct Spinner: View {
    @State private var rotationDegrees = 0.0

    var body: some View {
        Image(systemName: "circle.dotted")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxHeight: 96)
            .rotationEffect(.degrees(rotationDegrees))
            .onAppear {
                withAnimation(Animation.linear(duration: 5).repeatForever(autoreverses: false)) {
                    rotationDegrees = 360
                }
            }
    }
}

#Preview {
    ThemedNavigationView(title: "Spinner Test") {
        ZStack {
            Spinner()
        }
    }
}
