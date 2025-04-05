//
//  Note.swift
//  CleosPage
//
//  Created by Jordan McKnight on 4/4/25.
//


import SwiftUI
import SwiftData
import Foundation



struct Note: Identifiable, Codable { // Conform to Codable
    let id: UUID // Use UUID for unique identification
    var text: String
    var color: String
    
    init(id: UUID = UUID(), text: String, color: String) {
        self.id = id
        self.text = text
        self.color = color
    }
    
    // Optional helper function for generating colors, if needed
    func getColor() -> Color {
        switch color.lowercased() {
        case "blue":
            return .blue
        case "green":
            return .green
        case "orange":
            return .orange
        case "yellow":
            return .yellow
        case "purple":
            return .purple
        default:
            return .gray
        }
    }
}
