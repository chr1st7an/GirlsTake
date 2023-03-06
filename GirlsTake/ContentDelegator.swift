//
//  ContentDelegator.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/1/23.
//

import SwiftUI

struct ContentDelegator: View {
    @EnvironmentObject var vm: UserStateViewModel
    @EnvironmentObject var eventManager : EventManager
    
    var body: some View {
        Group {
        if vm.user != nil {
            ContentView().environmentObject(vm)
        } else {
        LoginView().environmentObject(vm)
        }
        }.onAppear {
        vm.listenToAuthState()
        }
    }
    
}

struct ContentDelegator_Previews: PreviewProvider {
    static var previews: some View {
        ContentDelegator().environmentObject(UserStateViewModel())
    }
}
