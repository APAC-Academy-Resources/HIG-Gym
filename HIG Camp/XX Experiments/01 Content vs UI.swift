import SwiftUI

// MARK: - Brand Feel
// Same app skeleton (system toolbar + tab bar), four different content-layer brands.
// The chrome is written once and never restyled — all personality lives in `BrandTheme`
// and the content views below the nav bar.

enum BrandFeel: CaseIterable {
    case kraft   // warm artisanal paper roaster
    case lab     // clinical dark brew-science
    case pastel  // cheerful candy zine
    case native  // stock iOS — system materials, standard fonts, system buttons
}

// MARK: - Chip Style
enum ChipStyle {
    case outlined      // stroke only, stamped
    case tag           // small-radius monospaced sensor tag
    case capsuleFill   // solid candy pill
    case trackedText   // uppercase tracked, masthead label
    case systemButton  // stock iOS bordered capsule button
}

// MARK: - Brand Theme
// Value type holding everything that varies per feel.
struct BrandTheme {
    var background, card, accent, accent2, text, muted: Color

    var titleFont, headlineFont, bodyFont, statFont, labelFont: Font
    var uppercaseLabels: Bool
    var labelTracking: CGFloat

    var cardCorner: CGFloat
    var cardStroke: Color?               // nil = no border
    var cardShadow: (color: Color, radius: CGFloat)?
    var chip: ChipStyle

    // Copy — same content, different voice.
    var titleMode: ToolbarTitleDisplayMode
    var heroKicker, heroName, heroNotes, heroBlurb: String
    var cafesHeading, brewsHeading: String
    var heroText: Color          // hero foreground (white on brand fills, .primary on the native material)

    static func theme(for feel: BrandFeel) -> BrandTheme {
        switch feel {
        case .kraft:
            return BrandTheme(
                background: Color.hex(0xEDE4D3), card: Color.hex(0xF7F1E6),
                accent: Color.hex(0x8B4A2F), accent2: Color.hex(0x6B7A4F),
                text: Color.hex(0x3A2E24), muted: Color.hex(0x8A7A66),
                titleFont: .system(.title2, design: .serif).weight(.semibold),
                headlineFont: .system(.headline, design: .serif),
                bodyFont: .system(.subheadline, design: .serif),
                statFont: .system(.caption, design: .rounded).weight(.medium),
                labelFont: .system(.caption2, design: .rounded).weight(.medium),
                uppercaseLabels: true, labelTracking: 1.5,
                cardCorner: 6, cardStroke: Color.hex(0x8A7A66).opacity(0.4),
                cardShadow: (Color.hex(0x8B4A2F).opacity(0.12), 6), chip: .outlined,
                titleMode: .inlineLarge,
                heroKicker: "Bean of the Week", heroName: "Guji, Ethiopia",
                heroNotes: "plum · cocoa · honey",
                heroBlurb: "We tasted plum and cocoa in this one — roasted last Tuesday morning.",
                cafesHeading: "Roasters we love", brewsHeading: "Brew journal",
                heroText: .white)

        case .lab:
            return BrandTheme(
                background: Color.hex(0x0E1113), card: Color.hex(0x1A1F23),
                accent: Color.orange,
                accent2: Color.orange,
                text: Color.hex(0xE8EDF0), muted: Color.hex(0x6E7C85),
                titleFont: .system(.title2, design: .default).width(.expanded).weight(.bold),
                headlineFont: .system(.subheadline, design: .default).width(.expanded).weight(.semibold),
                bodyFont: .system(.footnote, design: .default),
                statFont: .system(.caption, design: .default),
                labelFont: .system(.caption2, design: .default).width(.condensed),
                uppercaseLabels: true, labelTracking: 2,
                cardCorner: 18, cardStroke: Color.orange.opacity(0),
                cardShadow: nil, chip: .tag,
                titleMode: .inlineLarge,
                heroKicker: "BEAN // WK 28", heroName: "GUJI ETHIOPIA",
                heroNotes: "1:16 · 94°C · 2:45",
                heroBlurb: "Extraction 21.3% · Light roast · Washed process.",
                cafesHeading: "ROASTERS",
                brewsHeading: "BREW LOG",
                heroText: .white)

        case .pastel:
            return BrandTheme(
                background: Color.hex(0xFFF6F2), card: Color.hex(0xFDECEF),
                accent: Color.hex(0xFF7A9C), accent2: Color.hex(0x7CC7C0),
                text: Color.hex(0x4A3F4D), muted: Color.hex(0x9A8FA0),
                titleFont: .system(.title, design: .rounded).weight(.heavy),
                headlineFont: .system(.headline, design: .rounded).weight(.bold),
                bodyFont: .system(.subheadline, design: .rounded),
                statFont: .system(.subheadline, design: .rounded).weight(.semibold),
                labelFont: .system(.caption, design: .rounded).weight(.semibold),
                uppercaseLabels: false, labelTracking: 0,
                cardCorner: 24, cardStroke: nil,
                cardShadow: (Color.hex(0xFF7A9C).opacity(0.25), 16), chip: .capsuleFill,
                titleMode:.inlineLarge,
                heroKicker: "☕ Bean of the Week!", heroName: "Sweet Guji",
                heroNotes: "plum · cocoa · honey",
                heroBlurb: "Ooh, this one's a treat — juicy plum & cocoa. You'll love it!",
                cafesHeading: "Cafés to try 💛", brewsHeading: "Your brews",
                heroText: .white)

        case .native:
            return BrandTheme(
                background: Color(.systemGroupedBackground),
                card: Color(.secondarySystemGroupedBackground),
                accent: .blue, accent2: .blue,
                text: .primary, muted: .secondary,
                titleFont: .system(.title2).weight(.bold),
                headlineFont: .headline,
                bodyFont: .subheadline,
                statFont: .subheadline,
                labelFont: .caption,
                uppercaseLabels: false, labelTracking: 0,
                cardCorner: 12, cardStroke: nil,
                cardShadow: nil, chip: .systemButton,
                titleMode: .inlineLarge,
                heroKicker: "Bean of the Week", heroName: "Guji, Ethiopia",
                heroNotes: "plum · cocoa · honey",
                heroBlurb: "A washed Ethiopian with notes of plum and cocoa.",
                cafesHeading: "Roasters", brewsHeading: "Recent Brews",
                heroText: .primary)
        }
    }
}

// MARK: - Fake data
private struct Cafe: Identifiable {
    let id = UUID(); let name: String; let rating: Double; let note: String
}
private struct Brew: Identifiable {
    let id = UUID(); let method: String; let symbol: String; let stars: Int; let day: String
}

private let cafes = [
    Cafe(name: "Roasters Union", rating: 4.5, note: "nutty"),
    Cafe(name: "Ember & Oak", rating: 5.0, note: "floral"),
    Cafe(name: "Third Wave", rating: 4.0, note: "citrus"),
]
private let brews = [
    Brew(method: "V60", symbol: "cup.and.saucer", stars: 4, day: "Tue"),
    Brew(method: "Espresso", symbol: "cup.and.saucer.fill", stars: 5, day: "Mon"),
    Brew(method: "AeroPress", symbol: "cup.and.saucer", stars: 3, day: "Sun"),
]

// MARK: - Demo View
struct PourOverExperimentView: View {
    let feel: BrandFeel
    private var theme: BrandTheme { .theme(for: feel) }

    // MARK: Body — the chrome is written once and never restyled.
    var body: some View {
        TabView {
            Tab("Discover", systemImage: "sparkles") { discoverTab }
            Tab("Brews", systemImage: "list.bullet") { simpleTab("Brews") }
            Tab("Recipes", systemImage: "book") { simpleTab("Recipes") }
            Tab("Beans", systemImage: "leaf") { simpleTab("Beans") }
        }
        .tint(theme.accent)   // toolbar buttons + tab-bar selection follow the brand
    }

    // MARK: Discover — the only fully-themed screen.
    private var discoverTab: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    heroBeanCard.padding(.horizontal)
                    cafesSection                       // full-bleed horizontal scroll
                    brewsSection.padding(.horizontal)
                }
                .padding(.vertical)
            }
            .background(theme.background)
            .scrollContentBackground(.hidden)
            .toolbarTitleDisplayMode(theme.titleMode)
            .navigationTitle("Discover")
            .toolbar {
                if feel != .native {   // brand feels supply a custom-styled large title
                    ToolbarItem(placement: .largeTitle) {
                        HStack {
                            Text("Discover")
                                .font(largeTitleFont)
                                .foregroundStyle(theme.text)
                            Spacer()
                        }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Search", systemImage: "magnifyingglass") {}
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add brew", systemImage: "plus") {}
                }
            }
            .safeAreaBar(edge: .top) { nowBrewingBar }
        }
    }

    // MARK: Stub tabs — themed background only, no content.
    private func simpleTab(_ title: String) -> some View {
        NavigationStack {
            ZStack {
                theme.background.ignoresSafeArea()
                Text(title)
                    .font(theme.titleFont)
                    .foregroundStyle(theme.muted)
            }
            .navigationTitle(title)
        }
    }

    // Per-brand custom large title font (native uses the stock system title).
    private var largeTitleFont: Font {
        switch feel {
        case .kraft:  return .system(.largeTitle, design: .serif).weight(.semibold)
        case .lab:    return .system(.largeTitle, design: .default).bold().width(.expanded)
        case .pastel: return .system(.largeTitle, design: .rounded).weight(.heavy)
        case .native: return .largeTitle
        }
    }

    // MARK: Now Brewing — pinned accessory above the tab bar, styled per brand.
    private var nowBrewingBar: some View {
        HStack(spacing: 12) {
            Image(systemName: "cup.and.saucer.fill")
                .font(.title3)
                .foregroundStyle(theme.accent)
            VStack(alignment: .leading, spacing: 1) {
                Text("V60")
                    .font(theme.headlineFont)
                    .foregroundStyle(theme.text)
                label("Tetsu Kasuya Method")
                    .foregroundStyle(theme.muted)
            }
            Spacer()
            Text("3rd Pour")
                .font(theme.statFont.monospacedDigit())
                .foregroundStyle(.secondary)
            Text("0:24")
                .font(theme.statFont.monospacedDigit())
                .foregroundStyle(theme.text)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .glassEffect(.regular, in: Capsule())
        .padding(.horizontal)
    }

    // MARK: Hero — Bean of the Week
    private var heroBeanCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            label(theme.heroKicker)
                .foregroundStyle(theme.heroText.opacity(0.85))
            Text(theme.heroName)
                .font(theme.titleFont)
                .foregroundStyle(theme.heroText)
            HStack(spacing: 6) {
                Image(systemName: "mountain.2.fill")
                Text(theme.heroNotes)
            }
            .font(theme.statFont)
            .foregroundStyle(theme.heroText.opacity(0.9))
            Text(theme.heroBlurb)
                .font(theme.bodyFont)
                .foregroundStyle(theme.heroText.opacity(0.9))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background {
            ZStack {
                RoundedRectangle(cornerRadius: theme.cardCorner).fill(heroFill)
                if feel == .native {   // frost the blue with thin material
                    RoundedRectangle(cornerRadius: theme.cardCorner).fill(.thinMaterial)
                }
            }
        }
    }

    // Lab uses a flat secondary tint, Native a blue base (frosted above); the rest gradient.
    private var heroFill: AnyShapeStyle {
        switch feel {
        case .lab:    return AnyShapeStyle(theme.accent2)
        case .native: return AnyShapeStyle(theme.accent)
        default:      return AnyShapeStyle(LinearGradient(colors: [theme.accent, theme.accent2],
                                                          startPoint: .topLeading, endPoint: .bottomTrailing))
        }
    }

    // MARK: Cafés row — scroll track spans full width; content insets keep card margins.
    private var cafesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeading(theme.cafesHeading)
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(cafes) { cafe in cafeCard(cafe) }
                }
                .padding(.horizontal)
            }
        }
    }

    private func cafeCard(_ cafe: Cafe) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: "cup.and.saucer.fill")
                .font(.title2)
                .foregroundStyle(theme.accent)
            Text(cafe.name)
                .font(theme.headlineFont)
                .foregroundStyle(theme.text)
            HStack(spacing: 4) {
                Image(systemName: "star.fill").foregroundStyle(theme.accent)
                Text(String(format: "%.1f", cafe.rating))
            }
            .font(theme.statFont)
            .foregroundStyle(theme.text)
            chip(cafe.note)
        }
        .frame(width: 220, alignment: .leading)
        .padding(14)
        .modifier(CardSurface(theme: theme))
    }

    // MARK: Brew log
    private var brewsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeading(theme.brewsHeading)
            VStack(spacing: 10) {
                ForEach(brews) { brew in brewRow(brew) }
            }
        }
    }

    private func brewRow(_ brew: Brew) -> some View {
        HStack(spacing: 12) {
            Image(systemName: brew.symbol)
                .font(.title3)
                .foregroundStyle(theme.accent)
                .frame(width: 32)
            VStack(alignment: .leading, spacing: 2) {
                Text(brew.method)
                    .font(theme.headlineFont)
                    .foregroundStyle(theme.text)
                Text(brew.day)
                    .font(theme.labelFont)
                    .foregroundStyle(theme.muted)
            }
            Spacer()
            HStack(spacing: 2) {
                ForEach(0..<5) { i in
                    Image(systemName: i < brew.stars ? "star.fill" : "star")
                        .font(.caption)
                        .foregroundStyle(i < brew.stars ? theme.accent : theme.muted)
                }
            }
        }
        .padding(14)
        .modifier(CardSurface(theme: theme))
    }

    // MARK: Reusable text helpers
    private func sectionHeading(_ text: String) -> some View {
        Text(theme.uppercaseLabels ? text.uppercased() : text)
            .font(theme.headlineFont)
            .tracking(theme.uppercaseLabels ? theme.labelTracking : 0)
            .foregroundStyle(theme.text)
    }

    private func label(_ text: String) -> some View {
        Text(theme.uppercaseLabels ? text.uppercased() : text)
            .font(theme.labelFont)
            .tracking(theme.labelTracking)
    }

    // MARK: Chip — style varies per feel
    @ViewBuilder
    private func chip(_ text: String) -> some View {
        switch theme.chip {
        case .outlined:
            Text(text)
                .font(theme.labelFont)
                .padding(.horizontal, 10).padding(.vertical, 4)
                .foregroundStyle(theme.accent2)
                .overlay(Capsule().stroke(theme.accent2, lineWidth: 1))
        case .tag:
            Text(text.uppercased())
                .font(theme.labelFont)
                .tracking(theme.labelTracking)
                .padding(.horizontal, 8).padding(.vertical, 3)
                .foregroundStyle(theme.accent)
                .overlay(RoundedRectangle(cornerRadius: 3).stroke(theme.accent, lineWidth: 1))
        case .capsuleFill:
            Text(text)
                .font(theme.labelFont)
                .padding(.horizontal, 12).padding(.vertical, 5)
                .foregroundStyle(.white)
                .background(theme.accent2, in: Capsule())
        case .trackedText:
            Text(text.uppercased())
                .font(theme.labelFont)
                .tracking(theme.labelTracking)
                .foregroundStyle(theme.accent2)
        case .systemButton:
            Button(cafeActionLabel(text)) {}
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                .controlSize(.small)
                .tint(theme.accent)
        }
    }

    // Stock-iOS chip reads as an actionable tag button.
    private func cafeActionLabel(_ note: String) -> String { note.capitalized }
}

// MARK: - Card surface modifier
private struct CardSurface: ViewModifier {
    let theme: BrandTheme
    func body(content: Content) -> some View {
        content
            .background(theme.card, in: RoundedRectangle(cornerRadius: theme.cardCorner))
            .overlay(
                RoundedRectangle(cornerRadius: theme.cardCorner)
                    .stroke(theme.cardStroke ?? .clear, lineWidth: theme.cardStroke == nil ? 0 : 1))
            .shadow(color: theme.cardShadow?.color ?? .clear,
                    radius: theme.cardShadow?.radius ?? 0, y: 4)
    }
}

// MARK: - Hex color helper
private extension Color {
    static func hex(_ hex: UInt) -> Color {
        Color(
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255)
    }
}

// MARK: - Previews — same view, four brand feels, identical chrome.
#Preview("Kraft")  { PourOverExperimentView(feel: .kraft) }
#Preview("Lab")    { PourOverExperimentView(feel: .lab) }
#Preview("Pastel") { PourOverExperimentView(feel: .pastel) }
#Preview("Native") { PourOverExperimentView(feel: .native) }
