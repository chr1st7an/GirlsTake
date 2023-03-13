//
//  ProfileView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/1/23.
//

import SwiftUI
import FirebaseStorage

struct ProfileView: View {
    @EnvironmentObject var userState: UserStateViewModel
    @State private var presentAlert = false
    @State private var link = ""
     
    var body: some View {
        NavigationStack {
            VStack{
                Header()
                HStack{
                    VStack (spacing: 10){
                        Text(userState.userProfile.id).fontDesign(.serif).font(.system(size: 30))
                        Text("\(userState.userProfile.age)").fontDesign(.serif)
                        Text(userState.userProfile.location).fontDesign(.serif).foregroundColor(gtGreen).font(.system(size: 25))
                    }.padding(.leading, 28)
                    Image(uiImage: userState.userProfile.profilePhoto)
                        .resizable()
                        .frame(width: 175, height: 175)
                        .clipShape(Circle()).padding(.leading, 30).padding(.trailing)
                    
                }.padding(.top, -40)
                ZStack{
                    Rectangle().frame(maxWidth: .infinity, maxHeight: 50).foregroundColor(gtPink)
                    HStack (spacing: 35){
                        ForEach(self.userState.userProfile.links, id: \.self){link in
                            Socials(url: link)
                        }
                        //            Button("Create event"){
                        //                presentAlert.toggle()
                        //            }.alert("Enter Name", isPresented: $presentAlert, actions: {
                        //                TextField("", text: $name)
                        //                Button("Create", action: {eventManager.addEvent(name: name)})
                        //                Button("Cancel", role: .cancel, action: {})
                        //            }) {
                        //                Text("CREATE EVENT")
                        //            }
                            Button {
                                presentAlert.toggle()
                            } label: {
                                VStack{
                                    Image(systemName: "plus").foregroundColor(.gray)
                                    Text("socials").font(.system(size: 8)).fontDesign(.serif).foregroundColor(.gray).padding(.top, 1)
                                }
                            }.alert("Profile Link", isPresented: $presentAlert) {
                                TextField("", text: $link)
                                Button("Create", action: {userState.addLink(url: link)})
                                Button("Cancel", role: .cancel, action: {})
                            }
                    }
                }
//                Socials()
                Spacer()
            }
        }.ignoresSafeArea()
//                ZStack{
//                    //Background
//                    VStack{
//                        Header()
//                        Spacer()
//                        HStack{
//                            Spacer()
//                            Spacer()
//                            VStack{
//                                Text(vm.userProfile.id)
//                                Text(vm.userProfile.location)
//                                Text(vm.userProfile.dob)
//
//                            }
//
//                            Spacer(minLength: 100)
//                            Image(uiImage: vm.userProfile.profilePhoto)
//                                .resizable()
//                                .frame(width: 175, height: 175)
//                                .clipShape(Circle())
//                            Spacer()
//                        }
////                        Spacer(minLength: 510)
//                    }
//
//                }
                
        }
    }
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(UserStateViewModel())
    }
}
