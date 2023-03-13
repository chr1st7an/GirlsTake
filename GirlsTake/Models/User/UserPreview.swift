//
//  UserPreview.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/7/23.
//

import SwiftUI
import FirebaseFirestoreSwift

struct UserPreview: Hashable {
    var name: String
    var dob: String
    var location: String
    var profilePhoto: UIImage
}
