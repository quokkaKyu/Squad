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
        let diContainer = DIContainer(appState: appState, interactors: DIContainer.Interactors.init())
        return AppEnvironment(container: diContainer)
    }
}
