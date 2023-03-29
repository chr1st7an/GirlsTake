//
//  HomeView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 2/28/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userState: UserStateViewModel
//    @StateObject var appState = AppState()
    @StateObject var eventState = EventStateViewModel()
    @State private var tabSelection = 1
    @State private var tappedTwice: Bool = false
    @StateObject fileprivate var gestureManager = UniversalGestureManager()
    @Environment(\.isDragging) var isDragging
    @State private var home = UUID()
    @State private var event = UUID()
    @State private var profile = UUID()

    var body: some View {
        var handler: Binding<Int> { Binding(
                get: { self.tabSelection },
                set: {
                    if $0 == self.tabSelection {
                        // Lands here if user tapped more than once
                        tappedTwice = true
                    }
                    self.tabSelection = $0
                }
        )}
        
        return TabView(selection: handler) {
                    NavigationView {
                        HomeView().environment(\.isDragging, gestureManager.isDragging).onChange(of: tappedTwice, perform: { tappedTwice in
                            guard tappedTwice else { return }
                            home = UUID()
                            self.tappedTwice = false
                        })
                    }
                     .tabItem {
                        Label("Home", systemImage: "house")
                     }.tag(1)
                    NavigationView {
                        EventsView(eventState: eventState).environment(\.isDragging, gestureManager.isDragging).onChange(of: tappedTwice, perform: { tappedTwice in
                            guard tappedTwice else { return }
                            home = UUID()
                            self.tappedTwice = false
                        })
                    }
                    .tabItem {
                        Label("Events", systemImage: "calendar")
                    }.tag(2)
                    NavigationView {
                        ProfileView().environment(\.isDragging, gestureManager.isDragging).onChange(of: tappedTwice, perform: { tappedTwice in
                            guard tappedTwice else { return }
                            home = UUID()
                            self.tappedTwice = false
                        })
                    }
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }.tag(3)
        }.accentColor(gtGreen).id(home)
    }
    
}
fileprivate class UniversalGestureManager: NSObject, UIGestureRecognizerDelegate,ObservableObject{
    let gestureID = UUID().uuidString
    @Published var isDragging: Bool = false
    
    override init() {
        super.init()
        addGesture()
    }
    
    func addGesture(){
        let panGesture = UIPanGestureRecognizer()
        panGesture.name = gestureID
        panGesture.delegate = self
        panGesture.addTarget(self, action: #selector(onGestureChange(gesture:)))
        rootWindow.rootViewController?.view.addGestureRecognizer(panGesture)
    }
    
    var rootWindow: UIWindow{
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .init()
        }
        guard let window = windowScene.windows.first else{
            return .init()
        }
        
        return window
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc
    func onGestureChange(gesture: UIPanGestureRecognizer){
        if gesture.state == .changed || gesture.state == .began{
            isDragging = true
        }
        if gesture.state == .ended || gesture.state == .cancelled{
            isDragging = false
        }
    }
}

fileprivate struct UniversalGesture: EnvironmentKey{
    static let defaultValue: Bool = false
}

extension EnvironmentValues{
    var isDragging: Bool{
        get{self[UniversalGesture.self]}
        set{self[UniversalGesture.self] = newValue}
    }
}


