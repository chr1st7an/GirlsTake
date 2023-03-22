//
//  BubbleButton.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/16/23.
//

import SwiftUI

struct ProfileBadge: View {
    @State var didTap = false
    @EnvironmentObject var userState : UserStateViewModel
    var trait : String
    @State var interactive : Bool
    @State var registering : Bool
    var body: some View {
        if interactive{
            if registering {
                Button {
                    var check = userState.traitBadges.contains(trait)
                    check.toggle()
                    handleInput(input: check)
                } label: {
                    ZStack{
                        if userState.traitBadges.contains(trait){
                            RoundedRectangle(cornerRadius: 50).foregroundColor(gtGreen).frame(width: CGFloat(trait.count * 12), height: 30)
                            Text(trait).foregroundColor(.white).font(Font.custom("Italiana-Regular", size: 15))
                        }else{
                            RoundedRectangle(cornerRadius: 50).stroke(gtGreen, lineWidth: 1.2).frame(width: CGFloat(trait.count * 12), height: 30)
                            Text(trait).foregroundColor(gtGreen).font(Font.custom("Italiana-Regular", size: 15))
                        }
                    }
                }
            }else{
                Button {
                    var check = userState.userProfile.traitBadges.contains(trait)
                    check.toggle()
                    handleInput(input: check)
                } label: {
                    ZStack{
                        if userState.userProfile.traitBadges.contains(trait){
                            RoundedRectangle(cornerRadius: 50).foregroundColor(gtGreen).frame(width: CGFloat(trait.count * 12), height: 30)
                            Text(trait).foregroundColor(.white).fontDesign(.serif).font(Font.custom("Italiana-Regular", size: 15))
                        }else{
                            RoundedRectangle(cornerRadius: 50).stroke(gtGreen, lineWidth: 1.2).frame(width: CGFloat(trait.count * 12), height: 30)
                            Text(trait).foregroundColor(gtGreen).fontDesign(.serif).font(Font.custom("Italiana-Regular", size: 15))
                        }
                    }
                }
            }
        }else{
            Button {
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 50).foregroundColor(gtGreen).frame(width: CGFloat(trait.count * 12), height: 30)
                    Text(trait).foregroundColor(.white).fontDesign(.serif).font(Font.custom("Italiana-Regular", size: 15))
                }
            }
        }
    }
    func handleInput(input : Bool){
        if input {
            userState.addTrait(trait: trait)
        }else{
            userState.removeTrait(trait: trait)
        }
        
    }
}

//struct BubbleButton_Previews: PreviewProvider {
//    static var previews: some View {
//        BubbleButton(trait: "Clubbing", interactive: true)
//    }
//}
