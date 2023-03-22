//
//  LocationInputView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/18/23.
//

import SwiftUI

struct LocationInputView: View {
    @EnvironmentObject var userState : UserStateViewModel
    @State var value : String = ""
    var slideInfo : InfoSlideModel
    var body: some View {
        ZStack{
            slideInfo.backgroundColor.ignoresSafeArea(.all, edges: .all)
            VStack(spacing: 20){
                Image(slideInfo.image).resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top)
                VStack(spacing: 15){
                    Text(slideInfo.title)
                        .font(.system(size: 40, weight: .semibold, design: .serif))
                        .animation(Animation.interpolatingSpring(stiffness: 40, damping: 8))
                    TextField("", text: $value).textFieldStyle(.plain).onSubmit {
                        userState.location = value
                    }
                    Text(slideInfo.subtitle)
                        .font(.system(size: 20, weight: .regular, design: .serif))
                        .animation(Animation.interpolatingSpring(stiffness: 40, damping: 8))
                    Spacer()
                }.padding(.horizontal)
                Spacer()
            }.foregroundColor(.black)
        }
    }
}

//struct LocationInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationInputView()
//    }
//}
