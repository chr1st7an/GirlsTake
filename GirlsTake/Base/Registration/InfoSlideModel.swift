//
//  InfoSlideModel.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/15/23.
//

import SwiftUI
import Combine
struct InfoSlideModel: Identifiable {
    let id = UUID().uuidString
    let backgroundColor : Color
    let image : String
    let title: String
    let subtitle: String
}


let registration = [
    InfoSlideModel(backgroundColor: gtPink, image: "Onboarding1", title: "Hi", subtitle: "lets get started"),
    InfoSlideModel(backgroundColor: gtPink, image: "Onboarding1", title: "Thanks!", subtitle: "tell us more about yourself"),
    InfoSlideModel(backgroundColor: gtPink, image: "Onboarding1", title: "Define yourself", subtitle: "pick up to 9 tags"),
    InfoSlideModel(backgroundColor: gtPink, image: "Onboarding1", title: "Lets wrap things up :)", subtitle: "you can personalize your account more later"),
]

struct SimpleTextFieldBackground: TextFieldStyle {
    
    let systemImageString: String
    let buttonSystemImageString : String
    @Binding var callback : Bool
    
    // Hidden function to conform to this protocol
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack {
            HStack {
                Image(systemName: systemImageString)
                // Reference the TextField here
                configuration
                
                Image(systemName: buttonSystemImageString).onTapGesture {
                    callback.toggle()
                }.padding(.bottom, 5).padding(.trailing, 8)
                
            }
            .padding(.leading)
            .foregroundColor(.gray)
            Rectangle().frame(width: 330, height:1.5).foregroundColor(.gray.opacity(0.5)).padding(.leading, -23)
        }
    }
}


//extension View {
//    func adaptsToKeyboard() -> some View {
//        return modifier(AdaptsToKeyboard())
//    }
//}

