import SwiftUI

struct TabBarMinimizeDemoView: View {
    let behavior: TabBarMinimizeBehavior

    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                content(title: "Home", color: .blue, count: 30)
            }
            Tab("Browse", systemImage: "square.grid.2x2") {
                content(title: "Browse", color: .purple, count: 30)
            }
            Tab("Favorites", systemImage: "star") {
                content(title: "Favorites", color: .yellow, count: 30)
            }
            Tab("Settings", systemImage: "gearshape") {
                content(title: "Settings", color: .gray, count: 30)
            }
        }
        .tabBarMinimizeBehavior(behavior)
    }

    private func content(title: String, color: Color, count: Int) -> some View {
        NavigationStack {
            DemoScrollView(count: count)
                .background(color.gradient.opacity(0.7))
                .tint(color)
                .navigationTitle(title)
                .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
        }
    }
}

#Preview("Never") {
    TabBarMinimizeDemoView(behavior: .never)
}

#Preview("On Scroll Down") {
    TabBarMinimizeDemoView(behavior: .onScrollDown)
}

#Preview("On Scroll Up") {
    TabBarMinimizeDemoView(behavior: .onScrollUp)
}
