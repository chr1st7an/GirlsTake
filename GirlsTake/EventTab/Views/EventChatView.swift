//
//  EventChatView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/30/23.
//

import SwiftUI

struct EventChatView: View {
    var title: String
    var body: some View {
        VStack{
            Text("Chat")
            Text(title)
        }
    }
}

struct EventChatView_Previews: PreviewProvider {
    static var previews: some View {
        EventChatView(title: "title")
    }
}
