//
//  PlayerList.swift
//  Squad
//
//  Created by kyuminlee on 8/6/24.
//

import SwiftUI

@MainActor
struct PlayerList: View {
    @State private(set) var players: [Player] = []
    var body: some View {
        VStack {
            List(players) { player in
                PlayerCell(player: player)
            }
        }
    }
}

#Preview {
    PlayerList(players: Player.mockedData)
}
