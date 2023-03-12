//
//  HomeView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 2/28/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var appState = AppState()
    @StateObject var eventManager = EventManager()
    var body: some View {
        TabView(selection: $appState.selectedTab) {
                    NavigationView {
                        HomeView(eventManager: eventManager)
                    }.tag(ContentViewTab.home)
                     .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    NavigationView {
                        CalendarView()
                    }.tag(ContentViewTab.calendar)
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
    @Published var calendarNavigation: [ProfileNavDestination] = []
}
enum ContentViewTab {
    case home
    case calendar
    case profile
}
enum HomeNavDestination {
    case eventDetails
//    case otherDetails
}

enum ProfileNavDestination {
    case settings
}
enum CalendarNavDestination {
    case settings
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserStateViewModel()).environmentObject(EventManager())
    }
}

