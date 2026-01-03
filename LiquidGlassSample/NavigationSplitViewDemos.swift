//
//  NavigationSplitViewDemos.swift
//  LiquidGlassSample
//
//  Created by Toshiharu Imaeda on 2026/01/03.
//

import SwiftUI

// MARK: - サンプルデータモデル
struct Category: Identifiable, Hashable {
    let id: String
    let name: String
    let icon: String
    let items: [Item]

    init(id: String = UUID().uuidString, name: String, icon: String, items: [Item]) {
        self.id = id
        self.name = name
        self.icon = icon
        self.items = items
    }
}

struct Item: Identifiable, Hashable {
    let id: String
    let title: String
    let description: String
    let color: Color

    init(id: String = UUID().uuidString, title: String, description: String, color: Color) {
        self.id = id
        self.title = title
        self.description = description
        self.color = color
    }
}

// MARK: - サンプルデータ
enum SampleData {
    static let categories: [Category] = [
        Category(id: "design", name: "デザイン", icon: "paintbrush.fill", items: [
            Item(id: "color", title: "カラーパレット", description: "アプリの配色を管理します。ブランドカラーやアクセントカラーを定義し、一貫したビジュアルアイデンティティを構築できます。", color: .blue),
            Item(id: "typography", title: "タイポグラフィ", description: "フォントスタイルを設定します。Dynamic Typeに対応し、アクセシビリティにも配慮したテキスト表示を実現します。", color: .purple),
            Item(id: "icons", title: "アイコン", description: "SF Symbolsを活用します。3000以上のシンボルから選択でき、ウェイトやスケールの調整も自由自在です。", color: .orange)
        ]),
        Category(id: "development", name: "開発", icon: "hammer.fill", items: [
            Item(id: "swiftui", title: "SwiftUI", description: "宣言的UIフレームワーク。コードでUIを記述し、プレビューでリアルタイムに確認できます。", color: .blue),
            Item(id: "combine", title: "Combine", description: "リアクティブプログラミング。非同期イベントを処理するための統一されたAPIを提供します。", color: .green),
            Item(id: "swiftdata", title: "Swift Data", description: "データ永続化フレームワーク。SwiftUIとシームレスに統合され、モデルの保存と取得が簡単です。", color: .red)
        ]),
        Category(id: "testing", name: "テスト", icon: "checkmark.seal.fill", items: [
            Item(id: "unit", title: "ユニットテスト", description: "個別機能のテスト。XCTestを使用して、関数やメソッドが期待通りに動作することを検証します。", color: .mint),
            Item(id: "ui", title: "UIテスト", description: "画面遷移のテスト。ユーザーインタラクションをシミュレートし、UIの動作を自動検証します。", color: .cyan),
            Item(id: "performance", title: "パフォーマンス", description: "速度と効率の検証。Instrumentsを使用して、メモリ使用量やCPU負荷を分析します。", color: .indigo)
        ]),
        Category(id: "deployment", name: "デプロイ", icon: "shippingbox.fill", items: [
            Item(id: "testflight", title: "TestFlight", description: "ベータ版配布ツール。テスターにアプリを配布し、フィードバックを収集できます。", color: .blue),
            Item(id: "appstore", title: "App Store", description: "アプリ公開プラットフォーム。審査を経て、世界中のユーザーにアプリを届けられます。", color: .pink),
            Item(id: "analytics", title: "アナリティクス", description: "使用状況分析。App Store Connectでダウンロード数やユーザー動向を把握できます。", color: .orange)
        ])
    ]
}

// MARK: - 2カラムレイアウト デモ
/// iOS 26のNavigationSplitViewでは、サイドバーとディテールビューの
/// 両方にLiquid Glass効果が適用されます
struct TwoColumnSplitViewDemo: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedCategory: Category?
    @State private var columnVisibility: NavigationSplitViewVisibility = .all

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            // サイドバー - Liquid Glassスタイルが自動適用
            List(SampleData.categories, selection: $selectedCategory) { category in
                NavigationLink(value: category) {
                    HStack {
                        Image(systemName: category.icon)
                            .foregroundStyle(.tint)
                            .frame(width: 24)
                        Text(category.name)
                    }
                }
            }
            .navigationTitle("カテゴリ")
            .navigationDestination(for: Category.self) { category in
                CategoryDetailView(category: category)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                            Text("戻る")
                        }
                    }
                }
            }
        } detail: {
            // ディテールビュー（初期表示用）
            if let category = selectedCategory {
                CategoryDetailView(category: category)
            } else {
                ContentUnavailableView(
                    "カテゴリを選択",
                    systemImage: "sidebar.left",
                    description: Text("左のサイドバーからカテゴリを選んでください")
                )
            }
        }
        .navigationSplitViewStyle(.balanced)
        .toolbar(.hidden, for: .navigationBar)
    }
}

// MARK: - カテゴリ詳細ビュー
struct CategoryDetailView: View {
    let category: Category

    var body: some View {
        List(category.items) { item in
            HStack(spacing: 16) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(item.color.gradient)
                    .frame(width: 44, height: 44)
                    .overlay {
                        Image(systemName: "sparkle")
                            .foregroundStyle(.white)
                    }

                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title)
                        .font(.headline)
                    Text(item.description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
            }
            .padding(.vertical, 4)
        }
        .navigationTitle(category.name)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    // アクション
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

// MARK: - 3カラムレイアウト デモ
/// 3カラムレイアウトでは、サイドバー、コンテンツ、ディテールの
/// 各カラムにLiquid Glass効果が適用されます
struct ThreeColumnSplitViewDemo: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedCategory: Category?
    @State private var selectedItem: Item?
    @State private var columnVisibility: NavigationSplitViewVisibility = .all

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            // サイドバー（カテゴリ一覧）
            List(SampleData.categories, selection: $selectedCategory) { category in
                Button {
                    selectedCategory = category
                    selectedItem = nil
                } label: {
                    HStack {
                        Image(systemName: category.icon)
                            .foregroundStyle(.tint)
                            .frame(width: 24)
                        Text(category.name)
                    }
                }
                .buttonStyle(.plain)
                .tag(category)
            }
            .navigationTitle("カテゴリ")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                            Text("戻る")
                        }
                    }
                }
            }
        } content: {
            // コンテンツカラム（アイテム一覧）
            if let category = selectedCategory {
                List(category.items, selection: $selectedItem) { item in
                    Button {
                        selectedItem = item
                    } label: {
                        HStack(spacing: 12) {
                            Circle()
                                .fill(item.color.gradient)
                                .frame(width: 32, height: 32)
                                .overlay {
                                    Image(systemName: "star.fill")
                                        .font(.caption)
                                        .foregroundStyle(.white)
                                }
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.body)
                                Text(item.description)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(1)
                            }
                        }
                    }
                    .buttonStyle(.plain)
                    .tag(item)
                }
                .navigationTitle(category.name)
            } else {
                ContentUnavailableView(
                    "カテゴリを選択",
                    systemImage: "list.bullet",
                    description: Text("サイドバーからカテゴリを選んでください")
                )
            }
        } detail: {
            // ディテールカラム（アイテム詳細）
            if let item = selectedItem {
                ItemDetailView(item: item)
            } else {
                ContentUnavailableView(
                    "アイテムを選択",
                    systemImage: "doc.text",
                    description: Text("リストからアイテムを選んでください")
                )
            }
        }
        .navigationSplitViewStyle(.balanced)
        .toolbar(.hidden, for: .navigationBar)
    }
}

// MARK: - アイテム詳細ビュー
struct ItemDetailView: View {
    let item: Item

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // ヘッダー
                RoundedRectangle(cornerRadius: 24)
                    .fill(item.color.gradient)
                    .frame(height: 200)
                    .overlay {
                        VStack(spacing: 12) {
                            Image(systemName: "sparkles")
                                .font(.system(size: 50))
                            Text(item.title)
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        .foregroundStyle(.white)
                    }

                // 説明
                VStack(alignment: .leading, spacing: 12) {
                    Text("説明")
                        .font(.headline)
                    Text(item.description)
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))

                // Liquid Glass説明
                VStack(alignment: .leading, spacing: 12) {
                    Text("3カラムレイアウトのLiquid Glass")
                        .font(.headline)

                    Text("""
                    iOS 26のNavigationSplitViewでは:

                    • 各カラムの境界がガラス効果で区切られます
                    • サイドバーは半透明のガラス背景を持ちます
                    • コンテンツがカラム間を遷移する際、滑らかなアニメーション
                    • iPad/Macで特に効果的です
                    """)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
            }
            .padding()
        }
        .navigationTitle(item.title)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    // 編集
                } label: {
                    Text("編集")
                }
            }
        }
    }
}

#Preview("Two Column") {
    TwoColumnSplitViewDemo()
}

#Preview("Three Column") {
    ThreeColumnSplitViewDemo()
}
