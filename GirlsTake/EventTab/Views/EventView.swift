//
//  EventView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/30/23.
//

import SwiftUI

struct EventView: View {
    @EnvironmentObject var userState: UserStateViewModel
    @EnvironmentObject var eventViewModel : EventViewModel
    @State var event: Event
    @State var eventViewManager : EventViewManager

    
    init(event: Event) {
        self.event = event
        self.eventViewManager = EventViewManager(event: event)
        
    }
 
    var body: some View {
        Text(event.title)
        VStack{
            NavigationLink(value: EventStackModel.chat("what")){
                Text("go to chat")
            }
            UserView()
            List{
                ForEach(self.event.rsvps, id: \.self){user in
                    Text(user)
                }
            }

        }
    }
    @ViewBuilder
    func UserView()->some View{
        VStack(spacing: 25){
            ForEach(self.eventViewManager.rsvps.users, id: \.self){ user in
                Text("hello!")
                Text(user.name)
            }
        }.padding(15)
    }
}


struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(event: Event(id: "", title: "Happy Hour", address: "123 xyz street", location: "cool bar", dateTime: "October 11, 2001 8:00 am", rsvps: [],  photos: ""))
    }
}
