//
//  ContentDelegator.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/1/23.
//

import SwiftUI

struct ContentDelegator: View {
    @EnvironmentObject var userState: UserStateViewModel
//    @EnvironmentObject var eventManager : EventManager
    
    var body: some View {
        Group {
        if userState.user != nil {
            ContentView()
        } else {
        LoginView()
        }
        }.onAppear {
            userState.listenToAuthState()
        }
    }
    
}

struct ContentDelegator_Previews: PreviewProvider {
    static var previews: some View {
        ContentDelegator().environmentObject(UserStateViewModel())
    }
}
