//
//  Contact.swift
//  CleosPage
//
//  Created by Jordan McKnight on 4/4/25.
//


import Foundation

struct Contact: Identifiable, Codable { // Conform to Codable
    let id: UUID // Unique identifier
    var name: String
    var number: String
    
    init(id: UUID = UUID(), name: String, number: String) {
        self.id = id
        self.name = name
        self.number = number
    }
}
