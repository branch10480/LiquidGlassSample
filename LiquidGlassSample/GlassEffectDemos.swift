//
//  GlassEffectDemos.swift
//  LiquidGlassSample
//
//  Created by Toshiharu Imaeda on 2026/01/03.
//

import SwiftUI

// MARK: - glassEffect モディファイア デモ
/// iOS 26で追加されたglassEffect()モディファイアを使用して
/// カスタムビューにLiquid Glass効果を適用する方法
struct GlassEffectDemo: View {
    @State private var selectedShape: GlassShape = .capsule

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                // 背景画像
                gradientBackground

                // glassEffect の説明
                explanationSection

                // 形状選択
                shapeSelector

                // glassEffect適用例
                glassEffectExamples

                // コード例
                codeExampleSection
            }
            .padding()
        }
        .navigationTitle("glassEffect")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var gradientBackground: some View {
        ZStack {
            LinearGradient(
                colors: [.blue, .purple, .pink, .orange],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 20))

            // glassEffectを適用したオーバーレイ
            VStack {
                Text("Liquid Glass")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("iOS 26")
                    .font(.title2)
            }
            .foregroundStyle(.white)
            .padding(24)
            .glassEffect(.regular.interactive(), in: .capsule)
        }
    }

    private var explanationSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("glassEffect() モディファイア")
                .font(.headline)

            Text("""
            iOS 26では、.glassEffect()モディファイアを使用して、任意のビューにLiquid Glass効果を適用できます。

            主なパラメータ:
            • GlassEffectStyle: .regular, .clear など
            • Shape: 効果を適用する形状
            • .interactive: タッチ時のインタラクション効果
            """)
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
    }

    private var shapeSelector: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("形状を選択")
                .font(.headline)

            Picker("Shape", selection: $selectedShape) {
                ForEach(GlassShape.allCases) { shape in
                    Text(shape.displayName).tag(shape)
                }
            }
            .pickerStyle(.segmented)
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
    }

    @ViewBuilder
    private var glassEffectExamples: some View {
        VStack(spacing: 24) {
            Text("glassEffect 適用例")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)

            // カラフルな背景の上にガラス効果を表示
            ZStack {
                // 背景のカラフルなグリッド
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 4), count: 4), spacing: 4) {
                    ForEach(0..<16, id: \.self) { index in
                        Rectangle()
                            .fill(Color(hue: Double(index) / 16, saturation: 0.7, brightness: 0.9))
                            .frame(height: 50)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 16))

                // glassEffect を適用したビュー
                VStack(spacing: 8) {
                    Image(systemName: "sparkles")
                        .font(.title)
                    Text("Glass Effect")
                        .font(.headline)
                }
                .padding(20)
                .glassEffect(.regular, in: selectedShape.shape)
            }
            .frame(height: 220)

            // インタラクティブ効果の説明
            HStack(spacing: 16) {
                VStack {
                    Text("通常")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("Tap")
                        .padding()
                        .glassEffect(.regular, in: .capsule)
                }

                VStack {
                    Text("インタラクティブ")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("Tap")
                        .padding()
                        .glassEffect(.regular.interactive(), in: .capsule)
                }
            }
        }
    }

    private var codeExampleSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("コード例")
                .font(.headline)

            Text("""
            // 基本的な使用法
            Text("Hello")
                .padding()
                .glassEffect(.regular, in: .capsule)

            // インタラクティブ効果付き
            Button("Tap Me") { }
                .glassEffect(.regular.interactive, in: .rect(cornerRadius: 12))

            // クリアスタイル
            Image(systemName: "star")
                .glassEffect(.clear, in: .circle)
            """)
            .font(.system(.caption, design: .monospaced))
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
}

// MARK: - Glass Shape Enum
enum GlassShape: String, CaseIterable, Identifiable {
    case capsule
    case roundedRect
    case circle
    case rect

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .capsule: return "Capsule"
        case .roundedRect: return "Rounded"
        case .circle: return "Circle"
        case .rect: return "Rect"
        }
    }

    var shape: AnyShape {
        switch self {
        case .capsule:
            AnyShape(Capsule())
        case .roundedRect:
            AnyShape(RoundedRectangle(cornerRadius: 16))
        case .circle:
            AnyShape(Circle())
        case .rect:
            AnyShape(Rectangle())
        }
    }
}

// MARK: - GlassEffectContainer デモ
/// GlassEffectContainerを使用して、複数のビューで
/// 統一されたLiquid Glass効果を共有する方法
struct GlassEffectContainerDemo: View {
    @State private var selectedTab = 0

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // 説明セクション
                explanationSection

                // GlassEffectContainer の例
                containerExample

                // ナビゲーションバーとの連携例
                navigationBarIntegrationExample

                // コード例
                codeExample
            }
            .padding()
        }
        .navigationTitle("GlassEffectContainer")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var explanationSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("GlassEffectContainer")
                .font(.headline)

            Text("""
            GlassEffectContainerは、複数の子ビューで統一されたLiquid Glass効果を共有するためのコンテナです。

            主な特徴:
            • 子ビューが同じガラス面を共有
            • パフォーマンスの最適化
            • 一貫したビジュアル効果
            • ナビゲーションバー/タブバーとの連携
            """)
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
    }

    private var containerExample: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("コンテナ内での効果共有")
                .font(.headline)

            ZStack {
                // 背景
                LinearGradient(
                    colors: [.cyan, .blue, .purple],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 20))

                // GlassEffectContainer を模したUI
                VStack(spacing: 0) {
                    // タブバー風のUI
                    HStack(spacing: 0) {
                        ForEach(0..<3) { index in
                            Button {
                                withAnimation(.spring(duration: 0.3)) {
                                    selectedTab = index
                                }
                            } label: {
                                VStack(spacing: 4) {
                                    Image(systemName: tabIcon(for: index))
                                        .font(.title2)
                                    Text(tabTitle(for: index))
                                        .font(.caption2)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 8)
                                .foregroundStyle(selectedTab == index ? .primary : .secondary)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .glassEffect(.regular, in: .capsule)
                }
                .padding()
            }

            Text("上記の例では、タブバー全体が一つのガラス面として機能し、選択状態が変わっても統一感のある見た目を維持します。")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
    }

    private var navigationBarIntegrationExample: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("ナビゲーションバーとの統合")
                .font(.headline)

            Text("""
            iOS 26では、NavigationStackやNavigationSplitViewは内部的にGlassEffectContainerを使用しています。

            これにより:
            • ナビゲーションバーとツールバーが同じガラス面を共有
            • スクロール時の滑らかな透明度変化
            • 戻るボタンやタイトルの統一された見た目
            """)
            .font(.subheadline)
            .foregroundStyle(.secondary)

            // ナビゲーションバーのイメージ図
            VStack(spacing: 0) {
                // ナビゲーションバー
                HStack {
                    Image(systemName: "chevron.left")
                    Text("戻る")
                    Spacer()
                    Text("タイトル")
                        .fontWeight(.semibold)
                    Spacer()
                    Image(systemName: "ellipsis.circle")
                }
                .padding()
                .background(.ultraThinMaterial)

                // コンテンツ
                Rectangle()
                    .fill(.quaternary)
                    .frame(height: 100)
                    .overlay {
                        Text("コンテンツ")
                            .foregroundStyle(.secondary)
                    }
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
    }

    private var codeExample: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("コード例")
                .font(.headline)

            Text("""
            // GlassEffectContainer の基本的な使用法
            GlassEffectContainer {
                HStack {
                    Button("Tab 1") { }
                        .glassEffect(in: .capsule)
                    Button("Tab 2") { }
                        .glassEffect(in: .capsule)
                }
            }

            // ナビゲーションでの自動適用
            NavigationStack {
                ContentView()
                    .toolbar {
                        // ツールバーアイテムは自動的に
                        // 同じGlassEffectContainerに含まれる
                    }
            }
            """)
            .font(.system(.caption, design: .monospaced))
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
    }

    private func tabIcon(for index: Int) -> String {
        switch index {
        case 0: return "house.fill"
        case 1: return "magnifyingglass"
        case 2: return "person.fill"
        default: return "circle"
        }
    }

    private func tabTitle(for index: Int) -> String {
        switch index {
        case 0: return "ホーム"
        case 1: return "検索"
        case 2: return "プロフィール"
        default: return ""
        }
    }
}

#Preview("glassEffect") {
    NavigationStack {
        GlassEffectDemo()
    }
}

#Preview("Container") {
    NavigationStack {
        GlassEffectContainerDemo()
    }
}
