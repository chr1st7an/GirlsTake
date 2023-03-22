//
//  EmailInputView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/18/23.
//

import SwiftUI

struct AuthInputView: View {
    @EnvironmentObject var userState : UserStateViewModel
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var confirm : String = ""
    enum Field {
        case email, password, confirm
    }
    @State private var isSecured : Bool = true
    @FocusState private var focusField: Field?
    var slideInfo : InfoSlideModel
    var body: some View {
        ZStack{
            slideInfo.backgroundColor.ignoresSafeArea(.all, edges: .all)
            VStack{
                HStack{
                    NavigationLink {
                        LoginView().navigationBarBackButtonHidden(true)
                    } label: {
                        Image(systemName: "chevron.backward").foregroundColor(.gray)
                    }.padding(.leading, 25).padding(.top, 15)
                    Spacer()
                }
                VStack{
//                    Spacer()
//                    Image(slideInfo.image).resizable().frame(width: 250, height: 250).padding(.bottom, 25)
                }
                VStack(spacing: 45){
                    
                    ScrollView(.vertical){
                        Image(slideInfo.image).resizable().frame(width: 250, height: 250).padding(.bottom, 15)
                        Text(slideInfo.title)
                            .font(Font.custom("Italiana-Regular", size: 30))
                            .font(.system(size: 30, weight: .semibold, design: .serif))
                            .animation(Animation.interpolatingSpring(stiffness: 40, damping: 8))
                        Text(slideInfo.subtitle)
                            .font(Font.custom("Italiana-Regular", size: 17))
                            .font(.system(size: 17, weight: .regular, design: .serif))
                            .animation(Animation.interpolatingSpring(stiffness: 40, damping: 8))
                        VStack(spacing: 50){
                            TextField("email", text: $email).textFieldStyle(SimpleTextFieldBackground(systemImageString: "envelope", buttonSystemImageString: "", callback: $isSecured)).keyboardType(.emailAddress).autocorrectionDisabled().textInputAutocapitalization(.never).submitLabel(.next).focused($focusField,equals: .email).onSubmit {
                                focusField = .password
                                self.userState.email = email
                            }
                            if isSecured {
                                SecureField("Enter Password", text: $password).textFieldStyle(SimpleTextFieldBackground(systemImageString: "lock", buttonSystemImageString: self.isSecured ? "eye.slash" : "eye", callback: $isSecured)).fontDesign(.serif).autocorrectionDisabled().submitLabel(.continue).focused($focusField,equals: .password).onSubmit {
                                    focusField = .confirm
                                    self.userState.password = password
                                }
                                SecureField("Confirm Password", text: $confirm).textFieldStyle(SimpleTextFieldBackground(systemImageString: "lock.fill" , buttonSystemImageString: self.isSecured ? "eye.slash" : "eye", callback: $isSecured)).keyboardType(.emailAddress).autocorrectionDisabled().textInputAutocapitalization(.never).submitLabel(.done).focused($focusField,equals: .confirm).onSubmit {
                                    focusField = nil
                                    self.userState.password = confirm
                                }
                            }else{
                                TextField("Enter Password", text: $password).textFieldStyle(SimpleTextFieldBackground(systemImageString: "lock" , buttonSystemImageString: self.isSecured ? "eye.slash" : "eye", callback: $isSecured)).fontDesign(.serif).autocorrectionDisabled().submitLabel(.continue).focused($focusField,equals: .password).onSubmit {
                                    focusField = .confirm
                                    self.userState.password = password
                                }
                                TextField("Confirm Password", text: $confirm).textFieldStyle(SimpleTextFieldBackground(systemImageString: "lock.fill" , buttonSystemImageString: self.isSecured ? "eye.slash" : "eye", callback: $isSecured)).keyboardType(.emailAddress).autocorrectionDisabled().textInputAutocapitalization(.never).submitLabel(.done).focused($focusField,equals: .confirm).onSubmit {
                                    focusField = nil
                                    self.userState.password = confirm
                                }
                            }
                            Image("Olives").resizable().frame(width: 50, height: 50, alignment: .center)
                        }.padding(.top, 25)
//                        Button(action: {
//                            isSecured.toggle()
//                        }) {
//                            Image(systemName: self.isSecured ? "eye.slash" : "eye")
//                                .accentColor(.gray)
//                        }.padding(.top, 20)
                    }
                    //                        Spacer()
                    //                Spacer()
                }.foregroundColor(.black).animation(.easeInOut(duration: 0.5)).padding(.horizontal)
                
            }
        }.padding(.horizontal)
    }
}

//struct EmailInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmailInputView()
//    }
//}
