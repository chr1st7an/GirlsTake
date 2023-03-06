//
//  EventsView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/1/23.
//

import SwiftUI

struct EventsView: View {
    @EnvironmentObject var eventManager : EventManager
    @EnvironmentObject var vm : UserStateViewModel
    @State var event : Event
    @State var attending : Bool = false
    var body: some View {
        if (event.Attendees.contains(vm.user!.uid) || attending) {
            Text("see u there!")
            Button{
                eventManager.removeAttendee(event: event, userID: vm.user!.uid)
                vm.leaveEvent(event: event)
//                self.attending.toggle()
                self.event.Attendees = self.event.Attendees.filter { $0 != vm.user!.uid }
                
            }label: {
                Text("Leave!").frame(width: 200, height: 40).foregroundColor(.black).fontDesign(.serif).background( RoundedRectangle(cornerRadius: 10 ,style: .continuous).fill(.linearGradient(colors: [.red, .white], startPoint: .bottom, endPoint: .top))
                )
            }
        }else{
            Text(event.Title)
            Button{
                eventManager.addAttendee(event: event, userID: vm.user!.uid)
                vm.joinEvent(event: event)
//                self.attending.toggle()
                self.event.Attendees.append(vm.user!.uid)
                
            }label: {
                Text("Sign Up!").frame(width: 200, height: 40).foregroundColor(.black).fontDesign(.serif).background( RoundedRectangle(cornerRadius: 10 ,style: .continuous).fill(.linearGradient(colors: [gtPink, .white], startPoint: .bottom, endPoint: .top))
                )
            }
        }
    }
    }

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView(event: Event(id: "", Title: "Happy Hour", Address: "", Venue: "", Date: "", Attendees: [], Photos: []))
    }
}
