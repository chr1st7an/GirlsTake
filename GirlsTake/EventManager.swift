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

class EventManager: ObservableObject{
    @Published var storageRef = Storage.storage().reference()
    @Published var databaseRef = Firestore.firestore()
    @Published var events : [Event] = []
    @Published var db = Firestore.firestore()
    
    init(){
        fetchEvents()
    }
    
    func fetchEvents(){
        events.removeAll()
        let events = db.collection("Events")
        events.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
                
            }
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    let id = document.documentID as String
                    let title = data["Title"] as? String ?? ""
                    let venue = data["Venue"] as? String ?? ""
                    let address = data["Address"] as? String ?? ""
                    let date = data["Date_Timer"] as? String ?? ""
                    let attendees = data["Attendees"] as? [String] ?? [""]
                    let photos = data["Photos"] as? [String] ?? [""]
                    let event = Event(id: id, Title: title, Address: address, Venue: venue, Date: date, Attendees: attendees, Photos: photos)
                    self.events.append(event)
                }
            }
        }
    }
    
    func addAttendee(event: Event, userID: String){
        var currentAttendence = event.Attendees
        print(currentAttendence)
        currentAttendence.append(userID)
        print(currentAttendence)
        DispatchQueue.main.async {
            self.db.collection("Events").document(event.id!).setData(["Attendees" : currentAttendence ], merge: true){ err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
            
        }

    }
    
    func removeAttendee(event: Event, userID: String){
        var currentAttendence = event.Attendees
        print(currentAttendence)
        var update = currentAttendence.filter { $0 != userID}
        DispatchQueue.main.async {
            self.db.collection("Events").document(event.id!).setData(["Attendees" : update ], merge: true){ err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
            
        }
    }
}
