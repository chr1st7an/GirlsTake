//
//  RegisterView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 2/10/23.
//

import SwiftUI
import Firebase
import PhotosUI

struct RegisterView: View {
    @EnvironmentObject var vm: UserStateViewModel
    var cities = ["NYC", "Boston", "Philly"]
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    @State private var phone = ""
    @State private var dob = Date.now
    @State private var location = "NYC"
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var profilePhoto: UIImage?
    
    var body: some View {
        ZStack {
            Color.white
            ZStack{
                if selectedImageData != nil{
                    Image(uiImage: profilePhoto!)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                } else{
                    Image("Profile").resizable().frame(width: 200, height: 200)
                }
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()) {
                        Image(systemName: "pencil.circle.fill")
                            .symbolRenderingMode(.multicolor)
                            .padding([.top, .leading], 124.0)
                            .font(.system(size: 40))
                            .foregroundColor(gtGreen)
                    }
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                selectedImageData = data
                                profilePhoto = UIImage(data: selectedImageData!)
                            }
                        }
                    }
            }
            .padding(.bottom, 450.0)
            VStack(alignment: .center, spacing: 22.0){
//                Image("Olives").resizable().scaledToFit().frame(width: 250, height: 250)
                TextField("", text: $email).textFieldStyle(.plain).placeholder(when: email.isEmpty) {
                    Text("Email")
                        .foregroundColor(gtGreen).bold().fontDesign(.serif)
                }
                Rectangle().foregroundColor(.gray).frame(width: 350, height: 1).padding(-10)
                SecureField("", text:$password).foregroundColor(.black).textFieldStyle(.plain).placeholder(when: password.isEmpty) {
                    Text("Password").foregroundColor(gtGreen).bold().padding(.top, -15.0).fontDesign(.serif)
                }
                Rectangle().foregroundColor(.gray).frame(width: 350, height: 1).padding(-10.0)
                TextField("", text: $name).textFieldStyle(.plain).placeholder(when: name.isEmpty) {
                    Text("Name")
                        .foregroundColor(gtGreen).bold().padding(.top, -6.0).fontDesign(.serif)
                }
//                Rectangle().foregroundColor(.gray).frame(width: 350, height: 1).padding(-10)
//                TextField("", text: $phone).textFieldStyle(.plain).placeholder(when: phone.isEmpty) {
//                    Text("Phone Number")
//                        .foregroundColor(gtGreen).bold().padding(.top, -15.0).fontDesign(.serif)
//                }
                Rectangle().foregroundColor(.gray).frame(width: 350, height: 1).padding(-10)
                DatePicker(selection: $dob, in: ...Date.now, displayedComponents: .date){
                    Text("Enter DOB").foregroundColor(gtGreen).bold().padding(.top, -2.0).fontDesign(.serif)
                }
                .padding(.top, -15.0).datePickerStyle(.compact)
                Rectangle().foregroundColor(.gray).frame(width: 350, height: 1).padding(-10)
                Picker("wya?", selection: $location){
                    ForEach(cities, id: \.self){
                        Text($0)
                    }
                }.padding(.top, -18.0)
                
            }.padding(.top, 175.0).frame(width: 350)
            VStack(alignment: .center, spacing: 22.0) {
                Button{
                    vm.register(password: password, email: email, displayName: name, profilePhoto: profilePhoto!, DoB: dob, Location: location)
                }label: {
                    Text("Register").frame(width: 200, height: 40).foregroundColor(.black).fontDesign(.serif).background( RoundedRectangle(cornerRadius: 10 ,style: .continuous).fill(.linearGradient(colors: [gtPink, .white], startPoint: .bottom, endPoint: .top)).shadow(radius: 1)
                    )
                }
            }
            .padding(.top, 550.0).frame(width: 350)
        }.ignoresSafeArea()
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
