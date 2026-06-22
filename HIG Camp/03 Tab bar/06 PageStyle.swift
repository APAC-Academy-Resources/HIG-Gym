import SwiftUI

struct TabViewStylesDemoView: View {
    // MARK: - Variant
    enum Variant {
        case automatic
        case sidebarAdaptable
        case page
        case pageWithIcons
    }

    let variant: Variant

    // MARK: - Body
    var body: some View {
        switch variant {
        case .automatic:
            navigationTabView
        case .sidebarAdaptable:
            navigationTabView
                .tabViewStyle(.sidebarAdaptable)
        case .page:
            pageTabView
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
        case .pageWithIcons:
            pageTabViewWithIcons
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
    }

    // MARK: - View Components
    private var navigationTabView: some View {
        TabView {
            Tab("Inbox", systemImage: "tray") {
                NavigationStack {
                    DemoScrollView(count: 20)
                        .navigationTitle("Inbox")
                        .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
                }
            }
            Tab("Drafts", systemImage: "doc") {
                NavigationStack {
                    DemoScrollView(count: 10)
                        .navigationTitle("Drafts")
                        .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
                }
            }
            Tab("Sent", systemImage: "paperplane") {
                NavigationStack {
                    DemoScrollView(count: 15)
                        .navigationTitle("Sent")
                        .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
                }
            }
            Tab("Settings", systemImage: "gearshape") {
                NavigationStack {
                    DemoScrollView(count: 8)
                        .navigationTitle("Settings")
                        .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
                }
            }
        }
    }

    private var pageTabView: some View {
        TabView {
            pageContent("First")
            pageContent("Second")
            pageContent("Third")
            pageContent("Fourth")
        }
        .tint(.orange)
    }
    
    private var pageTabViewWithIcons: some View {
        TabView {
            Tab("First", systemImage: "checkmark") {
                pageContent("First")
            }
            Tab("Second", systemImage: "pencil.tip.crop.circle.fill") {
                pageContent("Second")
            }
            Tab("Third", systemImage: "dot.fill") {
                pageContent("Third")
            }
            Tab("Fourth", systemImage: "sunglasses.fill") {
                pageContent("Fourth")
            }
        }
        .tint(.indigo)
    }

    private func pageContent(_ title: String) -> some View {
        NavigationStack {
            VStack {
                VStack(alignment: .center) {
                    Text(title)
                        .font(.largeTitle)
                        .bold()
                    Text("Page")
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(62)
            .glassEffect(in: RoundedRectangle(cornerRadius: 48, style: .continuous))
            .background(
                Color(.tintColor).gradient,
                in: RoundedRectangle(cornerRadius: 48, style: .continuous)
            )
        }
    }
}

#Preview("Automatic") {
    TabViewStylesDemoView(variant: .automatic)
}

#Preview("Sidebar Adaptable (best on iPad)") {
    TabViewStylesDemoView(variant: .sidebarAdaptable)
}

#Preview("Page") {
    TabViewStylesDemoView(variant: .page)
}

#Preview("Page w/ Icons") {
    TabViewStylesDemoView(variant: .pageWithIcons)
}
