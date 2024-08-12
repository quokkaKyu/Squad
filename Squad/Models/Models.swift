//
//  Models.swift
//  Squad
//
//  Created by kyuminlee on 7/4/24.
//

import Foundation

struct Player: Identifiable {
    let id: UUID
    var name: String
    var position: Position
    
    enum Position: String, CaseIterable {
        case striker = "ST"
        case midfielder = "MF"
        case defender = "DF"
        case goalkeeper = "GK"
    }
}
