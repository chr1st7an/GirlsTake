//
//  HomeView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 2/28/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
                TabView {
                    HomeView().tabItem {
                        Label("Home", systemImage: "house")
                    }
                    CalendarView().tabItem {
                        Label("Events", systemImage: "calendar")
                    }
                    ProfileView().tabItem {
                        Label("Profile", systemImage: "person")
                    }
                }.accentColor(gtGreen)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserStateViewModel()).environmentObject(EventManager())
    }
}

