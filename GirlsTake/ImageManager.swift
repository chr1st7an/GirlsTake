//
//  ImageManager.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/10/23.
//

import SwiftUI

import Foundation
import Firebase
import FirebaseStorage

//class ImageManager: ObservableObject{
//    @Published var retrievedImages = [UIImage]()
//    @Published var cover = UIImage()
//    @Published var storageRef = Storage.storage().reference()
//    @Published var databaseRef = Firestore.firestore()
//
//    func getEventImages(event: Event) {
//        self.retrievedImages.removeAll()
//        let photosRef  = storageRef.child(event.Photos)
//        photosRef.listAll { (result, error) in
//                if let error = error {
//                        print("Error while listing all files: ", error)
//                }else{
//
//                    for item in result!.items {
//
//                        item.getData(maxSize: 5 * 1024 * 1024) { data, error in
//                                    if error == nil && data != nil {
//                                        if let image = UIImage(data: data!){
//                                            DispatchQueue.main.async {
//                                                self.retrievedImages.append(image)
//                                            }
//                                        }
//                                    }
//                                }
//                    }
//
//                }
//        }
//    }
//    func getEventCover(event: Event) {
////        self.retrievedImages.removeAll()
//        let photosRef  = storageRef.child(event.Photos)
//        let coverRef = photosRef.child("1.png")
//        coverRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
//            if error == nil && data != nil {
//                if let image = UIImage(data: data!){
//                    DispatchQueue.main.async {
//                        self.cover = image
//                    }
//                }
//            }
//        }
//    }
//}
