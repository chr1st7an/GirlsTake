//
//  LoginView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 2/28/23.
//

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
    
struct LoginView: View {
    @EnvironmentObject var vm: UserStateViewModel
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        NavigationStack{
            ZStack {
                Color.white
                VStack(spacing: 20){
                    Image("Olives").resizable().scaledToFit().frame(width: 250, height: 250)
                    TextField("", text: $email).textFieldStyle(.plain).placeholder(when: email.isEmpty) {
                        Text("Email")
                            .foregroundColor(gtGreen).bold().fontDesign(.serif)
                    }
                    Rectangle().foregroundColor(.gray).frame(width: 350, height: 1).padding(-10)
                    SecureField("", text:$password).foregroundColor(.black).textFieldStyle(.plain).placeholder(when: password.isEmpty) {
                        Text("Password").foregroundColor(gtGreen).bold().fontDesign(.serif)
                    }
                    Rectangle().foregroundColor(.gray).frame(width: 350, height: 1).padding(-10)
                    Button{
                        vm.login(password: password, email: email)
                    }label: {
                        Text("Login").frame(width: 200, height: 40).foregroundColor(.black).fontDesign(.serif).background( RoundedRectangle(cornerRadius: 10 ,style: .continuous).fill(.linearGradient(colors: [gtPink, .white], startPoint: .bottom, endPoint: .top)).shadow(radius: 1)
                        )
                    }
                    NavigationLink("Don't have an account? Sign Up"){
                        RegisterView()
                    }.fontDesign(.serif).foregroundColor(.black)
                }.frame(width: 350)
            }.ignoresSafeArea()
        }
    }

}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
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


