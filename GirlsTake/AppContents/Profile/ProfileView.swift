////
////  ProfileView.swift
////  GirlsTake
////
////  Created by Christian Rodriguez on 3/1/23.
////
//
//import SwiftUI
//import FirebaseStorage
//import PhotosUI
//
//struct ProfileView: View {
//    @EnvironmentObject var userState: UserStateViewModel
//    @State private var presentAlert = false
//    @State private var newlink = ""
//    @State private var edit = false
//    @State private var name = ""
//    @State private var location = ""
//    @State var offsetY: CGFloat = 0
//    @State var showMenu: Bool = false
//    // MARK: Universal Gesture State
//    @State var reset: Bool = false
//    @Environment(\.isDragging) var isDragging
//    @State private var position = CGSize.zero
//    @State private var nameChange = false
//    @State private var locationChange = false
//    @State private var imageChange = false
//    @State private var showPicker: Bool = false
//    @State private var croppedImage1: UIImage?
//    @State private var croppedImage2: UIImage?
//    @State private var croppedImage3: UIImage?
//    @State private var croppedImage4: UIImage?
//    @State private var selection: DropDownSelection = .init(value: "NYC")
//    @State var picker : Bool = true
//    
//    init(){
////        selection = .init(value: self.userState.userProfile.location)/
//        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(gtPink)
//        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.black], for: .selected)
//        UISegmentedControl.appearance().backgroundColor = UIColor.white
//        UISegmentedControl.appearance().isOpaque = true
//    }
//    var body: some View {
//        NavigationStack{
//            GeometryReader{proxy in
//                let safeAreaTop = proxy.safeAreaInsets.top
//                ZStack{
//                    VStack{
//                        HeaderView(safeAreaTop)
//                            .padding(.bottom, -55)
//                        VStack{
//                                HStack{
//                                    VStack (spacing: 10){
//                                        Text(userState.userProfile.id).fontDesign(.serif).font(.system(size: 30))
//                                        Text("\(userState.userProfile.age)").fontDesign(.serif)
//                                        Text(userState.userProfile.location).fontDesign(.serif).foregroundColor(gtGreen).font(.system(size: 25))
//                                    }.offset(x: -22)
//                                    Image(uiImage: userState.userProfile.profilePhoto)
//                                        .resizable()
//                                        .frame(width: 120, height: 120)
//                                        .clipShape(Circle())
//                                        .offset(x: 30)
//                                }.frame(maxWidth: .infinity).padding(.top, 25)
//                            
//                            ZStack{
//                                Rectangle().frame(maxWidth: .infinity, maxHeight: 50).foregroundColor(gtPink)
//                                SocialBarView()
//                            }
////                            Spacer()
//                            CustomPicker().padding(.top, 15)
//                        }
//                        .zIndex(0)
//                        ScrollViewReader(content: { proxy in
//                            ScrollView(.vertical, showsIndicators: false) {
//                                    if picker {
//                                        InfoView()
//
//                                    }else{
//                                        Text("Status/rewards/tier section")
//                                    }
//                                        }
//                                    })
//                                     .coordinateSpace(name: "SCROLL")
//                                     .edgesIgnoringSafeArea(.top)
//                        
//                    }
//                    
//                    GeometryReader { _ in
//        
//                              HStack {
//                                Spacer()
//                                
//                                SideMenu()
//                                  .offset(x: showMenu ? 0 : UIScreen.main.bounds.width)
//                                  .animation(.easeInOut(duration: 0.3), value: showMenu)
//                                  .gesture(DragGesture(minimumDistance: 2.0, coordinateSpace: .local)
//                                      .onEnded { value in
//                                          print(value.translation)
//                                          switch(value.translation.width, value.translation.height) {
//                                          case (...0, -30...30):  showMenu.toggle()
//                                              case (0..., -30...30):  showMenu.toggle()
//                                              case (-100...100, ...0):  print("up swipe")
//                                              case (-100...100, 0...):  print("down swipe")
//                                              default:  showMenu.toggle()
//                                          }
//                                      }
//                                  )
//                              }
//                        
//                              
//                            }
//                    .background(Color.gray.opacity(showMenu ? 0.5 : 0))
//                }
//            }
//        }
//        }
//    @ViewBuilder
//    func CustomPicker()-> some View{
//        HStack(spacing: 20){
//            VStack{
//                Image(systemName: "info.circle").foregroundColor(.gray)
//                Rectangle().frame(width: 150, height: 1.5).foregroundColor(picker ? gtPink : .gray.opacity(0.2))
//            }.onTapGesture {
//                picker = true
//            }
//            VStack{
//                Image(systemName: "star.circle").foregroundColor(.gray)
//                Rectangle().frame(width: 150, height: 1.5).foregroundColor(picker ? .gray.opacity(0.2) : gtPink)
//            }.onTapGesture {
//                picker = false
//            }
//        }
//    }
//    @ViewBuilder
//    func SocialBarView()-> some View{
//        HStack (spacing: 35){
//            ForEach(userState.userProfile.links, id: \.self){ link in
//                Socials(url: link, active: true)
//            }
//        }
//    }
//    @ViewBuilder
//    func InfoView()-> some View{
//        VStack(spacing: 15){
//            PhotoGrid()
//            ProfileBadgeView(title: "", traitArray: userState.userProfile.traitBadges.chunked(into: 3), registering: false)
//        }
//    }
//    @ViewBuilder
//    func SideMenu() -> some View{
//        VStack {
//            HStack{
//                Text("Account Center").foregroundColor(.black).fontDesign(.serif).font(.system(size: 25))
//                Image(systemName: "xmark").offset(x: 55).onTapGesture {
//                    showMenu.toggle()
//                }
//            }.padding(.vertical, 25)
//            Rectangle().frame(width: 250, height: 1).foregroundColor(.gray).padding(.leading, 25).padding(.top, -15)
//            ScrollView(.vertical){
//                VStack(alignment: .leading,spacing: 35) {
//                    NavigationLink {
//                        SettingsView()
//                    } label: {
//                        HStack{
//                            Image(systemName: "gear").resizable().frame(width: 25, height: 25)
//                            Text("App Settings").foregroundColor(.gray).fontDesign(.serif).font(.system(size: 20))
//                        }
//                    }
//                    NavigationLink {
//                        editView()
//                    } label: {
//                        HStack{
//                            Image(systemName: "slider.horizontal.3").resizable().frame(width: 25, height: 22)
//                            Text("Edit Profile").foregroundColor(.gray).fontDesign(.serif).font(.system(size: 20))
//                        }
//                    }
//                    NavigationLink {
//                        SettingsView()
//                    } label: {
//                        HStack{
//                            Image(systemName: "creditcard").resizable().frame(width: 25, height: 20)
//                            Text("Manage Subscription").foregroundColor(.gray).fontDesign(.serif).font(.system(size: 20))
//                        }
//                    }
//                    NavigationLink {
//                        SettingsView()
//                    } label: {
//                        HStack{
//                            Image(systemName: "message").resizable().frame(width: 25, height: 25)
//                            Text("Messages").foregroundColor(.gray).fontDesign(.serif).font(.system(size: 20))
//                        }
//                    }
//                    NavigationLink {
//                        SettingsView()
//                    } label: {
//                        HStack{
//                            Image(systemName: "gift").resizable().frame(width: 25, height: 25)
//                            Text("Rewards").foregroundColor(.gray).fontDesign(.serif).font(.system(size: 20))
//                        }
//                    }
//                    NavigationLink {
//                        SettingsView()
//                    } label: {
//                        HStack{
//                            Image(systemName: "person.3").resizable().frame(width: 28, height: 20)
//                            Text("Join the Team").foregroundColor(.gray).fontDesign(.serif).font(.system(size: 20))
//                        }
//                    }
//
//                }.padding(.leading, 15)
//                
//            }
//            VStack(spacing: 30){
//                Rectangle().frame(width: 250, height: 1).foregroundColor(.gray).padding(.leading, 25).padding(.bottom, -25)
//                VStack(alignment: .leading, spacing: 10) {
//                    Text("About").foregroundColor(.gray).fontDesign(.serif).font(.system(size: 10))
//                    Text("Contact").foregroundColor(.gray).fontDesign(.serif).font(.system(size: 10))
//                    Text("Terms and Conditions").foregroundColor(.gray).fontDesign(.serif).font(.system(size: 10))
//                    Text("Privacy Policy").foregroundColor(.gray).fontDesign(.serif).font(.system(size: 10))
//                }
//                .offset(x: -45)
//            }
//            VStack{
//                Text("Follow us").fontDesign(.serif)
//                HStack(spacing: 15){
//                    Image("Instagram").resizable().frame(width: 25, height: 25)
//                    Image("TikTok").resizable().frame(width: 25, height: 25)
//                    Image("Pinterest").resizable().frame(width: 25, height: 25)
//                }
//                Link("GirlsTake.com", destination: URL(string: "www.Girls-Take.com")!)
//                Text("version 1.0").foregroundColor(.gray).fontDesign(.serif).font(.system(size: 8)).padding(.top, 5)
//                
//            }.offset(x: 30).padding(.top, 20)
//            Spacer(minLength: 40)
//            }
//        .padding(.trailing, 55)
//        .background(.white.gradient)
//    }
//    @ViewBuilder
//    func PhotoGrid()->some View{
//        let threeColumnGrid = [
//            GridItem(.flexible(), spacing: 2),
//            GridItem(.flexible(), spacing: 2),
//            GridItem(.flexible(), spacing: 2),
//        ]
//            LazyVGrid(columns: threeColumnGrid, spacing: 20) {
//                if userState.photo1.size == .zero {
//                    ZStack{
//                        RoundedRectangle(cornerRadius: 5)
//                            .foregroundColor(.gray.opacity(0.2))
//                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 120)
//                        .onTapGesture {
//                            showPicker.toggle()
//                        }
//                        Image(systemName: "photo").foregroundColor(.white)
//                    }
//                    .cropImagePicker(
//                        options: [.square],
//                        show: $showPicker,
//                        croppedImage: $croppedImage1
//                    ).onChange(of: croppedImage1 ?? UIImage()) { newValue in
//                        userState.addPhotos(photo: newValue, number: "1")
////                        croppedImage = UIImage()
//                    }
//                }else{
//                    Image(uiImage:userState.photo1)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 120)
//                    .clipShape(RoundedRectangle(cornerRadius: 5))
//                }
//                if userState.photo2.size == .zero {
//                    ZStack{
//                        RoundedRectangle(cornerRadius: 5)
//                            .foregroundColor(.gray.opacity(0.2))
//                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 120)
//                        .onTapGesture {
//                            showPicker.toggle()
//                        }
//                        Image(systemName: "photo").foregroundColor(.white)
//                    }
//                    .cropImagePicker(
//                        options: [.square],
//                        show: $showPicker,
//                        croppedImage: $croppedImage2
//                    ).onChange(of: croppedImage2 ?? UIImage()) { newValue in
//                        userState.addPhotos(photo: newValue, number: "2")
////                        croppedImage = UIImage()
//                    }
//                }else{
//                    Image(uiImage:userState.photo2)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 120)
//                    .clipShape(RoundedRectangle(cornerRadius: 5))
//                }
//                if userState.photo3.size == .zero {
//                    ZStack{
//                        RoundedRectangle(cornerRadius: 5)
//                            .foregroundColor(.gray.opacity(0.2))
//                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 120)
//                        .onTapGesture {
//                            showPicker.toggle()
//                        }
//                        Image(systemName: "photo").foregroundColor(.white)
//                    }
//                    .cropImagePicker(
//                        options: [.square],
//                        show: $showPicker,
//                        croppedImage: $croppedImage3
//                    ).onChange(of: croppedImage3 ?? UIImage()) { newValue in
//                        userState.addPhotos(photo: newValue, number: "3")
////                        croppedImage = UIImage()
//                    }
//                }else{
//                    Image(uiImage:userState.photo3)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 120)
//                    .clipShape(RoundedRectangle(cornerRadius: 5))
//                }
//                
//            }.padding(.horizontal, 5)
//    }
//    @ViewBuilder
//    func editView()->some View{
//        GeometryReader{proxy in
//            let safeAreaTop = proxy.safeAreaInsets.top
//            VStack{
//                CustomHeaderView(safeAreaTop, title: "Edit Profile")
//                HStack{
//                    VStack (spacing: 20){
//                        TextField(userState.userProfile.id, text: $name).textFieldStyle(.roundedBorder).fontDesign(.serif).font(.system(size: 20)).onChange(of: name) { newValue in
//                            nameChange = true
//                        }
//                        DropDown(content: ["NYC", "Boston", "Philly"], selection: $selection, activeTint: .white, inActiveTint: .gray.opacity(0.4)).padding(.bottom, -8).onChange(of: selection) { newValue in
//                            userState.location = newValue.value
//                        }
//                    }.padding(.leading, 28)
//                    ZStack{
//                        if let croppedImage4{
//                            Image(uiImage: croppedImage4)
//                                .resizable()
//                                .frame(width: 120, height: 120)
//                                .clipShape(Circle()).padding(.leading, 30).padding(.trailing)
//                        } else{
//                            Image(uiImage: userState.userProfile.profilePhoto)
//                                .resizable()
//                                .frame(width: 120, height: 120)
//                                .clipShape(Circle()).padding(.leading, 30).padding(.trailing)
//                        }
//                        Button {
//                            showPicker.toggle()
//                            imageChange = true
//                            
//                        } label: {
//                            Image(systemName: "pencil.circle.fill")
//                                .resizable()
//                                .frame(width: 30, height: 30)
//                                .symbolRenderingMode(.multicolor)
//                                .padding([.top, .leading], 90.0)
//                                .font(.callout)
//                                .foregroundColor(gtGreen)
//                        }
//                        .tint(gtGreen)
//                    }.padding(.bottom, 25)
//                        .cropImagePicker(
//                            options: [.circle],
//                            show: $showPicker,
//                            croppedImage: $croppedImage4
//                        )
//                }
//                ZStack{
////                    Rectangle().frame(maxWidth: .infinity, maxHeight: 50).foregroundColor(gtPink)
//                    VStack (spacing: 15){
//                        ForEach(userState.userProfile.links, id: \.self){ link in
//                            HStack{
//                                Socials(url: link, active: false)
//                                TextField(link, text: $newlink).textFieldStyle(.roundedBorder).fontDesign(.serif).font(.system(size: 20)).onChange(of: newlink) { newValue in
//                                    userState.removeLink(url:link)
//                                    userState.addLink(url: newlink)
//                                }
////                                ZStack{
////                                    RoundedRectangle(cornerRadius: 5).stroke(.gray.opacity(0.5), lineWidth: 1.2).frame(width: 300, height: 50)
////                                    Text(link).frame(alignment: .leading)
////                                }
//                                Button {
//                                    userState.removeLink(url: link)
//                                } label: {
//                                    Image(systemName: "minus")
//                                }
//                            }
//                        }
////                        Button {
////                            presentAlert.toggle()
////                        } label: {
////                            HStack{
////                                Image(systemName: "plus").foregroundColor(.gray)
////                                Text("Add Social Links").font(.system(size: 15)).fontDesign(.serif).foregroundColor(.gray)
////                            }
////                        }.alert("Profile Link", isPresented: $presentAlert) {
////                            TextField("", text: $link)
////                            Button("Create", action: {userState.addLink(url: link)})
////                            Button("Cancel", role: .cancel, action: {})
////                        }
//
//
//                    }
//                }
//                if imageChange || nameChange || locationChange {
//                    Button {
//                        withAnimation(.spring()){
//                            if nameChange{
//                                userState.updateName(name: name)
//                            }
//                            if locationChange{
//                                userState.updateLocation(location: location)
//                            }
//                            if croppedImage4 != nil{
//                                userState.updateProfilePhoto(photo: croppedImage4!)
//                            }
//                            edit.toggle()
//                        }
//                    } label: {
//                        HStack{
//                            Text("Save")
//                                .font(.callout)
//                                .fontWeight(.bold)
//                                .fontDesign(.serif)
//                                .foregroundColor(.white)
//                            Image(systemName: "checkmark.circle").foregroundColor(.white)
//                        }
//                        .background {
//                            Capsule()
//                                .fill(gtGreen.gradient)
//                        }
//                    }
//                    .frame(maxWidth: .infinity,maxHeight: .infinity)
//                }
//                
//            }}
//        }
//    
//    @ViewBuilder
//    func HeaderView(_ safeAreaTop: CGFloat)->some View{
//        ZStack{
//            Rectangle().fill(gtPink.gradient).frame(height: 117).ignoresSafeArea()
//            HStack(spacing: 0){
//                Text("Girls Take").font(Font.custom("Italiana-Regular", size: 40)).foregroundColor(.white)
//                Image("Olives").resizable().frame(width: 70, height: 70).padding(.trailing, -10)
//            }.offset(x: -55, y: -22)
//            .overlay(alignment: .topTrailing, content: {
//                HStack(spacing: 5){
//                    Button{
//                        showMenu.toggle()
//                    } label:{
//                        Image(systemName: "list.bullet")
//                    }
//                    .font(.title3)
//                    .fontWeight(.semibold)
//                    .foregroundColor(.gray)
//                    .offset(x: 55, y: -4)
//                }
//                
//            })
//            .animation(.easeInOut(duration: 0.1), value: showMenu)
//            
//        }
//
//    }
//    @ViewBuilder
//    func CustomHeaderView(_ safeAreaTop: CGFloat, title: String)->some View{
//        ZStack{
//            Rectangle().stroke(gtGreen, lineWidth: 1.2).frame(height: 117).ignoresSafeArea()
//            HStack(spacing: 0){
//                Text(title).font(Font.custom("Italiana-Regular", size: 40)).foregroundColor(.black)
//                Image("Olives").resizable().frame(width: 70, height: 70).padding(.trailing, -10)
//            }.offset(x: 55, y: -70)
//            .overlay(alignment: .topTrailing, content: {
//                HStack(spacing: 5){
//                }
//                
//            })
//            .animation(.easeInOut(duration: 0.1), value: showMenu)
//            
//        }
//
//    }
//
//
//}
//
