//
//  ContentView.swift
//  Squad
//
//  Created by kyuminlee on 6/25/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    private let container: DIContainer
    private let isRunningTests: Bool
    
    init(container: DIContainer, isRunningTests: Bool = ProcessInfo.processInfo.isRunningTests) {
        self.container = container
        self.isRunningTests = isRunningTests
    }
    
    var body: some View {
        NavigationView {
            VStack {
                PlayerList()
            }
            .toolbar(content: {
                ToolbarItemGroup(placement: .topBarTrailing, content: {
                    EditButton()
                    NavigationLink(destination: {
                        PlayerView(player: nil)
                    }, label: {
                        Image(systemName: "plus")
                    })
                })
            })
            .navigationTitle("Player List")
        }
        .inject(container)
    }
}

#Preview {
    ContentView(container: .preview)
}
