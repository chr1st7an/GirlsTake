//
//  UserProfile.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 2/11/23.
//

import SwiftUI
import FirebaseFirestoreSwift

struct UserProfile: Hashable {
    @DocumentID var id: String?
    var email: String
    var dob: String
    var location: String
    var profilePhoto: UIImage
    var eventsAttended : [String]
    
}
