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
//    @EnvironmentObject var appState: AppState
    @State private var path = NavigationPath()
    @ObservedObject var eventManager : EventManager
    @State private var presentAlert = false
    @State private var name: String = ""
    @State private var carouselMode: Bool = false
    @Namespace private var animation
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(){
                Header().padding(.bottom, -10)
                //                Spacer()
                GeometryReader{
                    let size = $0.size
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(spacing: 10){
                            ForEach(self.eventManager.events) { event in
                                NavigationLink(value: event){
                                    EventCardView(event: event)
                                }
                            }
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 20)
                        .padding(.bottom, bottomPadding(size))
                        .background {
                            ScrollViewDetector(carouselMode: $carouselMode, totalCardCount: self.eventManager.events.count)
                        }
                    }.coordinateSpace(name: "SCROLLVIEW")
                }.navigationDestination(for: Event.self) { event in
                    GeometryReader{
                        let safeArea = $0.safeAreaInsets
                        let size = $0.size
                        EventsView(eventManager: eventManager, event: event ,safeArea: safeArea, size: size )
                            .ignoresSafeArea()
                    }
                }
                .navigationTitle("")
                
            }.padding(.top, 15).ignoresSafeArea()
//            Button("Create event"){
//                presentAlert.toggle()
//            }.alert("Enter Name", isPresented: $presentAlert, actions: {
//                TextField("", text: $name)
//                Button("Create", action: {eventManager.addEvent(name: name)})
//                Button("Cancel", role: .cancel, action: {})
//            }) {
//                Text("CREATE EVENT")
//            }
        }.refreshable {
            self.eventManager.fetchEvents()
        }
        
    }
    
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView(eventManager: EventManager()).environmentObject(UserStateViewModel())
    }
}
