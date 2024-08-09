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
                    .inject(container)
            }
            .toolbar(content: {
                NavigationLink(destination: {
                    PlayerView(viewType: .add, id: nil)
                        .inject(container)
                }, label: {
                    Image(systemName: "plus")
                })
            })
            .navigationTitle("Player List")
        }
    }
}

#Preview {
    ContentView(container: .preview)
}
