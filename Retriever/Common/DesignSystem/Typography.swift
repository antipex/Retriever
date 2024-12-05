//
//  Typography.swift
//  Retriever
//
//  Created by Kyle Rohr on 3/12/2024.
//

import SwiftUI

public enum Typography: String, CaseIterable {
    case title
    case subtitle
    case jumbo

    case heading1
    case heading2
    case heading3
    case heading4

    case info

    case listLabel
    case listValue

    case bodyS
    case bodyM
    case bodyL
    case bodyXL

    case caption
    case label
}

extension Font {
    static func lato(
        _ size: CGFloat,
        weight: Font.Weight = .regular
    ) -> Font {
        switch weight {
        case .thin, .ultraLight:
            Font.custom("Lato Thin", size: size)
        case .light:
            Font.custom("Lato Light", size: size)
        case .regular, .medium:
            Font.custom("Lato Regular", size: size)
        case .bold, .semibold:
            Font.custom("Lato Bold", size: size)
        case .black, .heavy:
            Font.custom("Lato Black", size: size)
        default:
            Font.custom("Lato Regular", size: size)
        }
    }

    static func fjalla(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        Font.custom("Fjalla One", size: size).weight(weight)
    }
}

struct TypographyModifier: ViewModifier {
    let typography: Typography

    func body(content: Content) -> some View {
        switch typography {
        case .title:
            content
                .font(.fjalla(48))
                .textCase(.uppercase)
        case .subtitle:
            content
                .font(.lato(24, weight: .light))
                .textCase(.uppercase)
                .kerning(5)
        case .jumbo:
            content
                .font(.fjalla(72))
                .textCase(.uppercase)
        case .heading1:
            content
                .font(.fjalla(36))
                .textCase(.uppercase)
        case .heading2:
            content
                .font(.fjalla(24))
                .textCase(.uppercase)
        case .heading3:
            content
                .font(.fjalla(18))
                .textCase(.uppercase)
        case .heading4:
            content
                .font(.fjalla(14))
                .textCase(.uppercase)
        case .info:
            content
                .font(.lato(13, weight: .light))
                .textCase(.uppercase)
                .kerning(2)
        case .listLabel:
            content
                .font(.lato(24, weight: .light))
        case .listValue:
            content
                .font(.lato(24, weight: .bold))
        case .bodyS:
            content
                .font(.lato(11))
        case .bodyM:
            content
                .font(.lato(12))
        case .bodyL:
            content
                .font(.lato(16))
        case .bodyXL:
            content
                .font(.lato(18))
        case .caption:
            content
                .font(.lato(10))
        case .label:
            content
                .font(.lato(10))
        }
    }
}

public extension View {
    func typography(_ typography: Typography) -> some View {
        modifier(TypographyModifier(typography: typography))
    }
}

#Preview("Typography") {
    VStack(spacing: .Spacing.five) {
        ForEach(Typography.allCases, id: \.rawValue) { item in
            Text(item.rawValue.capitalized)
                .modifier(TypographyModifier(typography: item))
        }
    }
}
