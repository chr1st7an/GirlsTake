//
//  UserProfile.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 2/11/23.
//

import SwiftUI
import FirebaseFirestoreSwift

struct UserProfile: Hashable {
    var id: String
    var email: String
    var dob: String
    var age: Int
    var location: String
    var links : [String]
    var profilePhoto: UIImage
    var eventsAttended : [String]
    
}
