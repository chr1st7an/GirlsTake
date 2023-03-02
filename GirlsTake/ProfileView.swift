//
//  ProfileView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/1/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var vm: UserStateViewModel
    var body: some View {
        
        let user = vm.getUser()
        Text(user.displayName!)
//        Text("Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
