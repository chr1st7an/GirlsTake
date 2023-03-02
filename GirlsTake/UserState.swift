//
//  UserState.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 2/28/23.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseStorage

enum UserStateError: Error{
    case signInError, signOutError
}

@MainActor
class UserStateViewModel: ObservableObject {
    
    @Published var isLoggedIn = false
    @Published var isBusy = false
    @Published var storageRef = Storage.storage().reference()
    
    
    func getUser() -> User {
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            let email = user.email
            let photoURL = user.photoURL
            let displayName = user.displayName
            
//        }else{
//            user! {
//                let uid = "VXpyOAGFNvg0bkSPecKBgpDFzgt2"
//                let email = "email@gmail.com"
//                let photoURL = "profile_photos/.jpg"
//                let displayName = "Christian"
//
//            }
        }
        return user!
    }
    
    func login(password: String, email: String){
        Auth.auth().signIn(withEmail: email, password: password){result, error in
            if error != nil {
                //Add frontend pop-up alert for error
                print(error!.localizedDescription)
            } else{
                self.isLoggedIn.toggle()
            }
        }
    }
    func register(password: String, email: String, displayName: String, profilePhoto: UIImage, DoB: Date, Location: String){
        Auth.auth().createUser(withEmail: email, password: password){ result, error in if error != nil{
            //Add frontend pop-up alert for error
            //Figure out error catching for invalid Dob, Phone, etc.
            print(error!.localizedDescription)
        }else{
            self.isLoggedIn.toggle()
            self.updateProfilePhoto(photo: profilePhoto)
            self.updateDisplayName(name: displayName)
            }
        }
        }
    func updateProfilePhoto(photo: UIImage){
        
        let imageData = photo.jpegData(compressionQuality: 0.8)
        
        guard imageData != nil else{
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.photoURL = URL(string: "profile_photos/base.url")
            changeRequest?.commitChanges { error in
            }
            return
        }
        
        let user = self.getUser()

        let path = "profile_photos/\(user.uid).jpg"
        let fileRef = storageRef.child(path)
        
        fileRef.putData(imageData!, metadata: nil) { metadata,
            error in
            
            if error == nil && metadata != nil {
//                let db = Firestore.firestore()
//                db.collection("profilePhotoRef").document().setData(["url":path])
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.photoURL = URL(string: path)
                changeRequest?.commitChanges { error in
                  // ...
                }
            }
        }
    }
    
    func updateDisplayName(name: String){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges { error in
          // ...
        }
    }
    
}
