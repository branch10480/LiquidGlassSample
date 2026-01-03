//
//  ContentView.swift
//  LiquidGlassSample
//
//  Created by Toshiharu Imaeda on 2026/01/03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Navigation Stack") {
                    NavigationLink("基本的なNavigationStack") {
                        BasicNavigationStackDemo()
                    }

                    NavigationLink("ツールバーカスタマイズ") {
                        ToolbarCustomizationDemo()
                    }

                    NavigationLink("スクロール連動効果") {
                        ScrollEffectDemo()
                    }
                }

                Section("Navigation Split View") {
                    NavigationLink("2カラムレイアウト") {
                        TwoColumnSplitViewDemo()
                    }

                    NavigationLink("3カラムレイアウト") {
                        ThreeColumnSplitViewDemo()
                    }
                }

                Section("Glass Effect") {
                    NavigationLink("glassEffect モディファイア") {
                        GlassEffectDemo()
                    }

                    NavigationLink("GlassEffectContainer") {
                        GlassEffectContainerDemo()
                    }
                }

                Section("TabView + Navigation") {
                    NavigationLink("TabViewとの組み合わせ") {
                        TabViewNavigationDemo()
                    }
                }
            }
            .navigationTitle("Liquid Glass Demo")
        }
    }
}

#Preview {
    ContentView()
}
