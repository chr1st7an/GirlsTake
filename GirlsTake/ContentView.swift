//
//  ContentView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 2/10/23.
//

import SwiftUI
import Firebase
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

let gtPink =  Color.init(hex: "FFEAED")
let gtGreen = Color.init(hex: "B2C4A8")
let gtCream = Color.init(hex: "FAF8F0")
    
struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var loggedIn = false
    
    var body: some View{
        if loggedIn{
            //nav to main screen
        } else{
            base
        }
    }
    var base: some View {
        ZStack {
            Color.white
            //            RoundedRectangle(cornerRadius: 30, style: .continuous).foregroundStyle(.linearGradient(colors: [.white], startPoint: UnitPoint.topLeading, endPoint: UnitPoint.bottomTrailing))
            //                .frame(width: 200, height:40)
            VStack(spacing: 20){
                Image("Olives").resizable().scaledToFit().frame(width: 250, height: 250)
                //                Text("Welcome").foregroundColor(gtPink).font(.system(size:40, weight: .bold, design: .rounded)).offset(x:0, y:-100)
                TextField("", text: $email).textFieldStyle(.plain).placeholder(when: email.isEmpty) {
                    Text("Email")
                        .foregroundColor(gtGreen).bold().fontDesign(.serif)
                }
                Rectangle().foregroundColor(.gray).frame(width: 350, height: 1).padding(-10)
                SecureField("", text:$password).foregroundColor(.white).textFieldStyle(.plain).placeholder(when: password.isEmpty) {
                    Text("Password").foregroundColor(gtGreen).bold().fontDesign(.serif)
                }
                Rectangle().foregroundColor(.gray).frame(width: 350, height: 1).padding(-10)
                Button{
                    register()
                }label: {
                    Text("Sign Up").frame(width: 200, height: 40).foregroundColor(.black).fontDesign(.serif).background( RoundedRectangle(cornerRadius: 10 ,style: .continuous).fill(.linearGradient(colors: [gtPink, .white], startPoint: .bottom, endPoint: .top)).shadow(radius: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    )
                }
                Button{
                    login()
                } label:{
                    Text("Already have an account? Login").fontDesign(.serif).foregroundColor(.black)
                }
            }.frame(width: 350)
        }.ignoresSafeArea()
    }
    func login(){
        Auth.auth().signIn(withEmail: email, password: password){result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    func register(){
        Auth.auth().createUser(withEmail: email, password: password){ result, error in if error != nil{
            print(error!.localizedDescription)
        }}
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldshow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View{
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldshow ? 1 : 0)
                self
            }
        }
}

