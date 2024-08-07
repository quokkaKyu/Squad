//
//  PlayerCell.swift
//  Squad
//
//  Created by kyuminlee on 8/6/24.
//

import SwiftUI

struct PlayerCell: View {
    let player: Player
    var body: some View {
        HStack {
            Text(player.name)
                .bold()
                .padding()
            Spacer()
            Text(player.position.rawValue)
                .frame(width: 100)
                .padding()
        }
    }
}

#Preview {
    PlayerCell(player: Player.mockedData[0])
}
