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
    @StateObject var eventManager = EventManager()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
                    NavigationView{
                        ContentDelegator().environmentObject(userStateViewModel).environmentObject(eventManager)
                    }
                    .navigationViewStyle(.stack)
                    .environmentObject(userStateViewModel)
                    .environmentObject(eventManager)
                }
    }
}

//struct ApplicationSwitcher: View {
//
//    @EnvironmentObject var vm: UserStateViewModel
//
//    var body: some View {
//        if vm.isLoggedIn {
//            HomeView().environmentObject(vm)
//        } else {
//            LoginView()
//        }
//    }
//}
