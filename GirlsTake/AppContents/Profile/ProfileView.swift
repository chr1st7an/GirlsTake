//
//  ProfileView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/1/23.
//

import SwiftUI
import FirebaseStorage
import PhotosUI

struct ProfileView: View {
    @EnvironmentObject var userState: UserStateViewModel
    @State private var presentAlert = false
    @State private var link = ""
    @State private var edit = false
    @State private var name = ""
    @State private var location = ""
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var profilePhoto: UIImage?
    @State private var isDragging = false
    @State private var position = CGSize.zero
    @State private var nameChange = false
    @State private var locationChange = false
    @State private var imageChange = false
     
    var body: some View {
        NavigationStack {
            VStack{
                ProfileHeader(edit: $edit)
                if edit {
                    editView()
                }else{
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
                            ForEach(userState.userProfile.links, id: \.self){ link in
                                Socials(url: link)
                            }
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
                    ForEach(userState.userProfile.traitBadges.chunked(into: 3), id: \.self) { sub in
                        HStack (spacing: 10){
                            ForEach(sub, id: \.self){ trait in
                                ProfileBadge(trait: trait, interactive: false, registering: false)
                            }
                        }
                    }
                }
                Spacer()
            }
        }.ignoresSafeArea()
        }
    @ViewBuilder
    func editView()->some View{
            HStack{
                VStack (spacing: 10){
                    TextField(userState.userProfile.id, text: $name).textFieldStyle(.roundedBorder).fontDesign(.serif).font(.system(size: 30)).onChange(of: name) { newValue in
                        nameChange = true
                    }
                    Text("\(userState.userProfile.age)").fontDesign(.serif)
                    TextField(userState.userProfile.location, text: $location).textFieldStyle(.roundedBorder).fontDesign(.serif).foregroundColor(gtGreen).font(.system(size: 25)).onChange(of: location) { newValue in
                        locationChange = true
                    }
                }.padding(.leading, 28)
                ZStack{
                    if selectedImageData != nil{
                        Image(uiImage: profilePhoto!)
                            .resizable()
                            .frame(width: 175, height: 175)
                            .clipShape(Circle()).padding(.leading, 30).padding(.trailing)
                    } else{
                        Image(uiImage: userState.userProfile.profilePhoto)
                            .resizable()
                            .frame(width: 175, height: 175)
                            .clipShape(Circle()).padding(.leading, 30).padding(.trailing)
                    }
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()) {
                            Image(systemName: "pencil.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .padding([.top, .leading], 124.0)
                                .font(.system(size: 40))
                                .foregroundColor(gtGreen)
                        }
                        .onChange(of: selectedItem) { newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    selectedImageData = data
                                    profilePhoto = UIImage(data: selectedImageData!)
                                    imageChange = true
                                }
                            }
                        }
                }.padding(.bottom, 25)

                
            }.padding(.top, -40)
            ZStack{
                Rectangle().frame(maxWidth: .infinity, maxHeight: 50).foregroundColor(gtPink)
                HStack (spacing: 35){
                    ForEach(userState.userProfile.links, id: \.self){ link in
                        Socials(url: link)
                    }
                    Menu {
                        Button() {
                            userState.removeLink(social: "instagram")
                        } label: {
                            Image("Instagram")
                        }
                        Button {
                            userState.removeLink(social: "Twitter")
                        } label: {
                            Image("Twitter")
                        }
                        Button {
                            userState.removeLink(social: "Pinterest")
                        } label: {
                            Image("Pinterest")
                        }
                        Button {
                            userState.removeLink(social: "TikTok")
                        } label: {
                            Image("TikTok")
                        }
                        Button("Cancel", role: .cancel, action: {})
                    } label: {
                        Label("", systemImage: "minus").foregroundColor(.gray)
                    }
                }
            }
            if imageChange || nameChange || locationChange {
                Button {
                    withAnimation(.spring()){
                        if nameChange{
                            userState.updateName(name: name)
                        }
                        if locationChange{
                            userState.updateLocation(location: location)
                        }
                        if imageChange{
                            userState.updateProfilePhoto(photo: UIImage(data: selectedImageData!)!)
                        }
                        edit.toggle()
                    }
                } label: {
                    HStack{
                        Text("Save")
                            .font(.callout)
                            .fontWeight(.bold)
                            .fontDesign(.serif)
                            .foregroundColor(.white)
                        Image(systemName: "checkmark.circle").foregroundColor(.white)
                    }
                    .padding(.horizontal,25)
                    .padding(.vertical,12)
                    .background {
                        Capsule()
                            .fill(gtGreen.gradient)
                    }
                }
                .frame(maxWidth: .infinity,maxHeight: .infinity)
            }
        }
    }

