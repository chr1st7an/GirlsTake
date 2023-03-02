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
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
                    NavigationView{
                        ApplicationSwitcher()
                    }
                    .navigationViewStyle(.stack)
                    .environmentObject(userStateViewModel)
                }
    }
}

struct ApplicationSwitcher: View {
    
    @EnvironmentObject var vm: UserStateViewModel
    
    var body: some View {
        if (vm.isLoggedIn) {
            HomeView().environmentObject(vm)
        } else {
            LoginView()
        }
        
    }
}
