//
//  SQLiteStack.swift
//  Squad
//
//  Created by kyuminlee on 7/8/24.
//

import Foundation
import SQLite

protocol PersistentStore {
    func createPlayer(name: String, position: Player.Position) throws
    func getPlayers() throws -> [Player]
    func updatePlayer(id: UUID, newPosition: Player.Position) throws
    func deletePlayer(id: UUID) throws
}

final class SQLiteStack: PersistentStore {
    private var db: Connection?

    private let players = Table("players")
    private let id = Expression<String>("id")
    private let name = Expression<String>("name")
    private let position = Expression<String>("position")

    init() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            db = try Connection("\(path)/db.sqlite3")
            try createTable()
        } catch {
            db = nil
            print("Unable to open database. Error: \(error)")
        }
    }

    private func createTable() throws {
        guard let db = db else { return }
        try db.run(players.create(ifNotExists: true) { t in
            t.column(id, primaryKey: true)
            t.column(name)
            t.column(position)
        })
    }

    func createPlayer(name: String, position: Player.Position) throws {
        guard let db = db else { throw NSError(domain: "DatabaseError", code: 1, userInfo: nil) }

        let insert = players.insert(self.id <- UUID().uuidString, self.name <- name, self.position <- position.rawValue)
        try db.run(insert)
    }

    func getPlayers() throws -> [Player] {
        guard let db = db else { throw NSError(domain: "DatabaseError", code: 1, userInfo: nil) }

        var playersList = [Player]()

        for player in try db.prepare(players) {
            if let playerPosition = Player.Position(rawValue: player[position]) {
                let player = Player(id: UUID(uuidString: player[id])!, name: player[name], position: playerPosition)
                playersList.append(player)
            }
        }
        return playersList
    }

    func updatePlayer(id: UUID, newPosition: Player.Position) throws {
        guard let db = db else { throw NSError(domain: "DatabaseError", code: 1, userInfo: nil) }

        let player = players.filter(self.id == id.uuidString)
        if try db.run(player.update(self.position <- newPosition.rawValue)) == 0 {
            throw NSError(domain: "DatabaseError", code: 2, userInfo: nil)
        }
    }

    func deletePlayer(id: UUID) throws {
        guard let db = db else { throw NSError(domain: "DatabaseError", code: 1, userInfo: nil) }

        let player = players.filter(self.id == id.uuidString)
        if try db.run(player.delete()) == 0 {
            throw NSError(domain: "DatabaseError", code: 2, userInfo: nil)
        }
    }
}
