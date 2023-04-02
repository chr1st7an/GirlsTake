//
//  EventViewModel.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/30/23.
//

import SwiftUI
import Firebase
import FirebaseStorage
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class EventViewModel: ObservableObject {
    @Published var path: [EventStackModel]
    @Published var events: [Event]
    
    init(path: [EventStackModel] = [], events: [Event] = []){
        self.path = path
        self.events = events
        self.updateEvents()
    }
    
    func updateEvents() {
        events.removeAll()
        DatabaseManager().getEvents(completion: { (events) in
            if let events = events {
//                 add to map
                self.events = events
            } else {
                // handle error
            }
        })
    }
    
}
struct Event: Hashable {
    var id : String
    var title : String
    var address : String
    var location : String
    var dateTime : String
    var rsvps : [String]
    var photos : String
}
