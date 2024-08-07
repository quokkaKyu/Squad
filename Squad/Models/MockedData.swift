//
//  MockedData.swift
//  Squad
//
//  Created by kyuminlee on 8/6/24.
//

import Foundation

extension Player {
    static let mockedData: [Player] = [
        Player(id: UUID(), name: "Kylian Mbappé Lottin", position: .striker),
        Player(id: UUID(), name: "KimMinJae", position: .defender),
        Player(id: UUID(), name: "Jude Victor William Bellingham", position: .midfielder),
        Player(id: UUID(), name: "Vinicius Junior", position: .striker)
    ]
}
