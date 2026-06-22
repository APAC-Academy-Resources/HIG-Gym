import SwiftUI

struct TabVisibilityDemoView: View {
    // MARK: - Variant
    enum Variant {
        case alwaysVisible
        case hiddenOnDetail
    }

    let variant: Variant

    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Tab Bar Visibility",
        description: "Push a detail view and watch the tab bar. \"Hidden on Detail\" drops it on deeper screens; \"Always Visible\" keeps it. Tap a row to push.",
        systemImage: "rectangle.bottomthird.inset.filled"
    )

    // MARK: - Body
    var body: some View {
        TabView {
            Tab("Browse", systemImage: "list.bullet") {
                NavigationStack {
                    DemoScrollView(count: 20)
                        .navigationTitle("Browse")
                        .navigationDestination(for: String.self) {
                            DemoDetailView(item: $0, tabBarHiddenOnDetail: variant == .hiddenOnDetail)
                        }
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button("Star", systemImage: "star") { }
                            }
                        }
                        .safeAreaBar(edge: .bottom) {
                            infoCard
                                .padding(.horizontal)
                        }
                }
            }
            Tab("Favorites", systemImage: "star") {
                NavigationStack {
                    DemoScrollView(count: 12)
                        .navigationTitle("Favorites")
                        .navigationDestination(for: String.self) {
                            DemoDetailView(item: $0, tabBarHiddenOnDetail: variant == .hiddenOnDetail)
                        }
                }
            }
            Tab("Settings", systemImage: "gearshape") {
                NavigationStack {
                    DemoScrollView(count: 8)
                        .navigationTitle("Settings")
                        .navigationDestination(for: String.self) {
                            DemoDetailView(item: $0, tabBarHiddenOnDetail: variant == .hiddenOnDetail)
                        }
                }
            }
        }
    }
}

#Preview("Always Visible") {
    TabVisibilityDemoView(variant: .alwaysVisible)
}

#Preview("Hidden on Detail") {
    TabVisibilityDemoView(variant: .hiddenOnDetail)
}
