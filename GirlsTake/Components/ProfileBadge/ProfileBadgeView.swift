////
////  ProfileBadgeView.swift
////  GirlsTake
////
////  Created by Christian Rodriguez on 3/16/23.
////
//
//import SwiftUI
//
//struct ProfileBadgeView: View {
//    let title : String
//    let traitArray : [[String]]
//    @State var registering : Bool
//    @State var showing = true
//    var body: some View {
//        VStack {
//            if registering{
//                VStack{
//                        ForEach(traitArray, id: \.self) { sub in
//                            HStack (spacing: 5){
//                                ForEach(sub, id: \.self){ trait in
//                                    ProfileBadge(trait: trait, interactive: true, registering: registering)
//                                }
//                            }
//                        }
//                }
//            }else{
//                VStack{
//                        ForEach(traitArray, id: \.self) { sub in
//                            HStack (spacing: 5){
//                                ForEach(sub, id: \.self){ trait in
//                                    ProfileBadge(trait: trait, interactive: false, registering: registering)
//                                }
//                            }
//                        }
//                }
//            }
//        }
//        }
//        
//    }
//
