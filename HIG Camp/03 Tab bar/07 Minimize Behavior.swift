import SwiftUI

struct TabBarMinimizeDemoView: View {
    let behavior: TabBarMinimizeBehavior

    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Tab Bar Minimize Behavior",
        description: "Controls when the floating tab bar shrinks: never, on scroll down, or on scroll up. Scroll the list to trigger it.",
        systemImage: "arrow.down.right.and.arrow.up.left"
    )

    // MARK: - Body
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                content(title: "Home", color: .blue, count: 30)
            }
            Tab("Browse", systemImage: "square.grid.2x2") {
                content(title: "Browse", color: .purple, count: 30)
            }
            Tab("Favorites", systemImage: "star") {
                content(title: "Favorites", color: .orange, count: 30)
            }
            Tab("Settings", systemImage: "gearshape") {
                content(title: "Settings", color: .gray, count: 30)
            }
        }
        .tabBarMinimizeBehavior(behavior)
    }

    // MARK: - View Components
    private func content(title: String, color: Color, count: Int) -> some View {
        NavigationStack {
            DemoScrollView(count: count)
                .background(color.gradient.opacity(0.7))
                .tint(color)
                .navigationTitle(title)
                .toolbarTitleDisplayMode(.inlineLarge)
                .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
                .safeAreaBar(edge: .top) {
                    infoCard
                        .padding(.horizontal)
                }
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
