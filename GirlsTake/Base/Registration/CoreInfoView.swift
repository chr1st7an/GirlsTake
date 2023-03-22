//
//  NameInputView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/18/23.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct CoreInfoView: View {
    @EnvironmentObject var userState : UserStateViewModel
    enum Field {
        case name, dob, location
    }
    @FocusState private var focusField: Field?
    @State private var isDatePicker : Bool = false
    @State private var selection: DropDownSelection = .init(value: "NYC")
    @State var name = ""
    @State var dob = "mm/dd/yy"
    @State var date = Date.now
    @State var selectedItem: PhotosPickerItem? = nil
    @State var selectedImageData: Data? = nil
    @State var profilePhoto: UIImage = UIImage()
    @State var userinfo : [InfoSlideModel] = registration
    var slideInfo : InfoSlideModel
    var body: some View {
        ZStack{
            slideInfo.backgroundColor.ignoresSafeArea(.all, edges: .all)
            
            VStack{
                ScrollView(.vertical){
                    VStack{
                        Rectangle().frame(height: 40).foregroundColor(gtPink)
                    }
                    Text(slideInfo.title)
                        .font(Font.custom("Italiana-Regular", size: 30))
                        .font(.system(size: 30, weight: .semibold))
                        .animation(Animation.interpolatingSpring(stiffness: 40, damping: 8))
                    Text(slideInfo.subtitle)
                        .font(Font.custom("Italiana-Regular", size: 17))
                        .font(.system(size: 17, weight: .regular))
                        .animation(Animation.interpolatingSpring(stiffness: 40, damping: 8))
                    VStack(spacing: 50){
                        ZStack{
                            if selectedImageData != nil{
                                Image(uiImage: profilePhoto)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 200, height: 200)
                                    .clipShape(Circle())
                            } else{
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 200, height: 200)
                                    .clipShape(Circle())
                                    .font(Font.title.weight(.ultraLight))
                                    .foregroundColor(.gray)
                            }
                            PhotosPicker(
                                selection: $selectedItem,
                                matching: .images,
                                photoLibrary: .shared()) {
                                    Image(systemName: "pencil.circle.fill")
                                        .symbolRenderingMode(.multicolor)
                                        .padding([.top, .leading], 130.0)
                                        .font(.system(size: 40))
                                        .foregroundColor(gtGreen)
                                }
                                .onChange(of: selectedItem) { newItem in
                                    Task {
                                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                            selectedImageData = data
                                            profilePhoto = UIImage(data: selectedImageData!)!
                                            self.userState.profilePhoto = profilePhoto
                                        }
                                    }
                                }
                        }
                        .padding().animation(Animation.interpolatingSpring(stiffness: 40, damping: 8))
                            TextField("name", text: $name).textFieldStyle(SimpleTextFieldBackground(systemImageString: "person", buttonSystemImageString: "", callback: $isDatePicker)).font(Font.custom("Italiana-Regular", size: 17)).autocorrectionDisabled().submitLabel(.next).focused($focusField,equals: .name).onSubmit {
                                focusField = .dob
                                self.userState.name = name
                            }
                        VStack {
                            HStack {
                                Image(systemName: "birthday.cake")
                                // Reference the TextField here
                                Text(dob).font(Font.custom("Italiana-Regular", size: 17))
                                Spacer()
                                Image(systemName: isDatePicker ? "chevron.down" : "calendar")
                                    .rotationEffect(.init(degrees: isDatePicker ? -180 : 0))
                                    .padding(.bottom, 5).padding(.trailing, 8)
                                
                            }
                            .onTapGesture {
                                isDatePicker.toggle()
                            }
                            .padding(.leading)
                            .foregroundColor(.gray)
                            Rectangle().frame(width: 330, height:1.5).foregroundColor(.gray.opacity(0.5)).padding(.leading, -23)
                        }
                        if isDatePicker {
                            DatePicker("", selection: $date, displayedComponents: .date).datePickerStyle(.wheel).fontDesign(.serif).onChange(of: date, perform: { newValue in
                                let formatter1 = DateFormatter()
                                formatter1.dateStyle = .short
                                self.dob = formatter1.string(from: date)
                                userState.dob = self.dob
                            }).onSubmit {
                                isDatePicker.toggle()
                            }.padding(.top, -35).padding(.bottom, -35)
                        }
//                        TextField("location", text: $location).textFieldStyle(SimpleTextFieldBackground(systemImageString: "mappin.and.ellipse", buttonSystemImageString: "chevron.down", callback: $isDropDown)).submitLabel(.done).focused($focusField,equals: .location).onSubmit {
//                            focusField = nil
//                            self.userState.location = location
//                        }
                        VStack{
                            DropDown(content: ["NYC", "Boston", "Philly"], selection: $selection, activeTint: gtPink, inActiveTint: gtPink).padding(.bottom, -8).onChange(of: selection) { newValue in
                                userState.location = newValue.lastSelection
                            }
                            Rectangle().frame(width: 330, height:1.5).foregroundColor(.gray.opacity(0.5)).padding(.leading, -23)
                        }.padding(.top, -8)
                        Image("Olives").resizable().frame(width: 50, height: 50, alignment: .center)
                        }
                    }
            }.foregroundColor(.black).animation(.easeInOut(duration: 0.5)).padding(.horizontal)
        }.padding(.horizontal)
    }
}

//struct NameInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        NameInputView()
//    }
//}
