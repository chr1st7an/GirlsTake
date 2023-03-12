//
//  Events.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/5/23.
//

import SwiftUI
import FirebaseFirestoreSwift

struct Event: Identifiable, Hashable {
    @DocumentID var id: String?
    var Title : String
    var Address : String
    var Venue : String
    var Date : String
    var Attendees : [String]
    var Photos : String
}
//
//var sampleEvents: [Event] = [
//    .init(Title: "Event", Address: " 123 Event Street", Venue: "Bar", Date: "June 1 @9pm", Attendees: ["String"], Photos: "sample"),
//    .init(Title: "Event1", Address: " 123 Event Street", Venue: "Bar", Date: "June 1 @10pm", Attendees: ["String"], Photos: "sample"),
//    .init(Title: "Event2", Address: " 123 Event Street", Venue: "Bar", Date: "June 1 @11pm", Attendees: ["String"], Photos: "sample"),
//    .init(Title: "Event3", Address: " 123 Event Street", Venue: "Bar", Date: "June 1 @6pm", Attendees: ["String"], Photos: "sample"),
//    .init(Title: "Event4", Address: " 123 Event Street", Venue: "Bar", Date: "June 1 @9am", Attendees: ["String"], Photos: "sample"),
//    .init(Title: "Event5", Address: " 123 Event Street", Venue: "Bar", Date: "June 1 @7pm", Attendees: ["String"], Photos: "sample"),
//]
