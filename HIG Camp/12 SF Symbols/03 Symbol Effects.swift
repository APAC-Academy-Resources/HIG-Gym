//
//  03 Symbol Effects.swift
//  HIG Camp
//

import SwiftUI

struct SymbolEffectsDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Symbol Effects",
        description: "Discrete effects play once, indefinite effects loop while active, and content transitions animate one symbol swapping for another.",
        systemImage: "wand.and.rays"
    )

    // MARK: - State

    // Discrete — bumping replays every effect at once.
    @State private var discreteTrigger: Int = 0

    // Indefinite effects gated by a toggle.
    @State private var effectsActive: Bool = false

    // Content transition swap.
    @State private var isPlaying: Bool = false
    @State private var isShareable: Bool = false
    @State private var isMuted: Bool = false

    // View transition insertion/removal.
    @State private var showBadge: Bool = false

    // Draw on / off (iOS 26).
    @State private var isDrawn: Bool = true

    private let effectColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    // MARK: - Body
    var body: some View {
        DemoPage("Symbol Effects", info: infoCard, infoPlacement: .pinned) { _ in
            discreteSection
            indefiniteSection
            variableColorSection
            drawSection
            contentTransitionSection
            viewTransitionSection
        }
    }

    // MARK: - View Components

    /// Discrete effects: play once each time the trigger value changes.
    private var discreteSection: some View {
        DemoSection("Discrete — tap to play all") {
            VStack(spacing: 20) {
                LazyVGrid(columns: effectColumns, spacing: 20) {
                    effectIcon("Bounce", symbol: "arrow.up.heart.fill") {
                        $0.symbolEffect(.bounce, value: discreteTrigger)
                    }
                    effectIcon("Pulse", symbol: "bell.fill") {
                        $0.symbolEffect(.pulse, value: discreteTrigger)
                    }
                    effectIcon("Variable Color", symbol: "wifi") {
                        $0.symbolEffect(.variableColor.iterative, value: discreteTrigger)
                    }
                    effectIcon("Wiggle", symbol: "hand.wave.fill") {
                        $0.symbolEffect(.wiggle, value: discreteTrigger)
                    }
                    effectIcon("Rotate", symbol: "fan.fill") {
                        $0.symbolEffect(.rotate, value: discreteTrigger)
                    }
                    effectIcon("Breathe", symbol: "lungs.fill") {
                        $0.symbolEffect(.breathe, value: discreteTrigger)
                    }
                }
                Button("Play All", systemImage: "play.fill") {
                    discreteTrigger += 1
                }
                .buttonStyle(.bordered)
            }
            caption("`.symbolEffect(_:value:)` replays a discrete effect each time the value changes.")
        }
    }

    /// Indefinite effects: loop while `isActive` is true.
    private var indefiniteSection: some View {
        DemoSection("Indefinite — while active") {
            VStack(spacing: 20) {
                LazyVGrid(columns: effectColumns, spacing: 20) {
                    effectIcon("Pulse", symbol: "dot.radiowaves.left.and.right") {
                        $0.symbolEffect(.pulse, isActive: effectsActive)
                    }
                    effectIcon("Variable Color", symbol: "wifi") {
                        $0.symbolEffect(.variableColor.iterative, isActive: effectsActive)
                    }
                    effectIcon("Wiggle", symbol: "hand.thumbsup.fill") {
                        $0.symbolEffect(.wiggle, isActive: effectsActive)
                    }
                    effectIcon("Rotate", symbol: "fan.fill") {
                        $0.symbolEffect(.rotate, isActive: effectsActive)
                    }
                    effectIcon("Breathe", symbol: "lungs.fill") {
                        $0.symbolEffect(.breathe, isActive: effectsActive)
                    }
                    effectIcon("Scale", symbol: "arrow.up.left.and.arrow.down.right") {
                        $0.symbolEffect(.scale.up, isActive: effectsActive)
                    }
                }
                Toggle("Effects Active", isOn: $effectsActive)
            }
            caption("`.symbolEffect(_:isActive:)` loops for as long as the flag stays true.")
        }
    }

    /// Variable color: `VariableColorSymbolEffect` variants light layers in sequence
    /// while active. Shares the "Effects Active" toggle above.
    private var variableColorSection: some View {
        DemoSection("Variable Color — layer animation") {
            VStack(spacing: 20) {
                HStack {
                    effectIcon("Cumulative", symbol: "chart.bar.xaxis.ascending") {
                        $0.symbolEffect(.variableColor.cumulative, isActive: effectsActive)
                    }
                    effectIcon("Iterative", symbol: "chart.bar.xaxis.ascending") {
                        $0.symbolEffect(.variableColor.iterative, isActive: effectsActive)
                    }
                    effectIcon("Reversing", symbol: "chart.bar.xaxis.ascending") {
                        $0.symbolEffect(.variableColor.cumulative.reversing, isActive: effectsActive)
                    }
                }
                HStack {
                    effectIcon("Dim Inactive", symbol: "chart.bar.xaxis.ascending") {
                        $0.symbolEffect(.variableColor.iterative.dimInactiveLayers, isActive: effectsActive)
                    }
                    effectIcon("Hide Inactive", symbol: "chart.bar.xaxis.ascending") {
                        $0.symbolEffect(.variableColor.iterative.hideInactiveLayers, isActive: effectsActive)
                    }
                    effectIcon("Iter. Reversing", symbol: "chart.bar.xaxis.ascending") {
                        $0.symbolEffect(.variableColor.iterative.reversing, isActive: effectsActive)
                    }
                }
            }
            caption("`.variableColor` modifiers stack — `.cumulative`/`.iterative` set how layers light, `.reversing` and the inactive-layer options refine it.")
        }
    }

    /// Draw effects (iOS 26): trace the symbol's strokes on/off. `.wholeSymbol` draws
    /// all paths at once; `.individually` draws them in sequence. Only symbols with
    /// draw data animate — others just appear/disappear.
    private var drawSection: some View {
        DemoSection("Draw On / Off") {
            VStack(spacing: 20) {
                HStack {
                    effectIcon("Whole Symbol", symbol: "signature") {
                        $0.symbolEffect(.drawOn.wholeSymbol, isActive: !isDrawn)
                    }
                    effectIcon("By Layer", symbol: "signature") {
                        $0.symbolEffect(.drawOn.byLayer, isActive: !isDrawn)
                    }
                    effectIcon("Individually", symbol: "signature") {
                        $0.symbolEffect(.drawOn.individually, isActive: !isDrawn)
                    }
                }
                .symbolRenderingMode(.hierarchical)
                Button(isDrawn ? "Draw Off" : "Draw On", systemImage: isDrawn ? "escape" : "return") {
                    isDrawn.toggle()
                }
                .contentTransition(.symbolEffect(.replace))
                .buttonStyle(.bordered)
            }
            caption("`.symbolEffect(.drawOn)` traces the strokes — `.wholeSymbol`, `.byLayer` or `.individually`.")
        }
    }

    /// Content transition: `.replace` animates one symbol morphing into another.
    private var contentTransitionSection: some View {
        DemoSection("Content Transition — replace") {
            HStack(spacing: 40) {
                Button {
                    isPlaying.toggle()
                } label: {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 40))
                        .contentTransition(.symbolEffect(.replace))
                        .frame(width: 60)
                }
                Button {
                    isShareable.toggle()
                } label: {
                    Image(systemName: isShareable ? "checkmark" : "square.and.arrow.up")
                        .font(.system(size: 40))
                        .contentTransition(.symbolEffect(.replace))
                        .frame(width: 60)
                }
                Button {
                    isMuted.toggle()
                } label: {
                    Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                        .font(.system(size: 40))
                        .contentTransition(.symbolEffect(.replace))
                        .frame(width: 60)
                }
            }
            .frame(maxWidth: .infinity)
            .buttonStyle(.plain)
            .foregroundStyle(.tint)
            caption("`.contentTransition(.symbolEffect(.replace))` animates one symbol swapping for another.")
        }
    }

    /// Magic replace: `.replace.magic(fallback:)` keeps shared shapes in place and
    /// animates only what differs, falling back for symbols that can't be matched.
    private var viewTransitionSection: some View {
        DemoSection("Magic Replace") {
            HStack(alignment: .center) {
                Image(systemName: showBadge ? "envelope.badge.plus.fill" : "envelope.badge.minus.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(.tint.secondary)
                    .frame(width: 60, height: 44)
                    .symbolRenderingMode(.multicolor)
                    .contentTransition(.symbolEffect(.replace.magic(fallback: .downUp.byLayer), options: .nonRepeating))
                Spacer()
                Button("Replace") {
                    withAnimation(.bouncy) { showBadge.toggle() }
                }
                .buttonStyle(.bordered)
            }
            caption("`.replace.magic(fallback:)` morphs only the parts that differ between the two symbols.")
        }
    }

    // MARK: - Helpers
    private func effectIcon(
        _ title: String,
        symbol: String,
        @ViewBuilder effect: (Image) -> some View
    ) -> some View {
        VStack(spacing: 8) {
            effect(Image(systemName: symbol))
                .font(.system(size: 40))
                .foregroundStyle(.tint)
            Text(title)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SymbolEffectsDemo()
}
