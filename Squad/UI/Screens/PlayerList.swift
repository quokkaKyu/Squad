//
//  PlayerList.swift
//  Squad
//
//  Created by kyuminlee on 8/6/24.
//

import SwiftUI

@MainActor
struct PlayerList: View {
    @Environment(\.injected) private var injected: DIContainer
    @State private(set) var players: [Player] = []
    var body: some View {
        VStack {
            List(players) { player in
                NavigationLink(destination: {
                    PlayerView(viewType: .update, id: player.id, name: player.name)
                        .inject(injected)
                }, label: {
                    PlayerCell(player: player)
                })
            }
            .onAppear(perform: {
                load()
            })
        }
    }
}

extension PlayerList {
    private func load() {
        injected.interactors.playersInteractor.load(players: $players)
    }
}

#Preview {
    PlayerList(players: Player.mockedData)
}
