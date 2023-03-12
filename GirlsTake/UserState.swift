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
    @Published var databaseRef = Firestore.firestore()
    @Published var userProfile : UserProfile = UserProfile(id: "Name", email: "email@gmail.com", dob: "21", location: "NYC", profilePhoto: UIImage(imageLiteralResourceName: "Profile"), eventsAttended: [])
    
    func getPhoto(url:String) {
        let profileRef = storageRef.child(url)
        profileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if error == nil && data != nil {
                if let image = UIImage(data: data!){
                    DispatchQueue.main.async {
                        self.userProfile.profilePhoto = image
                    }
                }
            }
        }
    }
    var user: User? {
            didSet {
                objectWillChange.send()
            }
        }
    
    func listenToAuthState() {
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = true
        settings.cacheSizeBytes = FirestoreCacheSizeUnlimited
        databaseRef.settings = settings
            Auth.auth().addStateDidChangeListener { [weak self] _, user in
                guard let self = self else {
                    //no more logged in user
//                    self?.userInfo = UserInfo(name: "String", email: "", profilePhotoURL: nil, location: "", dob: "")
                    self?.isLoggedIn = false
                    self?.user = nil
                    return
                }
                if user != nil {
                    self.user = user
                    let uid = user!.uid
                    if self.userProfile.id == "Name"{
                        self.fillInstance(uid: uid)
                    }
                    self.isLoggedIn = true
                } else{
                    self.isLoggedIn = false
                    self.user = nil
                }
            }
        }
    
    
    func login(password: String, email: String){
        Auth.auth().signIn(withEmail: email, password: password){result, error in
            if error != nil {
                //Add frontend pop-up alert for error
                print(error!.localizedDescription)
            } else{
                self.isLoggedIn.toggle()
//                self.listenToAuthState()
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
            //Adds profile photo to storage
            self.updateProfilePhoto(photo: profilePhoto)
            //populates instance of userInfo
            self.userProfile = UserProfile(id: displayName, email: email, dob: "dob", location: Location, profilePhoto: profilePhoto, eventsAttended: [])
            let user = result?.user
            //writes user data to database with uid as key
            let docRef = self.databaseRef.collection("users").document(user!.uid)
            let userData: [ String: Any ] = [
                "name": self.userProfile.id,
                "email": self.userProfile.email,
                "profileRef": "profile_photos/\(user!.uid).jpg",
                "location": self.userProfile.location,
                "dob": self.userProfile.dob,
                "eventsAttended": self.userProfile.eventsAttended
        
            ]
            docRef.setData(userData){error in
                if error != nil {
                    print("Error writing document")
                }else{
                    print("Success")
                }
            }
            }
        }
        }
    func signOut() {
            do {
                try Auth.auth().signOut()
                self.isLoggedIn = false
                self.user = nil
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
        
        }
    func deleteAccount(){
        let user = Auth.auth().currentUser
        user?.delete { error in
          if let error = error {
              print(error)
          } else {
             print("Account deleted.")
              //function call to remove them from upcoming events account is registered for.
          }
        }
    }
    
    func fillInstance(uid: String){
        let docRef = self.databaseRef.collection("users").document(uid)
        docRef.getDocument { [self] (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }
            //if exists, populates local userInfo with data
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    print("data", data)
                    self.userProfile.id = data["name"] as! String
                    self.userProfile.email = data["email"] as! String
                    self.userProfile.location =  data["location"] as! String
                    self.userProfile.dob = data["dob"] as! String
                    let url = data["profileRef"] as! String
                    self.getPhoto(url: url)
                
                }
            }
            
        }
    }
    func updateProfilePhoto(photo: UIImage){

        let imageData = photo.jpegData(compressionQuality: 0.8)
//        self.userInfo.profilePhotoURL = photo
        guard imageData != nil else{
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.photoURL = URL(string: "profile_photos/base.url")
            changeRequest?.commitChanges { error in
            }
            return
        }

        let user = self.user

        let path = "profile_photos/\(user!.uid).jpg"
        let fileRef = storageRef.child(path)

        fileRef.putData(imageData!, metadata: nil) { metadata,
            error in

            if error == nil && metadata != nil {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.photoURL = URL(string: path)
                changeRequest?.commitChanges { error in
                  // ...
                }
            }
        }
    }
    
    //SHOULD B IN ANOTHER FILE
//    func joinEvent(event: Event){
////        self.listenToAuthState()
//        var pastEvents = self.userProfile.eventsAttended //or let
//        print(pastEvents)
//        pastEvents.append(event.id!)
//        print(pastEvents)
//        self.databaseRef.collection("users").document(self.user!.uid).setData(["eventsAttended" : pastEvents ], merge: true){ err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
//    }
//
//    func leaveEvent(event: Event){
////        self.listenToAuthState()
//        let pastEvents = self.userProfile.eventsAttended //or let
//        print(pastEvents)
//        let update = pastEvents.filter { $0 != event.id }
//        print(pastEvents)
//        self.databaseRef.collection("users").document(self.user!.uid).setData(["eventsAttended" : update ], merge: true){ err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
//    }
}


