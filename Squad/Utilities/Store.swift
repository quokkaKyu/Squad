//
//  Store.swift
//  Squad
//
//  Created by kyuminlee on 6/25/24.
//

import SwiftUI
import Combine

typealias Store<State> = CurrentValueSubject<State, Never>
