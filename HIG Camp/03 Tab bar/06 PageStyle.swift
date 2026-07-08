import SwiftUI

struct TabViewStylesDemoView: View {
    // MARK: - Variant
    enum Variant {
        case page
        case pageWithIcons
    }

    let variant: Variant

    // MARK: - Body
    var body: some View {
        switch variant {
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
        .tint(.indigo)
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
        .background(
            .regularMaterial,
            in: RoundedRectangle(cornerRadius: 48, style: .continuous)
        )
        .background(
            .tint,
            in: RoundedRectangle(cornerRadius: 48, style: .continuous)
        )
    }
}

#Preview("Page") {
    TabViewStylesDemoView(variant: .page)
}

#Preview("Page w/ Icons") {
    TabViewStylesDemoView(variant: .pageWithIcons)
}
