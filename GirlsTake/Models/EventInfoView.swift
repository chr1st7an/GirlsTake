//
//  EventInfoView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/11/23.
//

import SwiftUI

struct EventInfoView: View {
    var event : Event
    var body: some View {
        HStack{
            VStack(spacing: 13){
                HStack{
                    Image(systemName: "at").foregroundColor(gtGreen)
                    Text(event.Venue).fontDesign(.serif).frame(maxWidth: .infinity, alignment: .leading).foregroundColor(.gray)
                }.padding(.leading)
                HStack{
                    Button{
                        //to maps
                    } label: {
                        HStack{
                            Image(systemName: "mappin").foregroundColor(gtGreen)
                            Text(event.Address).fontDesign(.serif).frame(maxWidth: .infinity, alignment: .leading).foregroundColor(.gray)
                        }.padding(.leading)
                    }
                }
                HStack{
                    Image(systemName: "calendar").foregroundColor(gtGreen)
                    Text(event.Date).fontDesign(.serif).frame(maxWidth: .infinity, alignment: .leading).foregroundColor(.gray)
                }.padding(.leading)
            }.padding(.leading, 20)
            Image(systemName: "square.and.arrow.up").resizable().frame(width: 30, height: 40).padding(.trailing, 65).foregroundColor(.gray)
        }
    }
}

struct EventInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EventInfoView(event: Event(Title: "Event", Address: " 123 Event Street", Venue: "Bar", Date: "June 1 @9pm", Attendees: ["String"], Photos: "sample"))
    }
}
