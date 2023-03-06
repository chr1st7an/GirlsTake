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
    @EnvironmentObject var eventManager : EventManager

    
    var body: some View {
                ZStack{
                    //Background
                    VStack{
                        Header()
                        Spacer()
                        HStack{
                            Spacer()
                            Spacer()
                            VStack{
                                Text(vm.userProfile.id!)
                                Text(vm.userProfile.location)
                                Text(vm.userProfile.dob)
                                
                            }

                            Spacer(minLength: 100)
                            Image(uiImage: vm.userProfile.profilePhoto)
                                .resizable()
                                .frame(width: 175, height: 175)
                                .clipShape(Circle())
                            Spacer()
                        }
//                        Spacer(minLength: 510)
                    }
                    
                }.onAppear{
                    vm.listenToAuthState()
                }
                
        }
    }
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(UserStateViewModel())
    }
}
