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
    
    @StateObject var userStateViewModel = UserStateViewModel()
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if isActive{
                NavigationView{
                    ContentDelegator().environmentObject(userStateViewModel)
                }
                .navigationViewStyle(.stack)
                
            }else {
                SplashView(size: $size, opacity: $opacity, isActive: $isActive)
            }
                }
    }
}

