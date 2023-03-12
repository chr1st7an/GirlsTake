//
//  HomeHeader.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/8/23.
//

import SwiftUI

struct HomeHeader: View {
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
                    NavigationLink(destination: SettingsView()){
                        Image(systemName: "gearshape.fill").resizable().foregroundColor(.gray).frame(width: 30, height: 30, alignment: .trailing)
                    }
                    .padding(.leading, -7.0)
                    Spacer()
                    Spacer()
                }
            }.ignoresSafeArea()
    }
}

struct HomeHeader_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeader()
    }
}
