//
//  PlayersInteractor.swift
//  Squad
//
//  Created by kyuminlee on 7/4/24.
//

import Foundation
import SwiftUI
import Combine

protocol PlayersInteractor {
    func load(players: Binding<[Player]>)
    func add(name: String, position: Player.Position)
    func update(id: UUID?, position: Player.Position)
    func delete(players: [Player], atOffsets: IndexSet)
}

struct RealPlayersInteractor: PlayersInteractor {
    let dbRepository: PlayersDBRepository
    
    init(dbRepository: PlayersDBRepository) {
        self.dbRepository = dbRepository
    }
    
    func load(players: Binding<[Player]>) {
        var cancelBag = Set<AnyCancellable>()
        
        dbRepository.fetchPlayers()
            .sink(receiveCompletion: { subscriptionCompletion in
                print(subscriptionCompletion)
            }, receiveValue: { playerList in
                players.wrappedValue = playerList
            })
        .store(in: &cancelBag)
    }
    
    func add(name: String, position: Player.Position) {
        var cancelBag = Set<AnyCancellable>()
        
        dbRepository.addPlayer(name: name, position: position)
            .sink(receiveCompletion: { subscriptionCompletion in
                print(subscriptionCompletion)
            }, receiveValue: { _ in
                
            })
        .store(in: &cancelBag)
    }
    
    func update(id: UUID?, position: Player.Position) {
        if let id = id {
            update(id: id, position: position)
        } else {
            print("update fail")
        }
    }
    
    private func update(id: UUID, position: Player.Position) {
        var cancelBag = Set<AnyCancellable>()
        
        dbRepository.updatePlayer(id: id, newPosition: position)
            .sink(receiveCompletion: { subscriptionCompletion in
                print(subscriptionCompletion)
            }, receiveValue: { _ in
                
            })
        .store(in: &cancelBag)
    }
    
    func delete(players: [Player], atOffsets: IndexSet) {
        if let index = atOffsets.first {
            delete(id: players[index].id)
        } else {
            print("delete fail")
        }
    }
    
    private func delete(id: UUID) {
        var cancelBag = Set<AnyCancellable>()
        
        dbRepository.deletePlayer(id: id)
            .sink(receiveCompletion: { subscriptionCompletion in
                print(subscriptionCompletion)
            }, receiveValue: { _ in
                
            })
        .store(in: &cancelBag)
    }
}

struct StubPlayersInteractor: PlayersInteractor {
    func load(players: Binding<[Player]>) {
        players.wrappedValue = Player.mockedData
    }
    
    func add(name: String, position: Player.Position) {
        
    }
    
    func update(id: UUID?, position: Player.Position) {
        
    }
    
    func delete(players: [Player], atOffsets: IndexSet) {
        
    }
}
