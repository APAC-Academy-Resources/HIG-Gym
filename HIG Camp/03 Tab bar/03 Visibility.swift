import SwiftUI

enum TabVisibilityVariant {
    case alwaysVisible
    case hiddenOnDetail
}

struct TabVisibilityDemoView: View {
    let variant: TabVisibilityVariant

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
