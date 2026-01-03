//
//  TabViewNavigationDemo.swift
//  LiquidGlassSample
//
//  Created by Toshiharu Imaeda on 2026/01/03.
//

import SwiftUI

// MARK: - TabView + Navigation デモ
/// iOS 26では、TabViewのタブバーにもLiquid Glass効果が適用されます
/// NavigationStackと組み合わせた場合の動作を示します
struct TabViewNavigationDemo: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            // タブ1: ホーム
            Tab("ホーム", systemImage: "house.fill", value: 0) {
                HomeTabView()
            }

            // タブ2: 検索
            Tab("検索", systemImage: "magnifyingglass", value: 1) {
                SearchTabView()
            }

            // タブ3: お気に入り
            Tab("お気に入り", systemImage: "heart.fill", value: 2) {
                FavoritesTabView()
            }

            // タブ4: 設定
            Tab("設定", systemImage: "gearshape.fill", value: 3) {
                SettingsTabView()
            }
        }
        // iOS 26: TabViewのタブバーにLiquid Glass効果が自動適用
        // .tabBarBackgroundVisibility で制御可能
    }
}

// MARK: - ホームタブ
struct HomeTabView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Liquid Glassの説明
                    VStack(alignment: .leading, spacing: 12) {
                        Text("TabView + NavigationStack")
                            .font(.headline)

                        Text("""
                        iOS 26では、TabViewとNavigationStackを組み合わせると:

                        • タブバーにLiquid Glass効果が適用
                        • ナビゲーションバーにも個別にLiquid Glass
                        • スクロール時に両方が連動して動作
                        • 画面遷移時のスムーズなアニメーション
                        """)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))

                    // カラフルなカード
                    ForEach(0..<10, id: \.self) { index in
                        NavigationLink {
                            CardDetailView(index: index)
                        } label: {
                            HStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(hue: Double(index) / 10, saturation: 0.6, brightness: 0.9))
                                    .frame(width: 60, height: 60)

                                VStack(alignment: .leading) {
                                    Text("カード \(index + 1)")
                                        .font(.headline)
                                    Text("タップして詳細を表示")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.tertiary)
                            }
                            .padding()
                            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationTitle("ホーム")
        }
    }
}

// MARK: - カード詳細ビュー
struct CardDetailView: View {
    let index: Int

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color(hue: Double(index) / 10, saturation: 0.6, brightness: 0.9))
                    .frame(height: 250)
                    .overlay {
                        VStack {
                            Image(systemName: "star.fill")
                                .font(.system(size: 60))
                            Text("カード \(index + 1)")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        .foregroundStyle(.white)
                    }

                VStack(alignment: .leading, spacing: 12) {
                    Text("ナビゲーション遷移とLiquid Glass")
                        .font(.headline)

                    Text("""
                    画面遷移時のポイント:

                    • 戻るボタンもLiquid Glassスタイル
                    • タブバーは遷移中も表示を維持
                    • 新しい画面でもガラス効果は継続
                    • スクロールするとナビゲーションバーの透明度が変化
                    """)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))

                ForEach(0..<15, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.quaternary)
                        .frame(height: 60)
                }
            }
            .padding()
        }
        .navigationTitle("カード \(index + 1)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - 検索タブ
struct SearchTabView: View {
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<20, id: \.self) { index in
                    NavigationLink("検索結果 \(index + 1)") {
                        Text("詳細ビュー \(index + 1)")
                            .navigationTitle("結果 \(index + 1)")
                    }
                }
            }
            .navigationTitle("検索")
            .searchable(text: $searchText, prompt: "キーワードを入力")
            // iOS 26: 検索バーもLiquid Glassスタイルで表示
        }
    }
}

// MARK: - お気に入りタブ
struct FavoritesTabView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(0..<12, id: \.self) { index in
                        NavigationLink {
                            Text("お気に入り \(index + 1)")
                                .navigationTitle("詳細")
                        } label: {
                            VStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color(hue: Double(index) / 12, saturation: 0.5, brightness: 0.95))
                                    .frame(height: 120)
                                    .overlay {
                                        Image(systemName: "heart.fill")
                                            .font(.title)
                                            .foregroundStyle(.white)
                                    }

                                Text("アイテム \(index + 1)")
                                    .font(.caption)
                                    .foregroundStyle(.primary)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationTitle("お気に入り")
        }
    }
}

// MARK: - 設定タブ
struct SettingsTabView: View {
    @State private var notificationsEnabled = true
    @State private var darkModeEnabled = false
    @State private var hapticFeedbackEnabled = true

    var body: some View {
        NavigationStack {
            List {
                Section("一般") {
                    NavigationLink("アカウント") {
                        Text("アカウント設定")
                            .navigationTitle("アカウント")
                    }

                    NavigationLink("プライバシー") {
                        Text("プライバシー設定")
                            .navigationTitle("プライバシー")
                    }
                }

                Section("表示") {
                    Toggle("ダークモード", isOn: $darkModeEnabled)
                    Toggle("触覚フィードバック", isOn: $hapticFeedbackEnabled)
                }

                Section("通知") {
                    Toggle("通知を有効にする", isOn: $notificationsEnabled)

                    if notificationsEnabled {
                        NavigationLink("通知設定") {
                            Text("詳細な通知設定")
                                .navigationTitle("通知")
                        }
                    }
                }

                Section("Liquid Glass について") {
                    NavigationLink("タブバーの動作") {
                        TabBarExplanationView()
                    }
                }
            }
            .navigationTitle("設定")
        }
    }
}

// MARK: - タブバー説明ビュー
struct TabBarExplanationView: View {
    @State private var tabBarVisibility: Visibility = .automatic

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("タブバーのLiquid Glass")
                        .font(.headline)

                    Text("""
                    iOS 26のTabViewでは、タブバーに自動的にLiquid Glass効果が適用されます。

                    特徴:
                    • 背景コンテンツが透けて見える
                    • スクロール時に動的に変化
                    • 選択中のタブがハイライト表示
                    """)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))

                VStack(alignment: .leading, spacing: 12) {
                    Text("toolbarBackgroundVisibility")
                        .font(.headline)

                    Picker("タブバー表示", selection: $tabBarVisibility) {
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

                VStack(alignment: .leading, spacing: 12) {
                    Text("コード例")
                        .font(.headline)

                    Text("""
                    TabView {
                        HomeView()
                            .tabItem {
                                Label("ホーム", systemImage: "house")
                            }
                    }
                    // タブバーの背景を制御
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
                    """)
                    .font(.system(.caption, design: .monospaced))
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding()
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))

                ForEach(0..<10, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.quaternary)
                        .frame(height: 60)
                }
            }
            .padding()
        }
        .navigationTitle("タブバー")
        .toolbarBackgroundVisibility(tabBarVisibility, for: .tabBar)
    }

    private var visibilityDescription: String {
        switch tabBarVisibility {
        case .automatic:
            return "スクロール状態に応じて自動調整"
        case .visible:
            return "常にLiquid Glass背景を表示"
        case .hidden:
            return "背景を非表示（完全に透明）"
        }
    }
}

#Preview {
    TabViewNavigationDemo()
}
