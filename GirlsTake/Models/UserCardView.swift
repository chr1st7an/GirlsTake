//
//  UserCardView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/7/23.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct UserCardView: View {
    @State var storageManager : StorageManager
    let user : String
    
    init(user: String) {
        self.user = user
        self.storageManager = StorageManager()
        self.storageManager.getUserPreview(user: user)
    }
    var body: some View {
        HStack(spacing: 25){
            Image(uiImage: self.storageManager.user.profilePhoto).resizable().frame(width: 45, height: 45, alignment: .trailing).clipShape(Circle())

            VStack(alignment: .leading, spacing: 6) {
                Text(self.storageManager.user.name)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)

                Text(self.storageManager.user.location)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity,alignment: .leading)

            Image(systemName: "ellipsis")
                .foregroundColor(.gray)
        }
    }
}

struct UserCardView_Previews: PreviewProvider {
    static var previews: some View {
        UserCardView(user: "hTzL4LdkWGbm06hsZfCZBehGa6f2").previewLayout(.sizeThatFits)
    }
}
