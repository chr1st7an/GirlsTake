////
////  DobInputView.swift
////  GirlsTake
////
////  Created by Christian Rodriguez on 3/18/23.
////
//
//import SwiftUI
//
//struct ProfileBadgeInputView: View {
//    @EnvironmentObject var userState : UserStateViewModel
//    @State var value : String = ""
//    var slideInfo : InfoSlideModel
//    var body: some View {
//        ZStack{
//            slideInfo.backgroundColor.ignoresSafeArea(.all, edges: .all)
//            VStack{
//                Text(slideInfo.title)
//                    .font(Font.custom("Italiana-Regular", size: 35))
//                    .font(.system(size: 35, weight: .semibold))
//                    .animation(Animation.interpolatingSpring(stiffness: 40, damping: 8)).padding(.top, 10)
//                ScrollView(.vertical, showsIndicators: false){
//                    VStack(spacing: 25){
//                        Label("Social", systemImage: "figure.socialdance").font(Font.custom("Italiana-Regular", size: 20)).fontWeight(.bold)
//                        ProfileBadgeView(title: "social", traitArray: socialLife, registering: true)
//                        Label("Art", systemImage: "theatermask.and.paintbrush").font(Font.custom("Italiana-Regular", size: 20))
//                        ProfileBadgeView(title: "art", traitArray: art, registering: true)
//                        Label("Values", systemImage: "heart")
//                        ProfileBadgeView(title: "values", traitArray: values, registering: true)
//                        Label("Personality", systemImage: "brain.head.profile")
//                        ProfileBadgeView(title: "personality", traitArray: descriptors, registering: true)
//                        Label("Fitness", systemImage: "figure.run")
//                        ProfileBadgeView(title: "fitness", traitArray: fitness, registering: true)
//                    }
//                    
//                }
////                Spacer()÷
//                Text(slideInfo.subtitle)
//                    .font(Font.custom("Italiana-Regular", size: 20))
//                    .font(.system(size: 20, weight: .regular))
//                    .animation(Animation.interpolatingSpring(stiffness: 40, damping: 8))
//            }.foregroundColor(.black).animation(.easeInOut(duration: 0.5)).padding(.horizontal).padding(.bottom, 100)
//        }.padding(.horizontal)
//    }
//}
//
////struct DobInputView_Previews: PreviewProvider {
////    static var previews: some View {
////        DobInputView()
////    }
////}
