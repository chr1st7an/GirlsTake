//
//  HomeView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 2/28/23.
//

import SwiftUI
import FirebaseStorage

struct EventsView: View {
    @State var offsetY: CGFloat = 0
    @State var showSearchBar: Bool = false
    @State var showFilterBar: Bool = false
    // MARK: Universal Gesture State
    @Environment(\.isDragging) var isDragging
    @State var reset: Bool = false
    @EnvironmentObject var vm: UserStateViewModel
    @State private var path: [Event] = []
    @ObservedObject var eventState : EventStateViewModel
    @State private var name: String = ""
    @State private var carouselMode: Bool = false
    @Namespace private var animation
    
    var body: some View {
        NavigationStack(path: $path) {
            GeometryReader{proxy in
                let safeAreaTop = proxy.safeAreaInsets.top
                ScrollViewReader(content: { proxy in
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack{
                            HeaderView(safeAreaTop)
                                .offset(y: -offsetY)
                                .zIndex(1)
                            
                            /// Scroll Content Goes Here
                            VStack{
                                ForEach(self.eventState.events){event in
                                    
                                    NavigationLink(value: event){
                                        EventCardView(event: event)
                                        }
                                }
                            }
                            .padding(15)
                            .zIndex(0)
                        }
                        .id("SCROLLVIEW")
                        .offset(coordinateSpace: .named("SCROLL")) { offset in
                            offsetY = offset
                            withAnimation(.none){
                                showSearchBar = (-offset > 80) && showSearchBar
                                showFilterBar = (-offset > 80) && showFilterBar
                            }
                            
                            if !isDragging && -offsetY < 80{
                                if !reset{
                                    reset = true
                                    withAnimation(.easeInOut(duration: 0.25)){
                                        proxy.scrollTo("SCROLLVIEW", anchor: .top)
                                    }
                                }
                            }else{
                                reset = false
                            }
                        }
                    }
                    .onChange(of: isDragging) { newValue in
                        if !newValue && -offsetY < 80{
                            reset = true
                            withAnimation(.easeInOut(duration: 0.25)){
                                proxy.scrollTo("SCROLLVIEW", anchor: .top)
                            }
                        }
                    }
                })
                .coordinateSpace(name: "SCROLL")
                .edgesIgnoringSafeArea(.top)
            }
            .navigationDestination(for: Event.self) { event in
                GeometryReader{
                    let safeArea = $0.safeAreaInsets
                    let size = $0.size
                    EventsPage(eventState: eventState, event: event ,safeArea: safeArea, size: size )
                        .ignoresSafeArea()
                }
            }
            .navigationTitle("")
            
        }.refreshable {
            self.eventState.fetchEvents()
        }
        
    }
    @ViewBuilder
    func HeaderView(_ safeAreaTop: CGFloat)->some View{
        // Reduced Header Height will be 80
        let progress = -(offsetY / 80) > 1 ? -1 : (offsetY > 0 ? 0 : (offsetY / 80))
        VStack(spacing: 15){
            HStack(spacing: 15){
                ZStack{
                    HStack(spacing: 0){
                        Text("Girls Take").font(Font.custom("Italiana-Regular", size: 40))
                        Image("Olives").resizable().frame(width: 70, height: 70).padding(.trailing, -10)
                    }
                    .offset(x: progress * 55)
                    .opacity(showSearchBar || showFilterBar ? 0 : 1)
                    //Optional Search view
                    HStack(spacing: 8){
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                            .offset(x: progress * 5)
                        
                        TextField("Search", text: .constant(""))
                            .tint(.white)
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal,15)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.black)
                            .opacity(0.15)
                    }
                    .opacity(showSearchBar ? 1 : 0)
                    //Add optional filter view
                    HStack(spacing: 0){
                        CustomButton(symbolImage: "sun.max", title: "day") {
                        }

                        CustomButton(symbolImage: "moon", title: "night") {
                        }

                        CustomButton(symbolImage: "wineglass", title: "drinks") {
                        }
                        
                        CustomButton(symbolImage: "figure.cooldown", title: "active") {
                        }
                        CustomButton(symbolImage: "music.quarternote.3", title: "music"){
                            
                        }
                    }.opacity(showFilterBar ? 1 : 0)
                        .padding(.top, 15)
                }
                
                if showSearchBar || showFilterBar {
                    // MARK: Displaying XMark Button
                    Button {
                        if showFilterBar{
                            showFilterBar = false
                        }else{
                            showSearchBar = false
                            
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }.padding(.trailing, 10)
                        .padding(.bottom, 5)
                }
            }
            .offset(y: progress * 10)
            HStack(spacing: 0){
                CustomButton(symbolImage: "sun.max", title: "day") {
                }

                CustomButton(symbolImage: "moon", title: "night") {
                }

                CustomButton(symbolImage: "wineglass", title: "drinks") {
                }
                
                CustomButton(symbolImage: "figure.cooldown", title: "active") {
                }
                CustomButton(symbolImage: "music.quarternote.3", title: "music"){
                    
                }
            }
            .scaleEffect(1 + (progress))
            // Shirinking Horizontal
            .padding(.horizontal,-progress * 50)
            .padding(.top,10)
//            .padding(.bottom, 10)
            // MARK: Moving Up When Scrolling Started
            .offset(y: progress * 71)
            .opacity(showFilterBar || showSearchBar ? 0 : 1)
        }
        // MARK: Displaying Search Button
        .overlay(alignment: .topTrailing, content: {
            HStack(spacing: 15){
                Button {
                    showSearchBar = true
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .offset(x: 13, y: 10)
                .opacity(showSearchBar || showFilterBar ? 0 : -progress)
                .offset(x: progress * 5)
                Button {
                    showFilterBar = true
                } label: {
                    Image(systemName: "slider.horizontal.3")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .offset(x: 13, y: 10)
                .opacity(showSearchBar || showFilterBar ? 0 : -progress)
                .offset(x: progress * 5)
            }.padding(.trailing, 15)
            
        })
        
        .animation(.easeInOut(duration: 0.2), value: showSearchBar || showFilterBar)
        .environment(\.colorScheme, .dark)
        .padding([.horizontal,.bottom],15)
        .padding(.top,safeAreaTop + 10)
        .background {
            Rectangle()
                .fill(gtPink.gradient)
                .padding(.bottom,-progress * 110)
        }
    }
    
    // MARK: Custom Button
    @ViewBuilder
    func CustomButton(symbolImage: String,title: String,onClick: @escaping()->())->some View{
        // Fading Out Soon Than The NavBar Animation
        let progress = -(offsetY / 40) > 1 ? -1 : (offsetY > 0 ? 0 : (offsetY / 40))
        Button {
            
        } label: {
            VStack(spacing: 8){
                Image(systemName: symbolImage)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                    .frame(width: 35, height: 35)
                    .background {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(.white)
                    }
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .opacity(1 + progress)
            // MARK: Displaying Alternative Icon
            .overlay {
                Image(systemName: symbolImage)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .opacity(-progress)
                    .offset(y: -10)
            }
        }
    }
    
}

//struct HomeView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        HomeView(eventManager: EventManager()).environmentObject(UserStateViewModel())
//    }
//}
