//
//  PlayersDBRepositoryTests.swift
//  SquadTests
//
//  Created by kyuminlee on 8/8/24.
//

import XCTest
import Combine
@testable import Squad

final class PlayersDBRepositoryTests: XCTestCase {
    
    var mockedStore: PersistentStore!
    var sut: RealPlayersDBRepository!
    var cancelBag = Set<AnyCancellable>()
    
    override func setUp() {
        mockedStore = SQLiteStack(dbLocation: .temporary)
        sut = RealPlayersDBRepository(persistentStore: mockedStore)
    }
    
    override func tearDown() {
        cancelBag = Set<AnyCancellable>()
        mockedStore = nil
        sut = nil
    }
    
    func test_addPlayer() throws {
        let player = "Son Heung Min"
        
        sut.addPlayer(name: player, position: .striker)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    XCTFail()
                }
            }, receiveValue: { _ in
                
            })
            .store(in: &cancelBag)
        
        sut.fetchPlayers()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    XCTFail()
                }
            } receiveValue: { players in
                XCTAssertEqual(players.count, 1)
                XCTAssertEqual(players.first?.name, player)
            }
            .store(in: &cancelBag)
    }
    
    func test_fetchPlayers() throws {
        let player1 = "Son Heung Min"
        let player2 = "Kim Min Jae"
        
        sut.addPlayer(name: player1, position: .striker)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    XCTFail()
                }
            } receiveValue: { _ in
                
            }
            .store(in: &cancelBag)
        
        sut.addPlayer(name: player2, position: .defender)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    XCTFail()
                }
            } receiveValue: { _ in
                
            }
            .store(in: &cancelBag)
        
        sut.fetchPlayers()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    XCTFail()
                }
            } receiveValue: { players in
                XCTAssertEqual(players.count, 2)
                XCTAssertEqual(players.first?.name, player1)
                XCTAssertEqual(players.last?.name, player2)
            }
            .store(in: &cancelBag)
    }
    
    func test_updatePlayer() throws {
        let player1 = "Son Heung Min"
        var players: [Player] = []
        
        sut.addPlayer(name: player1, position: .striker)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    XCTFail()
                }
            }, receiveValue: { _ in
                
            })
            .store(in: &cancelBag)
        
        sut.fetchPlayers()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    XCTFail()
                }
            } receiveValue: { playersData in
                XCTAssertEqual(playersData.first?.name, player1)
                XCTAssertEqual(playersData.first?.position, .striker)
                players = playersData
            }
            .store(in: &cancelBag)
        
        if let player = players.first(where: { $0.name == player1 }) {
            sut.updatePlayer(id: player.id, newPosition: .midfielder)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure:
                        XCTFail()
                    }
                } receiveValue: { _ in
                    
                }
                .store(in: &cancelBag)
            
        } else {
            XCTFail()
        }
        
        sut.fetchPlayers()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    XCTFail()
                }
            } receiveValue: { playersData in
                XCTAssertEqual(playersData.first?.position, .midfielder)
            }
            .store(in: &cancelBag)
    }
    
    func test_deletePlayer() throws {
        let player1 = "Son Heung Min"
        var players: [Player] = []
        
        sut.addPlayer(name: player1, position: .striker)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    XCTFail()
                }
            }, receiveValue: { _ in
                
            })
            .store(in: &cancelBag)
        
        sut.fetchPlayers()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    XCTFail()
                }
            } receiveValue: { playersData in
                XCTAssertEqual(playersData.count, 1)
                players = playersData
            }
            .store(in: &cancelBag)
        
        if let player = players.first(where: { $0.name == player1 }) {
            sut.deletePlayer(id: player.id)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure:
                        XCTFail()
                    }
                } receiveValue: { _ in
                    
                }
                .store(in: &cancelBag)
            
        } else {
            XCTFail()
        }
        
        sut.fetchPlayers()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    XCTFail()
                }
            } receiveValue: { playersData in
                XCTAssertEqual(playersData.count, 0)
            }
            .store(in: &cancelBag)
    }
}
