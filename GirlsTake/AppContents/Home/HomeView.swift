//
//  HomeView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/13/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack{
            Header()
            Spacer()
            Text("social stuff")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
