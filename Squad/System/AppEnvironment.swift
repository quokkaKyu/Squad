//
//  AppEnvironment.swift
//  Squad
//
//  Created by kyuminlee on 6/25/24.
//

import Foundation
import Combine

struct AppEnvironment {
    let container: DIContainer
}

extension AppEnvironment {
    static func bootstrap() -> AppEnvironment {
        let appState = Store<AppState>(AppState())
        let dbRepositories = configuredDBRepositories()
        let interactors = configuredInteractors(appState: appState, dbRepositories: dbRepositories)
        let diContainer = DIContainer(appState: appState,
                                      interactors: interactors)
        return AppEnvironment(container: diContainer)
    }
    
    private static func configuredDBRepositories() -> DIContainer.DBRepositories {
        let persistentStore = SQLiteStack()
        let playersDBRepository = RealPlayersDBRepository(persistentStore: persistentStore)
        return .init(playersRepository: playersDBRepository)
    }
    
    private static func configuredInteractors(appState: Store<AppState>,
                                              dbRepositories: DIContainer.DBRepositories) -> DIContainer.Interactors {
        let playersInteractor = RealPlayersInteractor(dbRepository: dbRepositories.playersRepository)
        return .init(playersInteractor: playersInteractor)
    }
}

extension DIContainer {
    struct DBRepositories {
        let playersRepository: PlayersDBRepository
    }
}
