//
//  NavigationStackModel.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/29/23.
//

import SwiftUI

enum navStack{
    enum Destination: Hashable {
        case home
        case event(destination: EventView)
        case profile
    }
    enum EventView: Hashable {
        case info //extra info
        case attendees
    }
    class Model: ObservableObject {
        @Published var path :  [Destination]
        init(path: [Destination] = []) {
            self.path = path
        }
    }
}
