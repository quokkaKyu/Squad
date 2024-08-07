//
//  InteractorsContainer.swift
//  Squad
//
//  Created by kyuminlee on 6/25/24.
//

extension DIContainer {
    struct Interactors {
        let playersInteractor: PlayersInteractor
        
        init(playersInteractor: PlayersInteractor) {
            self.playersInteractor = playersInteractor
        }
        
        static var stub: Self {
            .init(playersInteractor: StubPlayersInteractor())
        }
    }
}

