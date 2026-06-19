import SwiftUI

enum TabItemVariant {
    case textAndIcon
    case badgeCount
    case badgeText
    case iconOnly
}

struct TabItemsDemoView: View {
    let variant: TabItemVariant

    var body: some View {
        TabView {
            switch variant {
            case .textAndIcon:
                Tab("Inbox", systemImage: "tray") { inboxNav }
                Tab("Drafts", systemImage: "doc") { draftsNav }
                Tab("Sent", systemImage: "paperplane") { sentNav }
                Tab("Settings", systemImage: "gearshape") { settingsNav }

            case .badgeCount:
                Tab("Inbox", systemImage: "tray") { inboxNav }.badge(3)
                Tab("Drafts", systemImage: "doc") { draftsNav }.badge(12)
                Tab("Sent", systemImage: "paperplane") { sentNav }
                Tab("Settings", systemImage: "gearshape") { settingsNav }

            case .badgeText:
                Tab("Inbox", systemImage: "tray") { inboxNav }.badge("New")
                Tab("Drafts", systemImage: "doc") { draftsNav }.badge("Beta")
                Tab("Sent", systemImage: "paperplane") { sentNav }
                Tab("Settings", systemImage: "gearshape") { settingsNav }

            case .iconOnly:
                Tab { inboxNav } label: { Image(systemName: "tray") }
                Tab { draftsNav } label: { Image(systemName: "doc") }
                Tab { sentNav } label: { Image(systemName: "paperplane") }
                Tab { settingsNav } label: { Image(systemName: "gearshape") }
            }
        }
    }

    private var inboxNav: some View {
        NavigationStack {
            DemoScrollView(count: 20)
                .navigationTitle("Inbox")
                .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
        }
    }

    private var draftsNav: some View {
        NavigationStack {
            DemoScrollView(count: 10)
                .navigationTitle("Drafts")
                .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
        }
    }

    private var sentNav: some View {
        NavigationStack {
            DemoScrollView(count: 15)
                .navigationTitle("Sent")
                .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
        }
    }

    private var settingsNav: some View {
        NavigationStack {
            DemoScrollView(count: 8)
                .navigationTitle("Settings")
                .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
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
