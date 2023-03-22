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
                        HomeView().onChange(of: tappedTwice, perform: { tappedTwice in
                            guard tappedTwice else { return }
                            home = UUID()
                            self.tappedTwice = false
                        })
                    }
                     .tabItem {
                        Label("Home", systemImage: "house")
                     }.tag(1)
                    NavigationView {
                        EventsView(eventState: eventState).onChange(of: tappedTwice, perform: { tappedTwice in
                            guard tappedTwice else { return }
                            home = UUID()
                            self.tappedTwice = false
                        })
                    }
                    .tabItem {
                        Label("Events", systemImage: "calendar")
                    }.tag(2)
                    NavigationView {
                        ProfileView().onChange(of: tappedTwice, perform: { tappedTwice in
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

//class AppState: ObservableObject {
//    @Published var selectedTab: ContentViewTab = .home
//    @Published var homeNavigation: [HomeNavDestination] = []
//    @Published var profileNavigation: [ProfileNavDestination] = []
//    @Published var eventNavigation: [eventNavDestination] = []
//}
//enum ContentViewTab {
//    case home
//    case event
//    case profile
//}
//enum HomeNavDestination {
//    case settings
////    case eventDetails
////    case otherDetails
//}
//
//enum ProfileNavDestination {
//    case settings
//}
//enum eventNavDestination {
//    case eventDetails
//    case settings
//}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserStateViewModel()).environmentObject(EventStateViewModel())
    }
}

