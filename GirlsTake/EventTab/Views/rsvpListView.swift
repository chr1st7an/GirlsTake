//
//  rsvpListView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/31/23.
//

import SwiftUI

struct rsvpListView: View {
    @State var publicUser : EventInfoViewManager
    var id : String
    init(publicUser: EventInfoViewManager, id: String) {
        self.publicUser = publicUser
        self.id = id
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct rsvpListView_Previews: PreviewProvider {
    static var previews: some View {
        rsvpListView()
    }
}
