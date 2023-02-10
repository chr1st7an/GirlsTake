//
//  GirlsTakeApp.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 2/10/23.
//

import SwiftUI
import Firebase

@main
struct GirlsTakeApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
