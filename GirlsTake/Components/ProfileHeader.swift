//
//  ProfileHeader.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/8/23.
//

import SwiftUI

struct ProfileHeader: View {
    @Binding var edit : Bool
    var body: some View {
            ZStack{
                VStack{
                    Rectangle().frame(height: 110.0).foregroundColor(gtPink)
                    Rectangle().padding(.top, -12.0).frame(height: 25.0).foregroundColor(gtCream)
                }
                HStack{
                    Spacer()
                    Image("Olives")
                        .resizable()
                        .frame(width: 90.0, height: 93.0)
                    
                    Spacer(minLength: 230)
                    if edit {
                        Image(systemName: "xmark").resizable().foregroundColor(.gray).frame(width: 30, height: 30, alignment: .trailing).onTapGesture {
                            withAnimation(.spring()) {
                                self.edit = false
                            }
                        }
                        .padding(.leading, -7.0)
                    }else{
                        Image(systemName: "rectangle.and.pencil.and.ellipsis").resizable().foregroundColor(.gray).frame(width: 30, height: 25, alignment: .trailing).onTapGesture {
                            withAnimation(.spring()) {
                                self.edit = true
                            }
                        }
                        .padding(.leading, -7.0)
                    }
                    Spacer()
                    Spacer()
                }
            }.ignoresSafeArea()
    }
}

//struct ProfileHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileHeader()
//    }
//}
