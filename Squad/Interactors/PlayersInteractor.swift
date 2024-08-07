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
}

struct RealPlayersInteractor: PlayersInteractor {
    let dbRepository: PlayersDBRepository
    
    init(dbRepository: PlayersDBRepository) {
        self.dbRepository = dbRepository
    }
    
    func load(players: Binding<[Player]>) {
        var cancelBag = Set<AnyCancellable>()
        
        dbRepository.getPlayers()
            .sink(receiveCompletion: { subscriptionCompletion in
                print(subscriptionCompletion)
            }, receiveValue: { playerList in
                players.wrappedValue = playerList
            })
        .store(in: &cancelBag)
    }
}

struct StubPlayersInteractor: PlayersInteractor {
    func load(players: Binding<[Player]>) {
        players.wrappedValue = Player.mockedData
    }
}
