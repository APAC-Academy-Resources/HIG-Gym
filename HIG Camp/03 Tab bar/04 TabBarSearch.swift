import SwiftUI

enum TabSearchVariant {
    case searchRole
    case plainTab
    case searchRoleMinimize
    case sidebarAdaptable
}

struct TabSearchDemoView: View {
    let variant: TabSearchVariant

    var body: some View {
        switch variant {
        case .searchRole:
            tabView(searchAsRole: true)
        case .plainTab:
            tabView(searchAsRole: false)
        case .searchRoleMinimize:
            tabView(searchAsRole: true)
                .tabBarMinimizeBehavior(.onScrollDown)
        case .sidebarAdaptable:
            tabView(searchAsRole: true)
                .tabViewStyle(.sidebarAdaptable)
        }
    }

    @ViewBuilder
    private func tabView(searchAsRole: Bool) -> some View {
        TabView {
            Tab("Home", systemImage: "house") { content("Home", count: 20) }
            Tab("Browse", systemImage: "square.grid.2x2") { content("Browse", count: 25) }
            Tab("Favorites", systemImage: "star") { content("Favorites", count: 12) }

            if searchAsRole {
                Tab("Search", systemImage: "magnifyingglass", role: .search) {
                    searchTab
                }
            } else {
                Tab("Search", systemImage: "magnifyingglass") {
                    searchTab
                }
            }
        }
    }

    private func content(_ title: String, count: Int) -> some View {
        NavigationStack {
            DemoScrollView(count: count)
                .navigationTitle(title)
                .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
        }
    }

    private var searchTab: some View {
        NavigationStack {
            DemoSearchView()
                .toolbarTitleDisplayMode(.inlineLarge)
                .navigationTitle("Search")
        }
    }
}

#Preview("Plain Tab") {
    TabSearchDemoView(variant: .plainTab)
        .tint(.blue)
}

#Preview("Search Role") {
    TabSearchDemoView(variant: .searchRole)
        .tint(.blue)
}

#Preview("Search Role + Minimize on Scroll") {
    TabSearchDemoView(variant: .searchRoleMinimize)
        .tint(.blue)
}

#Preview("Sidebar Adaptable (best on iPad)") {
    TabSearchDemoView(variant: .sidebarAdaptable)
        .tint(.blue)
}
