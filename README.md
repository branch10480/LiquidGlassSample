# Liquid Glass Sample

A comprehensive SwiftUI sample app demonstrating the new **Liquid Glass** design language introduced in iOS 26.

## Overview

iOS 26 introduces Liquid Glass, a new visual design system that brings translucent, glass-like effects to navigation bars, toolbars, tab bars, and custom UI elements. This sample app showcases how to implement and customize these effects in your SwiftUI applications.

## Requirements

- Xcode 26.0+
- iOS 26.0+
- Swift 5.9+

## Features

### NavigationStack

| Demo | Description |
|------|-------------|
| **Basic NavigationStack** | Demonstrates automatic Liquid Glass styling on navigation bars with scroll-responsive transparency |
| **Toolbar Customization** | Shows how toolbar items inherit Liquid Glass styling with `primaryAction`, `secondaryAction`, and `bottomBar` placements |
| **Scroll Effect** | Interactive demo of `toolbarBackgroundVisibility` with automatic, visible, and hidden modes |

### NavigationSplitView

| Demo | Description |
|------|-------------|
| **Two-Column Layout** | Sidebar and detail view with Liquid Glass effects on each column |
| **Three-Column Layout** | Sidebar, content, and detail columns with unified glass styling |

### Glass Effect Modifier

| Demo | Description |
|------|-------------|
| **glassEffect()** | Apply Liquid Glass to any custom view with shape options (capsule, rounded rect, circle) |
| **GlassEffectContainer** | Share unified glass surfaces across multiple child views |

### TabView Integration

| Demo | Description |
|------|-------------|
| **TabView + Navigation** | Combine TabView with NavigationStack, demonstrating coordinated Liquid Glass effects on both tab bar and navigation bar |

## Key APIs Demonstrated

```swift
// Apply glass effect to custom views
Text("Hello")
    .padding()
    .glassEffect(.regular, in: .capsule)

// Interactive glass effect (responds to touch)
Button("Tap Me") { }
    .glassEffect(.regular.interactive(), in: .rect(cornerRadius: 12))

// Control navigation bar transparency
.toolbarBackgroundVisibility(.automatic, for: .navigationBar)

// Control tab bar transparency
.toolbarBackgroundVisibility(.visible, for: .tabBar)
```

## Project Structure

```
LiquidGlassSample/
├── ContentView.swift              # Main menu with navigation to all demos
├── NavigationStackDemos.swift     # NavigationStack examples
├── NavigationSplitViewDemos.swift # 2-column and 3-column layouts
├── GlassEffectDemos.swift         # glassEffect modifier examples
└── TabViewNavigationDemo.swift    # TabView integration examples
```

## Sample Data

The app includes sample data models (`Category` and `Item`) to demonstrate real-world navigation patterns in multi-column layouts.

## Liquid Glass Behavior

The Liquid Glass effect creates a frosted glass appearance where:

- Background content is visible through the blur
- Transparency adjusts dynamically based on scroll position
- Touch interactions trigger subtle visual feedback (with `.interactive()`)
- Navigation bars become more opaque as content scrolls underneath

## License

This sample code is provided for educational purposes.
