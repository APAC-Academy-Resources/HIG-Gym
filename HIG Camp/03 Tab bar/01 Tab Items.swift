import SwiftUI

struct TabItemsDemoView: View {
    // MARK: - Variant
    enum Variant {
        case textAndIcon
        case badgeCount
        case badgeText
        case iconOnly
    }

    let variant: Variant

    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Tab Bar Configurations",
        description: "Tab bar acts as top level navigation",
        systemImage: "sparkles"
    )

    // MARK: - Body
    var body: some View {
        TabView {
            switch variant {
            case .textAndIcon:
                Tab("Inbox", systemImage: "tray") { navStack(navigationTitle: "Inbox") }
                Tab("Drafts", systemImage: "doc") { navStack(navigationTitle: "Drafts") }
                Tab("Sent", systemImage: "paperplane") { navStack(navigationTitle: "Sent") }
                Tab("Settings", systemImage: "gearshape") { navStack(navigationTitle: "Settings") }

            case .badgeCount:
                Tab("Inbox", systemImage: "tray") { navStack(navigationTitle: "Inbox") }
                    .badge(3)
                Tab("Drafts", systemImage: "doc") { navStack(navigationTitle: "Drafts") }
                    .badge(12)
                Tab("Sent", systemImage: "paperplane") { navStack(navigationTitle: "Sent") }
                    .badge(2)
                Tab("Settings", systemImage: "gearshape") { navStack(navigationTitle: "Settings") }

            case .badgeText:
                Tab("Inbox", systemImage: "tray") { navStack(navigationTitle: "Inbox") }
                    .badge("New")
                Tab("Drafts", systemImage: "doc") { navStack(navigationTitle: "Drafts") }
                    .badge("Beta")
                Tab("Sent", systemImage: "paperplane") { navStack(navigationTitle: "Sent") }
                Tab("Settings", systemImage: "gearshape") { navStack(navigationTitle: "Settings") }

            case .iconOnly:
                Tab { navStack(navigationTitle: "Inbox") } label: { Image(systemName: "tray") }
                Tab { navStack(navigationTitle: "Drafts") } label: { Image(systemName: "doc") }
                Tab { navStack(navigationTitle: "Sent") } label: { Image(systemName: "paperplane") }
                Tab { navStack(navigationTitle: "Settings") } label: { Image(systemName: "gearshape") }
            }
        }
    }

    // MARK: - View Components
    func navStack(navigationTitle: String) -> some View {
        NavigationStack {
            DemoScrollView(count: 20)
                .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
                .safeAreaBar(edge: .bottom) {
                    infoCard
                        .padding()
                }
                .navigationTitle(navigationTitle)
        }
    }
}

#Preview("Text & Icon") {
    TabItemsDemoView(variant: .textAndIcon)
        .tint(.brown)
}

#Preview("Badge Count") {
    TabItemsDemoView(variant: .badgeCount)
        .tint(.brown)
}

#Preview("Badge Text") {
    TabItemsDemoView(variant: .badgeText)
        .tint(.brown)
}

#Preview("Icon Only") {
    TabItemsDemoView(variant: .iconOnly)
        .tint(.brown)
}
