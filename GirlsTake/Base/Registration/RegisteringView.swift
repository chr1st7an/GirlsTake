//
//  OnboardingView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/15/23.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct RegisteringView: View {
    @EnvironmentObject var userState: UserStateViewModel
    var screenWidth = UIScreen.main.bounds.width
    @State var xOffset: CGFloat = 0
    @State var currentPage = 0
    var lastpage = registration.count - 1
    var firstpage = 0
    @State var isLast = false
    @State var isFirst = true
    @State var didAgree = false
    @Namespace var namespace
//    @State private var email = ""
//    @State private var password = ""
//    @State private var name = ""
//    @State private var dob = Date.now
//    @State private var location = "NYC"
//    @State private var selectedItem: PhotosPickerItem? = nil
//    @State private var selectedImageData: Data? = nil
//    @State private var profilePhoto: UIImage = UIImage()
//    @State var userinfo : [InfoSlideModel] = registration
//    var cities = ["NYC", "Boston", "Philly"]

    var body: some View {
        ZStack{
            gtPink.ignoresSafeArea()
            HStack(spacing: 6) {
                ForEach(0..<lastpage){i in
                    Circle().frame(width: 6, height: 6)
                }
            }.foregroundColor(.white)
            GeometryReader{reader in
                HStack(spacing: 0) {
                    ForEach(registration){ info in
                        InfoSlideView(slideInfo: info).frame(width: screenWidth)
                    }
                    .offset(x: xOffset)
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                onChanged(value: value)
                                checkPage(current: currentPage)
                            })
                            .onEnded({ value in
                                onEnded(value: value)
                                checkPage(current: currentPage)
                            })
                    )
                }
                VStack(spacing: 20) {
                        Spacer()
                    ZStack{
                        VStack{
                            if isLast{
                                HStack{
                                    Button {
                                        withAnimation(.spring()){
                                            didAgree.toggle()
                                        }
                                    } label: {
                                        HStack{
                                            Image(systemName: didAgree ? "checkmark.square" : "square").resizable().frame(width: 25, height: 25).foregroundColor(.black)
                                            Text("I agree to the Terms of Service and Privacy Policy").font(.system(size: 13, design: .serif)).foregroundColor(.gray)
                                        }
                                    }
                                    
                                }
                            }
                            HStack(spacing: 6) {
                                ForEach(0..<registration.count ){ i in
                                    if i == currentPage{
                                        Capsule()
                                            .matchedGeometryEffect(id: "page", in: namespace)
                                            .frame(width: 18, height: 6)
                                            .animation(.default)
                                    }else{
                                        Circle()
                                            .frame(width: 6, height: 6)
                                    }
                                }
                            }
                            .foregroundColor(.white )
                        }
                    }
                    ZStack{
                        if isLast {
                            VStack{
                                if didAgree{
                                    Button(action: {
                                        withAnimation(.easeInOut(duration: 20)){
                                            userState.register()
                                        }
                                    }, label: {
                                        Text("Register")
                                            .foregroundColor(.black)
                                            .fontWeight(.semibold)
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 60)
                                            .background(Capsule().fill(Color.white))
                                    })
                                    HStack{
                                        Text("Terms of Service")
                                        
                                        Text("Privacy Policy")
                                    }
                                    .foregroundColor(.black)
                                    .font(.caption2)
                                    .underline(true, color: .primary)
                                    .offset(y: 5)
                                }else{
                                    HStack{
                                        Text("Terms of Service")
                                        
                                        Text("Privacy Policy")
                                    }
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 30)
                                    .foregroundColor(.black)
                                    .font(.caption2)
                                    .underline(true, color: .primary)
                                    .offset(y: 5)
                                }
                            }.padding(.bottom, 20)
                        }else if isFirst {
                            HStack{
                                
                                Spacer()
                                Button(action: {
                                    currentPage += 1
                                    checkPage(current: currentPage)
                                    withAnimation {
                                        xOffset = -screenWidth * CGFloat(currentPage)
                                    }
                                }, label: {
                                    HStack{
                                        Text("Next")
                                        Image(systemName: "arrow.right")
                                    }.background(Capsule().fill(gtGreen).frame(width:110,height: 40))
                                    .font(.system(size: 17, weight: .bold))
                                    .frame(maxWidth: .infinity)
                                })
                            }.frame(height: 60)
                                .foregroundColor(.white)
                        } else {
                            HStack{
                                Button(action: {
                                    currentPage -= 1
                                    checkPage(current: currentPage)
                                    withAnimation {
                                        xOffset = -screenWidth * CGFloat(currentPage)
                                    }
                                }, label: {
                                    HStack{
                                        Image(systemName: "arrow.left")
                                        Text("Back")
                                    }.background(Capsule().fill(gtGreen).frame(width:110,height: 40)).font(.system(size: 17, weight: .bold))
                                        .frame(maxWidth: .infinity)
                                })
                                Spacer()
                                Button(action: {
                                    currentPage += 1
                                    checkPage(current: currentPage)
                                    withAnimation {
                                        xOffset = -screenWidth * CGFloat(currentPage)
                                    }
                                }, label: {
                                    HStack{
                                        Text("Next")
                                        Image(systemName: "arrow.right")
                                    }.background(Capsule().fill(gtGreen).frame(width:110,height: 40))
                                    .font(.system(size: 17, weight: .bold))
                                    .frame(maxWidth: .infinity)
                                })
                            }.frame(height: 60)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal)
                }.ignoresSafeArea(.keyboard)
            }
        }
    }
    func onChanged(value: DragGesture.Value){
        xOffset = value.translation.width - (screenWidth  * CGFloat(currentPage))
    }
    func onEnded(value: DragGesture.Value){
        if -value.translation.width * 3 > screenWidth / 2 && currentPage < lastpage {
            currentPage += 1
            checkPage(current: currentPage)
        } else {
            if value.translation.width * 3 > screenWidth / 2 && currentPage > firstpage {
                currentPage -= 1
                checkPage(current: currentPage)
            }
        }
        withAnimation {
            xOffset = -screenWidth * CGFloat(currentPage)
        }
    }
    func checkPage(current: Int){
        if current == lastpage {
            withAnimation(.spring()){
                self.isLast = true
            }
        } else if current == firstpage {
            withAnimation(.spring()){
                self.isFirst = true
            }
        } else {
            withAnimation(.spring()){
                self.isLast = false
                self.isFirst = false
            }
        }
    }
}

struct InfoSlideView: View {
    @EnvironmentObject var userState : UserStateViewModel
    @State var value : String = ""
    var slideInfo: InfoSlideModel
    var body :  some View{
        if slideInfo.title == "Hi" {
//          auth
            AuthInputView(slideInfo: slideInfo)
        } else if slideInfo.title == "Thanks!"{
//          core
            CoreInfoView(slideInfo: slideInfo)
        } else if slideInfo.title == "Define yourself"{
//          profile badges
//            ProfileBadgeInputView(slideInfo: slideInfo)
        } else if slideInfo.title == "Lets wrap things up :)"{
//          social links
            LocationInputView(slideInfo: slideInfo)
        }
//        ZStack{
//            VStack(spacing: 20){
//                VStack(spacing: 15){
//                    Text(slideInfo.title)
//                        .font(.system(size: 40, weight: .semibold, design: .serif)).foregroundColor(.black)
//                        .animation(Animation.interpolatingSpring(stiffness: 40, damping: 8))
//                    if slideInfo.title == "Welcome!" {
//            //          Name
//                        TextField("", text: $value).textFieldStyle(.plain).onSubmit {
//                            userState.name = value
//                        }
//                    } else if slideInfo.title == "What's a good email?"{
//            //          Email
//                        TextField("", text: $value).textFieldStyle(.plain).onSubmit {
//                            userState.email = value
//                        }
//                    } else if slideInfo.title == "Whats your dob?"{
//            //          Dob
//                        TextField("", text: $value).textFieldStyle(.plain).onSubmit {
//                            userState.dob = value
//                        }
//                    } else if slideInfo.title == "What city do you live in?"{
//            //          Location
//                        TextField("", text: $value).textFieldStyle(.plain).onSubmit {
//                            userState.location = value
//                        }
//                    }
//                    Text(slideInfo.subtitle)
//                        .font(.system(size: 20, weight: .regular, design: .serif)).foregroundColor(.black)
//                        .animation(Animation.interpolatingSpring(stiffness: 40, damping: 8))
//                }.padding(.horizontal)
//                Spacer()
//            }.foregroundColor(.black)
//        }
    }
}
