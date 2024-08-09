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
    
    let viewType: ViewType
    let id: UUID?
    @State var name: String = ""
    @State private var position: Player.Position = .striker
    
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
                TextField("Name", text: $name)
                    .frame(minWidth: 100)
            }
            
            HStack {
                Text("Position")
                    .frame(width: 100, alignment: .leading)
                Picker("Choose a position", selection: $position) {
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
                        add(name: name, position: position)
                    case .update:
                        update(id: id, position: position)
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
        if let id = id {
            injected.interactors.playersInteractor.update(id: id, position: position)
        } else {
            print("fail")
        }
    }
}

#Preview {
    PlayerView(viewType: .add, id: nil)
}
