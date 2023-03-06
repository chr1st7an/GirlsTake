//
//  HomeView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 2/28/23.
//

import SwiftUI
import FirebaseStorage

struct HomeView: View {
    @EnvironmentObject var vm: UserStateViewModel
    @EnvironmentObject var eventManager : EventManager
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            VStack{
                Header()
                Spacer()
                List(eventManager.events, id: \.id){event in
                    NavigationLink(value: event){
                        Text(event.Title)
                    }
                }
                
            }.navigationDestination(for: Event.self) { event in
                EventsView(event: event)
            }
        }.refreshable {
            self.eventManager.fetchEvents()
        }
        
    }
        
    }

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(UserStateViewModel()).environmentObject(EventManager())
    }
}
