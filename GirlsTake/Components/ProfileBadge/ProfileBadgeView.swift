//
//  bubbletest.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/16/23.
//

import SwiftUI

struct ProfileBadgeView: View {
    let title : String
    let traitArray : [[String]]
    @State var registering : Bool
//    let chunked = socialLife.chunked(into: 3)
    @State var showing = true
    var body: some View {
        VStack {
            if registering{
                VStack{
                        ForEach(traitArray, id: \.self) { sub in
                            HStack (spacing: 5){
                                ForEach(sub, id: \.self){ trait in
                                    ProfileBadge(trait: trait, interactive: true, registering: registering)
                                }
                            }
                        }
                }
            }else{
                VStack{
                    //                    Spacer(minLength: 300)
                    HStack{
                        Spacer()
                        Text(title).font(Font.custom("Italiana-Regular", size: 17)).fontWeight(.semibold)
                        Button {
                            withAnimation(.spring()) {
                                self.showing.toggle()
                            }
                        } label: {
                            VStack{
                                Image(systemName: showing ? "chevron.up" : "chevron.down")
                            }.foregroundColor(gtGreen)
                        }
                        Spacer(minLength: 300)
                    }
                }
                VStack{
                    if showing {
                        ForEach(traitArray, id: \.self) { sub in
                            HStack (spacing: 10){
                                ForEach(sub, id: \.self){ trait in
                                    ProfileBadge(trait: trait, interactive: true, registering: registering)
                                }
                            }
                        }
                    }
                }
            }
        }
        }
        
    }


//struct bubbletest_Previews: PreviewProvider {
//    static var previews: some View {
//        bubbletest(title: "social", traitArray: socialLife)
//    }
//}
