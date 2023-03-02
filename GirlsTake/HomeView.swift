//
//  HomeView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 2/28/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            EventsView().tabItem {
                Label("Events", systemImage: "calendar")
            }
            ProfileView().tabItem {
                Label("Profile", systemImage: "person")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(UserStateViewModel())
    }
}
