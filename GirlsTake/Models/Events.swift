//
//  Events.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/5/23.
//

import SwiftUI
import FirebaseFirestoreSwift

struct Event: Hashable, Codable {
    @DocumentID var id: String?
    var Title : String
    var Address : String
    var Venue : String
    var Date : String
    var Attendees : [String]
    var Photos : [String]

}
