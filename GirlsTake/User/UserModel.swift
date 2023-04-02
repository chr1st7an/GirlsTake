//
//  UserModel.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/30/23.
//

import SwiftUI
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct UserModel: Hashable {
    var name: String
    var email: String
    var dob: String
    var location: String
    var socialLinks : [String]
    var profilePhoto: String
    var eventsAttended : [String]
    var traitBadges : [String]
    var additionalPhotos: [String]
    //takes
    // etc...
}

struct PublicUserModel: Hashable {
    var name: String
    var dob: String
    var location: String
    var socialLinks : [String]
    var profilePhoto: String
    var eventsAttended : [String]
    var traitBadges : [String]
    var additionalPhotos: [String]
}
