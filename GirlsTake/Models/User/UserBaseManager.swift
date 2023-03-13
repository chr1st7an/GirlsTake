import SwiftUI

import Foundation
import Firebase
import FirebaseStorage

class UserBaseManager: ObservableObject {
    var storageRef = Storage.storage().reference()
    var databaseRef = Firestore.firestore()
    var users : [UserPreview]
    var attendees : [String]
    
    init(attendees: [String]) {
        self.users = []
        self.attendees = attendees
        attendees.forEach { user in
            let docRef = databaseRef.collection("users").document(user)
            docRef.getDocument { [self] (document, error) in
                guard error == nil else {
                    print("error", error ?? "")
                    return
                }
                //if exists, populates local userInfo with data
                if let document = document, document.exists {
                    let data = document.data()
                    if let data = data {
                        let name = data["name"] as! String
                        let location =  data["location"] as! String
                        let dob = data["dob"] as! String
                        let url = data["profileRef"] as! String
                        let profileRef = storageRef.child(url)
                        profileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                            if error == nil && data != nil {
                                if let image = UIImage(data: data!){
                                    DispatchQueue.main.async {
                                        self.users.append(UserPreview(name: name, dob: dob, location: location, profilePhoto: image))
                                    }
                                }
                            }
                        }

                    }
                }
            }
            
        }
    }
//
//    func getPhoto(url:String) {
//        let profileRef = storageRef.child(url)
//        profileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
//            if error == nil && data != nil {
//                if let image = UIImage(data: data!){
//                    DispatchQueue.main.async {
//                    }
//                }
//            }
//        }
//    }
//    func getUserPreview(user: String) -> UserPreview {
//        Task{
//            self.fillUserData(user: user)
//        }
//        return self.user
//    }
//
//    func fillUserData(user: String){
//        let databaseRef = Firestore.firestore()
//        let docRef = databaseRef.collection("users").document(user)
//        docRef.getDocument { [self] (document, error) in
//            guard error == nil else {
//                print("error", error ?? "")
//                return
//            }
//            //if exists, populates local userInfo with data
//            if let document = document, document.exists {
//                let data = document.data()
//                if let data = data {
//                    self.user.name = data["name"] as! String
//                    self.user.location =  data["location"] as! String
//                    self.user.dob = data["dob"] as! String
//                    let url = data["profileRef"] as! String
//                    self.getPhoto(url: url)
//                    print("user")
//                    print(self.user.name)
//                }
//            }
//        }
//    }
}
