//
//  DatabaseManager.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/30/23.
//

import SwiftUI

import Firebase

class DatabaseManager: ObservableObject {
    private let databaseRef = Firestore.firestore()

    
    func getEvents(completion: @escaping (_ events: [Event]?) -> Void)  {
        let eventsRef = databaseRef.collection("Events")
        eventsRef.addSnapshotListener { (querySnapshot, err) in
            guard let snapshot = querySnapshot else {
                if let err = err {
                    print(err)
                }

                completion(nil) // return nil if error
                return
            }
            guard !snapshot.isEmpty else {
                completion([]) // return empty if no documents
                return
            }
            var events = [Event]()

            for doc in snapshot.documents {
                let data = doc.data()
                let id = doc.documentID as String
                let title = data["Title"] as? String ?? ""
                let location = data["Location"] as? String ?? ""
                let address = data["Address"] as? String ?? ""
                let dateTime = data["Date_Time"] as? String ?? ""
                let rsvps = data["RSVPs"] as? [String] ?? [""]
                let photos = data["Photos"] as? String ?? ""
                let event = Event(id: id, title: title, address: address, location: location, dateTime: dateTime, rsvps: rsvps, photos: photos)
                events.append(event)
            }
            completion(events)
        }
    }
    
    func getPublicUser(id: String, completion: @escaping (_ user: PublicUserModel?) -> Void) {
            let userListRef = databaseRef.collection("users").document(id)
            userListRef.addSnapshotListener { (querySnapshot, err) in
                guard let snapshot = querySnapshot else {
                    if let err = err {
                        print(err)
                    }
                    
                    completion(nil) // return nil if error
                    return
                }
//                guard !snapshot.exists else {
//                    completion(nil) // return empty if no documents
//                    return
//                }
                var user = PublicUserModel(name: "", dob: "", location: "", socialLinks: [], profilePhoto: "", eventsAttended: [], traitBadges: [], additionalPhotos: [])
                
                if let doc = snapshot.data() {
                    user.name = doc["name"] as! String
                    print("NAME")
                    print("NAME")
                    print("NAME")
                    print(user.name)
                    user.location =  doc["location"] as! String
                    user.dob = doc["dob"] as! String
                    user.eventsAttended = doc["eventsAttended"] as! [String]
                    user.socialLinks = doc["links"] as! [String]
                    user.traitBadges = doc["traitBadges"] as! [String]
                }
                completion(user)
            }
        
    }
    func getPublicUsers(ids: [String], completion: @escaping (_ user: [PublicUserModel]?) -> Void) {
        var users = [PublicUserModel]()
        ids.forEach { id in
            self.getPublicUser(id: id) { user in
                if let user = user {
                    print("fuck me in the ass!!")
                    print(user.name)
                    users.append(user)
                }else{
                    //error
                }
            }
        }
        completion(users)
    }
}
