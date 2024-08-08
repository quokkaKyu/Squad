//
//  PlayersDBRepository.swift
//  Squad
//
//  Created by kyuminlee on 7/4/24.
//

import Foundation
import Combine
import SQLite

protocol PlayersDBRepository {
    func addPlayer(name: String, position: Player.Position) -> AnyPublisher<Void, Error>
    func fetchPlayers() -> AnyPublisher<[Player], Error>
    func updatePlayer(id: UUID, newPosition: Player.Position) -> AnyPublisher<Void, Error>
    func deletePlayer(id: UUID) -> AnyPublisher<Void, Error>
}

class RealPlayersDBRepository: PlayersDBRepository {
    private let persistentStore: PersistentStore

    init(persistentStore: PersistentStore) {
        self.persistentStore = persistentStore
    }

    func addPlayer(name: String, position: Player.Position) -> AnyPublisher<Void, Error> {
        Future { promise in
            do {
                try self.persistentStore.addPlayer(name: name, position: position)
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }

    func fetchPlayers() -> AnyPublisher<[Player], Error> {
        Future { promise in
            do {
                let players = try self.persistentStore.fetchPlayers()
                promise(.success(players))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }

    func updatePlayer(id: UUID, newPosition: Player.Position) -> AnyPublisher<Void, Error> {
        Future { promise in
            do {
                try self.persistentStore.updatePlayer(id: id, newPosition: newPosition)
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }

    func deletePlayer(id: UUID) -> AnyPublisher<Void, Error> {
        Future { promise in
            do {
                try self.persistentStore.deletePlayer(id: id)
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
