//
//  PlayersInteractorTests.swift
//  SquadTests
//
//  Created by kyuminlee on 8/8/24.
//

import XCTest
import Combine
import SwiftUI
@testable import Squad

final class PlayersInteractorTests: XCTestCase {
    
    private var mockedStore: PersistentStore!
    private var dbRepository: PlayersDBRepository!
    private var sut: PlayersInteractor!
    private var players: [Player]!
    private var playersBinding: Binding<[Player]>!
    private var cancelBag = Set<AnyCancellable>()
     
    override func setUp() {
        mockedStore = SQLiteStack(dbLocation: .temporary)
        dbRepository = RealPlayersDBRepository(persistentStore: mockedStore)
        sut = RealPlayersInteractor(dbRepository: dbRepository)
        players = []
        playersBinding = Binding(get: { self.players }, set: { self.players = $0})
    }
    
    override func tearDown() {
        mockedStore = nil
        dbRepository = nil
        sut = nil
        players = nil
        playersBinding = nil
        cancelBag = Set<AnyCancellable>()
    }
    
    func test_load() throws {
        sut.add(name: "Son Heung Min", position: .striker)
        sut.load(players: playersBinding)
        
        XCTAssertEqual(playersBinding.wrappedValue.count, 1)
    }
    
    func test_add() throws {
        sut.add(name: "Kim Min Jae", position: .defender)
        sut.add(name: "Kim Min Jae", position: .defender)
        sut.load(players: playersBinding)
        
        XCTAssertEqual(playersBinding.wrappedValue.count, 2)
    }
    
    func test_update() throws {
        sut.add(name: "Kim Min Jae", position: .defender)
        sut.load(players: playersBinding)
        
        XCTAssertEqual(playersBinding.wrappedValue.count, 1)
        
        sut.update(id: playersBinding.wrappedValue.first?.id, position: .midfielder)
        sut.load(players: playersBinding)
        XCTAssertEqual(playersBinding.wrappedValue.first?.position, .midfielder)
    }
    
    func test_delete() throws {
        sut.add(name: "Son Heung Min", position: .striker)
        sut.load(players: playersBinding)
        
        XCTAssertEqual(playersBinding.wrappedValue.count, 1)
        let atOffsets = IndexSet(playersBinding.wrappedValue.startIndex...playersBinding.wrappedValue.endIndex)
        sut.delete(players: playersBinding.wrappedValue, atOffsets: atOffsets)
        sut.load(players: playersBinding)
        XCTAssert(playersBinding.isEmpty)
    }
}
