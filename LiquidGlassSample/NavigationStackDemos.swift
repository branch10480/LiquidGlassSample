//
//  NavigationStackDemos.swift
//  LiquidGlassSample
//
//  Created by Toshiharu Imaeda on 2026/01/03.
//

import SwiftUI

// MARK: - 基本的なNavigationStack デモ
/// iOS 26では、NavigationStackは自動的にLiquid Glassスタイルが適用されます
/// ナビゲーションバーは半透明のガラス効果を持ち、背景がぼかして透けて見えます
struct BasicNavigationStackDemo: View {
    let items = (1...50).map { "アイテム \($0)" }

    var body: some View {
        List(items, id: \.self) { item in
            NavigationLink(item) {
                DetailView(title: item)
            }
        }
        .navigationTitle("基本的なNavigationStack")
        // iOS 26: ナビゲーションバーのLiquid Glass効果は自動適用
        // .toolbarBackgroundVisibility で透明度を制御可能
        .toolbarBackgroundVisibility(.automatic, for: .navigationBar)
    }
}

// MARK: - 詳細ビュー
struct DetailView: View {
    let title: String

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 背景画像を配置してガラス効果を確認しやすくする
                Image(systemName: "photo.artframe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                    .foregroundStyle(.secondary)

                Text("このビューでは、スクロール時にナビゲーションバーの")
                    .font(.body)
                Text("Liquid Glass効果が確認できます。")
                    .font(.body)

                Text("上にスクロールすると、ナビゲーションバーの背後にコンテンツが透けて見え、ガラスのようなぼかし効果が適用されます。")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                    .padding()

                ForEach(1...20, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.accentColor.opacity(0.1 + Double(index) * 0.03))
                        .frame(height: 60)
                        .overlay {
                            Text("コンテンツ \(index)")
                        }
                }
            }
            .padding()
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.large)
    }
}

// MARK: - ツールバーカスタマイズ デモ
/// Liquid Glassスタイルのツールバーアイテムをカスタマイズする方法
struct ToolbarCustomizationDemo: View {
    @State private var isBookmarked = false
    @State private var showingSheet = false

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                explanationCard(
                    title: "ツールバーアイテム",
                    description: "iOS 26では、ツールバーアイテムもLiquid Glassスタイルで表示されます。ボタンはガラス効果のある背景を持ちます。"
                )

                explanationCard(
                    title: "toolbarRole",
                    description: ".toolbarRole(.editor)や.toolbarRole(.browser)を使用して、ツールバーの役割を指定できます。"
                )

                explanationCard(
                    title: "ToolbarItem配置",
                    description: "primaryAction, secondaryAction, cancellationAction などの配置オプションがLiquid Glassスタイルに最適化されています。"
                )

                ForEach(1...15, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.quaternary)
                        .frame(height: 80)
                }
            }
            .padding()
        }
        .navigationTitle("ツールバー")
        .navigationBarTitleDisplayMode(.inline)
        // iOS 26: ツールバーアイテムにはLiquid Glassスタイルが自動適用
        .toolbar {
            // プライマリアクション - 右上に配置
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showingSheet = true
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
            }

            // セカンダリアクション
            ToolbarItem(placement: .secondaryAction) {
                Button {
                    isBookmarked.toggle()
                } label: {
                    Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                }
            }

            // ボトムバーにもLiquid Glass効果
            ToolbarItem(placement: .bottomBar) {
                HStack {
                    Button("編集") { }
                    Spacer()
                    Text("アイテム数: 15")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Button("追加") { }
                }
            }
        }
        // ボトムバーの背景もLiquid Glass
        .toolbarBackgroundVisibility(.visible, for: .bottomBar)
        .sheet(isPresented: $showingSheet) {
            NavigationStack {
                Text("共有シート")
                    .navigationTitle("共有")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("閉じる") {
                                showingSheet = false
                            }
                        }
                    }
            }
        }
    }

    private func explanationCard(title: String, description: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            Text(description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
}

// MARK: - スクロール連動効果 デモ
/// スクロールに応じてナビゲーションバーのLiquid Glass効果がどう変化するかを示す
struct ScrollEffectDemo: View {
    @State private var backgroundVisibility: Visibility = .automatic

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // 説明セクション
                VStack(alignment: .leading, spacing: 12) {
                    Text("スクロール連動の動作")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("iOS 26のLiquid Glassナビゲーションバーは、スクロール位置に応じて動的に変化します。")

                    Text("• コンテンツが上端の時: 完全に透明")
                    Text("• スクロール中: ガラス効果が現れる")
                    Text("• 背景がぼかされて透ける")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))

                // 背景表示の切り替え
                VStack(alignment: .leading, spacing: 12) {
                    Text("toolbarBackgroundVisibility")
                        .font(.headline)

                    Picker("表示設定", selection: $backgroundVisibility) {
                        Text("Automatic").tag(Visibility.automatic)
                        Text("Visible").tag(Visibility.visible)
                        Text("Hidden").tag(Visibility.hidden)
                    }
                    .pickerStyle(.segmented)

                    Text(visibilityDescription)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding()
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))

                // カラフルなコンテンツでガラス効果を確認
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(0..<30, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(hue: Double(index) / 30, saturation: 0.6, brightness: 0.9))
                            .frame(height: 100)
                            .overlay {
                                Text("\(index + 1)")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                            }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("スクロール連動")
        .navigationBarTitleDisplayMode(.large)
        .toolbarBackgroundVisibility(backgroundVisibility, for: .navigationBar)
    }

    private var visibilityDescription: String {
        switch backgroundVisibility {
        case .automatic:
            return "システムがスクロール状態に応じて自動的にガラス効果を調整します"
        case .visible:
            return "常にガラス効果が表示されます"
        case .hidden:
            return "ガラス効果が非表示になり、背景が完全に透明になります"
        }
    }
}

#Preview("Basic") {
    NavigationStack {
        BasicNavigationStackDemo()
    }
}

#Preview("Toolbar") {
    NavigationStack {
        ToolbarCustomizationDemo()
    }
}

#Preview("Scroll") {
    NavigationStack {
        ScrollEffectDemo()
    }
}
