//
//  AutumnColors.swift
//  CleosPage
//
//  Created by Jordan McKnight on 4/3/25.
//


import SwiftUI

class ColorManager: ObservableObject {
    @Published var gradientColors: [Color] = [Color.orange, Color.red, Color.brown]
}

struct AutumnColors {
    static let autumnOrange = Color(red: 0.95, green: 0.5, blue: 0.15)
    static let autumnBrown = Color(red: 0.55, green: 0.27, blue: 0.07)
    static let autumnYellow = Color(red: 1.0, green: 0.8, blue: 0.4)
}
