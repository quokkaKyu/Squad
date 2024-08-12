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
            List {
                ForEach(players) { player in
                    NavigationLink(destination: {
                        PlayerView(player: player)
                            .inject(injected)
                    }, label: {
                        PlayerCell(player: player)
                    })
                }
                .onDelete(perform: { indexSet in
                    delete(players: $players, atOffsets: indexSet)
                })
            }
            .onAppear(perform: {
                load()
            })
        }
    }
}

private extension PlayerList {
    func load() {
        injected.interactors.playersInteractor.load(players: $players)
    }
    
    func delete(players: Binding<[Player]>, atOffsets: IndexSet) {
        injected.interactors.playersInteractor.delete(players: players.wrappedValue, atOffsets: atOffsets)
        players.wrappedValue.remove(atOffsets: atOffsets)
    }
}

#Preview {
    PlayerList(players: Player.mockedData)
}
