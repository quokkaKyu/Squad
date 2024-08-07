//
//  Models.swift
//  Squad
//
//  Created by kyuminlee on 7/4/24.
//

import Foundation

struct Player: Identifiable {
    let id: UUID
    let name: String
    let position: Position
    
    enum Position: String {
        case striker = "striker"
        case midfielder = "midfielder"
        case defender = "defender"
        case goalkeeper = "goalkeeper"
    }
}
