//
//  Helpers.swift
//  Squad
//
//  Created by kyuminlee on 6/25/24.
//

import SwiftUI
import Combine

// MARK: - General

extension ProcessInfo {
    var isRunningTests: Bool {
        environment["XCTestConfigurationFilePath"] != nil
    }
}
