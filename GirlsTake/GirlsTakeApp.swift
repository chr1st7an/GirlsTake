//
//  GirlsTakeApp.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 2/10/23.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAppCheck
//
//final class AppDelegate: NSObject, UIApplicationDelegate {
//    let providerFactory = YourSimpleAppCheckProviderFactory()
//
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//
//        AppCheck.setAppCheckProviderFactory(providerFactory)
//
//        FirebaseApp.configure()
//        return true
//    }
//}

@main
struct GirlsTakeApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var userStateViewModel = UserStateViewModel()
//    @State private var isActive = false
//    @State private var size = 0.8
//    @State private var opacity = 0.5
    
    init(){
//        let providerFactory = YourAppCheckProviderFactory()
//        AppCheck.setAppCheckProviderFactory(providerFactory)
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentDelegator().environmentObject(userStateViewModel)
        }
//        WindowGroup {
//            if isActive{
//                NavigationView{
//                    ContentDelegator().environmentObject(userStateViewModel)
//                }
//                .navigationViewStyle(.stack)
//
//            }else {
//                SplashView(size: $size, opacity: $opacity, isActive: $isActive)
//            }
//                }
    }
}
//class YourSimpleAppCheckProviderFactory: NSObject, AppCheckProviderFactory {
//  func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
//    return AppAttestProvider(app: app)
//  }
//}


