//
//  SQLiteStackTests.swift
//  SquadTests
//
//  Created by kyuminlee on 8/7/24.
//

import XCTest
import Combine
@testable import Squad

final class SQLiteStackTests: XCTestCase {
    
    var sut: SQLiteStack!
    
    override func setUp() {
        sut = nil
        sut = SQLiteStack(dbLocation: .temporary)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_addPlayer() throws {
        try sut.addPlayer(name: "Messi", position: .striker)
        let players = try sut.fetchPlayers()
        
        XCTAssertEqual(players.count, 1)
        XCTAssertEqual(players.first?.name, "Messi")
    }
    
    func test_fetchPlayers() throws {
        let player1 = "Kim Min Jae"
        let player2 = "Son Heung Min"
        
        try sut.addPlayer(name: player1, position: .defender)
        try sut.addPlayer(name: player2, position: .striker)
        let players = try sut.fetchPlayers()
        
        XCTAssertEqual(players.count, 2)
        XCTAssertTrue(players.contains(where: {
            $0.name == player1
        }))
        XCTAssertTrue(players.contains(where: {
            $0.name == player2
        }))
    }
    
    func test_updatePlayer() throws {
        let player1 = "Kim Min Jae"
        
        try sut.addPlayer(name: player1, position: .defender)
        try sut.addPlayer(name: "Son Heung Min", position: .striker)
        let players = try sut.fetchPlayers()
        
        if let id = players.first(where: { $0.name == player1 }).map({ $0.id }) {
            try sut.updatePlayer(id: id, newPosition: .striker)
        } else {
            XCTFail()
        }
        
        let playersUpdated = try sut.fetchPlayers()
        if let position = playersUpdated.first(where: { $0.name == player1 })?.position {
            XCTAssertEqual(position, .striker)
        } else {
            XCTFail()
        }
    }
    
    func test_deletePlayer() throws {
        let player1 = "Kim Min Jae"
        let player2 = "Son Heung Min"
        
        try sut.addPlayer(name: player1, position: .defender)
        try sut.addPlayer(name: player2, position: .striker)
        let players = try sut.fetchPlayers()
        
        XCTAssertEqual(players.count, 2)

        if let id = players.first(where: { $0.name == player1 }).map({ $0.id }) {
            try sut.deletePlayer(id: id)
        } else {
            XCTFail()
        }
        
        let playersDeleted = try sut.fetchPlayers()
        
        XCTAssertEqual(playersDeleted.count, 1)
        XCTAssertEqual(playersDeleted.first?.name, player2)
        
    }
}
