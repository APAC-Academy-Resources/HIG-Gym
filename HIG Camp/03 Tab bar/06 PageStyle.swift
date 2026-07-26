//
//  06 PageStyle.swift
//  HIG Camp
//

import SwiftUI

struct PageStyleDemo: View {
    // MARK: - Variant
    enum Variant {
        case page
        case pageWithIcons
    }

    let variant: Variant

    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Tab View Styles",
        description: "`.page` turns a TabView into a swipeable carousel with an index dot control instead of a tab bar — swipe left and right. `.sidebarAdaptable` is the other alternative style: a tab bar on iPhone that becomes a sidebar on iPad and Mac.",
        systemImage: "square.stack"
    )

    // MARK: - State
    private let tint: Color = .orange
    private let pageCardShape = RoundedRectangle(cornerRadius: 48, style: .continuous)

    // MARK: - Body
    var body: some View {
        pages
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .tint(tint)
            .safeAreaBar(edge: .top) {
                infoCard
                    .padding(.horizontal)
            }
    }

    // MARK: - View Components
    @ViewBuilder
    private var pages: some View {
        switch variant {
        case .page:
            pageTabView
        case .pageWithIcons:
            pageTabViewWithIcons
        }
    }

    private var pageTabView: some View {
        TabView {
            pageContent("First")
            pageContent("Second")
            pageContent("Third")
            pageContent("Fourth")
        }
    }

    private var pageTabViewWithIcons: some View {
        TabView {
            Tab("First", systemImage: "1.circle") {
                pageContent("First")
            }
            Tab("Second", systemImage: "2.circle") {
                pageContent("Second")
            }
            Tab("Third", systemImage: "3.circle") {
                pageContent("Third")
            }
            Tab("Fourth", systemImage: "4.circle") {
                pageContent("Fourth")
            }
        }
    }

    private func pageContent(_ title: String) -> some View {
        VStack {
            VStack(alignment: .center) {
                Text(title)
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.primary)
                Text("Page")
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
        }
        .fixedSize()
        .frame(width: 240, height: 240)
        .background(.regularMaterial, in: pageCardShape)
        .background(.tint, in: pageCardShape)
    }
}

#Preview("Page") {
    PageStyleDemo(variant: .page)
}

#Preview("Page w/ Icons") {
    PageStyleDemo(variant: .pageWithIcons)
}
