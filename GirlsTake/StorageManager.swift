import SwiftUI

import Foundation
import Firebase
import FirebaseStorage

class StorageManager: ObservableObject {
    @Published var storageRef = Storage.storage().reference()
    @Published var databaseRef = Firestore.firestore()
//    @Published var photo : UIImage = UIImage(imageLiteralResourceName: "Header")
    @Published var user : UserPreview = UserPreview(name: "", dob: "", location: "", profilePhoto: UIImage(imageLiteralResourceName: "Profile"))
    @Published var photos : [UIImage] = [UIImage(imageLiteralResourceName: "sample")]
    func getPhoto(url:String) {
        let profileRef = storageRef.child(url)
        profileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if error == nil && data != nil {
                if let image = UIImage(data: data!){
                    DispatchQueue.main.async {
//                        self.photo = image
                        self.user.profilePhoto = image
                    }
                }
            }
        }
    }
    func getPhotos(url:String) {
        let profileRef = storageRef.child(url)
        profileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if error == nil && data != nil {
                if let image = UIImage(data: data!){
                    DispatchQueue.main.async {
                        self.photos.append(image)
                    }
                }
            }
        }
    }
    func getUserPreview(user: String) {
        let databaseRef = Firestore.firestore()
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
                    self.user.name = data["name"] as! String
                    self.user.location =  data["location"] as! String
                    self.user.dob = data["dob"] as! String
                    let url = data["profileRef"] as! String
                    self.getPhoto(url: url)
                }
            }
        }
    }
}
