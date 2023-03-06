//
//  SettingsView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/3/23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var vm: UserStateViewModel
    var body: some View {
        NavigationView{
            Button{
                vm.signOut()
            }label: {
                Text("Sign Out").frame(width: 200, height: 40).foregroundColor(.black).fontDesign(.serif).background( RoundedRectangle(cornerRadius: 10 ,style: .continuous).fill(.linearGradient(colors: [gtPink, .white], startPoint: .bottom, endPoint: .top))
                )
            }
            
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
