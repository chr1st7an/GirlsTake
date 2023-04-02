//
//  HomeView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 2/28/23.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @Environment(\.isDragging) var isDragging
    @EnvironmentObject var userState: UserStateViewModel
    @StateObject var eventViewModel = EventViewModel()
    var body: some View{
        TabView{
            HomeContentView().tabItem{
                Label("Home", systemImage: "house")
            }
            EventContentView().environmentObject(eventViewModel).tabItem {
                Label("Events", systemImage: "calendar")
            }
            ProfileContentView().tabItem{
                Label("Profile", systemImage: "person")
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(eventViewModel: EventViewModel())
    }
}
//    @EnvironmentObject var userState: UserStateViewModel
////    @StateObject var appState = AppState()
//    @StateObject var eventState = EventStateViewModel()
//    @State private var tabSelection = 1
//    @State private var tappedTwice: Bool = false
//    @StateObject fileprivate var gestureManager = UniversalGestureManager()
//     @Environment(\.isDragging) var isDragging
//    @State private var home = UUID()
//    @State private var event = UUID()
//    @State private var profile = UUID()
//
//    var body: some View {
//        var handler: Binding<Int> { Binding(
//                get: { self.tabSelection },
//                set: {
//                    if $0 == self.tabSelection {
//                        // Lands here if user tapped more than once
//                        tappedTwice = true
//                    }
//                    self.tabSelection = $0
//                }
//        )}
//
//        return TabView(selection: handler) {
//                    NavigationView {
//                        HomeView().environment(\.isDragging, gestureManager.isDragging).onChange(of: tappedTwice, perform: { tappedTwice in
//                            guard tappedTwice else { return }
//                            home = UUID()
//                            self.tappedTwice = false
//                        })
//                    }
//                     .tabItem {
//                        Label("Home", systemImage: "house")
//                     }.tag(1)
//                    NavigationView {
//                        EventsView(eventState: eventState).environment(\.isDragging, gestureManager.isDragging).onChange(of: tappedTwice, perform: { tappedTwice in
//                            guard tappedTwice else { return }
//                            home = UUID()
//                            self.tappedTwice = false
//                        })
//                    }
//                    .tabItem {
//                        Label("Events", systemImage: "calendar")
//                    }.tag(2)
//                    NavigationView {
//                        ProfileView().environment(\.isDragging, gestureManager.isDragging).onChange(of: tappedTwice, perform: { tappedTwice in
//                            guard tappedTwice else { return }
//                            home = UUID()
//                            self.tappedTwice = false
//                        })
//                    }
//                    .tabItem {
//                        Label("Profile", systemImage: "person")
//                    }.tag(3)
//        }.accentColor(gtGreen).id(home)
//    }
//
//}

