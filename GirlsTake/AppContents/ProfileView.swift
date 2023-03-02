//
//  ProfileView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/1/23.
//

import SwiftUI
import FirebaseStorage

struct ProfileView: View {
    @EnvironmentObject var vm: UserStateViewModel
    
    var body: some View {
        let user = vm.user!
        VStack{
            Text(user.displayName!)
            Text(user.email!)
                    Button{
                        vm.signOut()
                    }label: {
                        Text("Sign Out").frame(width: 200, height: 40).foregroundColor(.black).fontDesign(.serif).background( RoundedRectangle(cornerRadius: 10 ,style: .continuous).fill(.linearGradient(colors: [gtPink, .white], startPoint: .bottom, endPoint: .top)).shadow(radius: 1)
                        )
                    }
        }
        
//        Text("Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
