//
//  ThemedNavigationView.swift
//  Retriever
//
//  Created by Kyle Rohr on 4/12/2024.
//

import SwiftUI

private struct GeometryPreference: PreferenceKey {
    typealias Value = CGFloat

    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

struct ThemedNavigationView<LeadingItems: View, TrailingItems: View, Content: View>: View {
    @State private var navBarHeight: CGFloat = 0

    let title: String?
    let leadingItems: () -> LeadingItems
    let trailingItems: () -> TrailingItems
    let content: () -> Content

    init(
        title: String? = nil,
        @ViewBuilder leadingItems: @escaping () -> LeadingItems,
        @ViewBuilder trailingItems: @escaping () -> TrailingItems,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.content = content
        self.leadingItems = leadingItems
        self.trailingItems = trailingItems
    }

    var body: some View {
        ZStack {
            content()
                .offset(y: navBarHeight)

            VStack {
                ThemedNavigationBar(title: title, leadingItems: leadingItems, trailingItems: trailingItems)
                    .background {
                        GeometryReader { proxy in
                            Color.clear.preference(
                                key: GeometryPreference.self,
                                value: proxy.size.height
                            )
                        }
                    }
                    .onPreferenceChange(GeometryPreference.self) { value in
                        navBarHeight = value
                    }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .typography(.bodyL)
    }
}

extension ThemedNavigationView where LeadingItems == EmptyView, TrailingItems == EmptyView {
    init(title: String? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
        self.leadingItems = { EmptyView() }
        self.trailingItems = { EmptyView() }
    }
}

extension ThemedNavigationView where LeadingItems == NavigationBarItem, TrailingItems == EmptyView {
    static func withBackButton(
        title: String? = nil,
        action: @escaping Callback,
        @ViewBuilder content: @escaping () -> Content
    ) -> ThemedNavigationView {
        return ThemedNavigationView(title: title) {
            NavigationBarItem(kind: .back, action: action)
        } trailingItems: {
            EmptyView()
        } content: {
            content()
        }
    }
}

private struct ThemedNavigationBar<LeadingItems: View, TrailingItems: View>: View {
    let title: String?
    let leadingItems: () -> LeadingItems
    let trailingItems: () -> TrailingItems

    init(
        title: String?,
        @ViewBuilder leadingItems: @escaping () -> LeadingItems,
        @ViewBuilder trailingItems: @escaping () -> TrailingItems
    ) {
        self.title = title
        self.leadingItems = leadingItems
        self.trailingItems = trailingItems
    }

    var body: some View {
        VStack {
            ZStack {
                HStack {
                    leadingItems()

                    Spacer()

                    trailingItems()
                }
                .padding([.leading, .trailing], 16)

                if let title {
                    Text(title)
                        .typography(.heading2)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .padding([.leading, .trailing], 60)
                }
            }

            ThemedDivider(color: .gray.opacity(0.3))
        }
    }
}

#Preview {
    ThemedNavigationView(title: "Hello") {
        VStack {
            Text("Testing")
        }
    }
}

//#Preview("RecipeList") {
//    RecipeListView(viewModel: .debug)
//}

struct NavigationBarItem: View {
    let kind: Kind
    let action: Callback

    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: imageName(for: kind))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 16)
                .padding(16)
        }
    }

    private func imageName(for kind: Kind) -> String {
        switch kind {
        case .close: return "xmark"
        case .back: return "chevron.left"
        case .add: return "plus"
        case .custom(let name): return name
        }
    }
}

extension NavigationBarItem {
    enum Kind {
        case close
        case back
        case add
        case custom(String)
    }
}
