//
//  StorageManager.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/1/23.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseStorage

class StorageManager: ObservableObject{
    @Published var storageRef = Storage.storage().reference()
    var retrievedImages: UIImage? {
        didSet {
            objectWillChange.send()
        }
    }
    
//    func getPhoto(url:URL){
//        let profileRef = storageRef.child(url)
//        profileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
//            if error == nil && data != nil {
//                var image = UIImage(data: data!)
////                return image!
//                self.retrievedImages = image!
//            }
//        }
//    }

}
