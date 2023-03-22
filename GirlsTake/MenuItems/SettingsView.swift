//
//  SettingsView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/3/23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userState: UserStateViewModel
    var body: some View {
        NavigationView{
            VStack{
                Button{
                    withAnimation(.easeInOut(duration: 2)) {
                        userState.isOnboarding.toggle()
                    }
                }label: {
                    Text("Onboard").frame(width: 200, height: 40).foregroundColor(.black).fontDesign(.serif).background( RoundedRectangle(cornerRadius: 10 ,style: .continuous).fill(.linearGradient(colors: [gtPink, .white], startPoint: .bottom, endPoint: .top))
                    )
                }
                Button{
                    userState.signOut()
                }label: {
                    Text("Sign Out").frame(width: 200, height: 40).foregroundColor(.black).fontDesign(.serif).background( RoundedRectangle(cornerRadius: 10 ,style: .continuous).fill(.linearGradient(colors: [gtPink, .white], startPoint: .bottom, endPoint: .top))
                    )
                }
                Button{
                    userState.deleteAccount()
                }label: {
                    Text("Delete account").frame(width: 200, height: 40).foregroundColor(.black).fontDesign(.serif).background( RoundedRectangle(cornerRadius: 10 ,style: .continuous).fill(.linearGradient(colors: [gtPink, .white], startPoint: .bottom, endPoint: .top))
                    )
                }
                
                
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
