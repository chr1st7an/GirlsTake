////
////  Bullshit.swift
////  GirlsTake
////
////  Created by Christian Rodriguez on 3/18/23.
////
//
//import SwiftUI
//
//struct Bullshit: View {
//    var screenWidth = UIScreen.main.bounds.width
//    @State var xOffset: CGFloat = 0
//    @State var currentPage = 0
//    var lastPage = registration.count - 1
//    var firstPage = 0
//    @Namespace var namespace
//    var body: some View {
//        ZStack{
//            GeometryReader{reader in
//                HStack(spacing: 0){
//                    ForEach(registration){ item in
//                        ItemView(item: item)
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct Bullshit_Previews: PreviewProvider {
//    static var previews: some View {
//        Bullshit()
//    }
//}
//
//struct ItemView: View {
//    var item: InfoSlideModel
//    var body: some View{
//        ZStack{
//            item.backgroundColor.ignoresSafeArea(.all, edges: .all)
//
//            VStack(spacing: 20) {
//                Image(item.image).resizable().aspectRatio(contentMode: .fit).padding(.top)
//
//                VStack(spacing: 15){
//                    Text(item.title).font(.system(size: 40, weight: .semibold)).animation(Animation.interpolatingSpring(stiffness: 40, damping: 8))
//                    Text(item.subtitle).font(.system(size: 40, weight: .regular)).animation(Animation.interpolatingSpring(stiffness: 40, damping: 8))
//
//                }
//            }
//        }
//    }
//}
