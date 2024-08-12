//
//  PlayerView.swift
//  Squad
//
//  Created by kyuminlee on 8/8/24.
//

import SwiftUI

struct PlayerView: View {
    @Environment(\.injected) private var injected: DIContainer
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var player: Player
    private let viewType: ViewType
    
    init(player: Player?) {
        if let player = player {
            self.player = player
            viewType = .update
        } else {
            self.player = Player(id: UUID(), name: "", position: .striker)
            viewType = .add
        }
    }
    
    enum ViewType {
        case add
        case update
        
        var navigationTitle: String {
            switch self {
            case .add: return "Add Player"
            case .update: return "Update Player"
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Name")
                    .frame(width: 100, alignment: .leading)
                switch viewType {
                case .add:
                    TextField("Name", text: $player.name)
                        .frame(minWidth: 100)
                case .update:
                    Text(player.name)
                        .frame(minWidth: 100, alignment: .leading)
                }
            }
            
            HStack {
                Text("Position")
                    .frame(width: 100, alignment: .leading)
                Picker("Choose a position", selection: $player.position) {
                    ForEach(Player.Position.allCases, id: \.self) { position in
                        Text(position.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .frame(minWidth: 100, alignment: .leading)
            }
            Spacer()
        }
        .padding(.horizontal, 20)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing, content: {
                Button(action: {
                    switch viewType {
                    case .add:
                        add(name: player.name, position: player.position)
                    case .update:
                        update(id: player.id, position: player.position)
                    }
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Confirm")
                })
            })
        }
        .navigationTitle(viewType.navigationTitle)
    }
}

private extension PlayerView {
    func add(name: String, position: Player.Position) {
        injected.interactors.playersInteractor.add(name: name, position: position)
    }
    
    func update(id: UUID?, position: Player.Position) {
        injected.interactors.playersInteractor.update(id: id, position: position)
    }
}

#Preview {
    PlayerView(player: nil)
}
