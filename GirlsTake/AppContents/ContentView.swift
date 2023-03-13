//
//  HomeView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 2/28/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userState: UserStateViewModel
    @StateObject var appState = AppState()
    @StateObject var eventState = EventStateViewModel()

    var body: some View {
        TabView(selection: $appState.selectedTab) {
                    NavigationView {
                        HomeView()
                    }.tag(ContentViewTab.home)
                     .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    NavigationView {
                        EventsView(eventState: eventState)
                    }.tag(ContentViewTab.event)
                    .tabItem {
                        Label("Events", systemImage: "calendar")
                    }
                    NavigationView {
                        ProfileView()
                    }.tag(ContentViewTab.profile)
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
        }.environmentObject(appState)
            .accentColor(gtGreen)
    }
    
}

class AppState: ObservableObject {
    @Published var selectedTab: ContentViewTab = .home
    @Published var homeNavigation: [HomeNavDestination] = []
    @Published var profileNavigation: [ProfileNavDestination] = []
    @Published var eventNavigation: [eventNavDestination] = []
}
enum ContentViewTab {
    case home
    case event
    case profile
}
enum HomeNavDestination {
    case settings
//    case eventDetails
//    case otherDetails
}

enum ProfileNavDestination {
    case settings
}
enum eventNavDestination {
    case eventDetails
    case settings
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserStateViewModel()).environmentObject(EventStateViewModel())
    }
}

