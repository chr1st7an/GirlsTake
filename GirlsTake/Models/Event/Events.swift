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
    var AttendeesString : [String]
    var Cover : String
}
