//
//  PlayerAddView.swift
//  Squad
//
//  Created by kyuminlee on 8/8/24.
//

import SwiftUI

struct PlayerAddView: View {
    @Environment(\.injected) private var injected: DIContainer
    
    @State private var name: String = ""
    @State private var position: Player.Position = .striker
    
    @Binding var isNavigate: Bool
    
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
            ToolbarItem(placement: .topBarLeading, content: {
                Button(action: {
                    back()
                }, label: {
                    Text("Back")
                })
            })
            ToolbarItem(placement: .topBarTrailing, content: {
                Button(action: {
                    add(name: name, position: position)
                }, label: {
                    Text("Confirm")
                })
            })
        }
        .navigationTitle("Add Player")
        .navigationBarBackButtonHidden()
    }
}

private extension PlayerAddView {
    func add(name: String, position: Player.Position) {
        injected.interactors.playersInteractor.add(name: name, position: position)
        isNavigate = false
    }
    
    func back() {
        isNavigate = false
    }
}

#Preview {
    PlayerAddView(isNavigate: .constant(true))
}
