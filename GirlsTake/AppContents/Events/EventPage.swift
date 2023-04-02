////
////  EventsView.swift
////  GirlsTake
////
////  Created by Christian Rodriguez on 3/1/23.
////
//
//import SwiftUI
//
//struct EventsPage: View {
//
//    @ObservedObject var eventState : EventStateViewModel
//    @EnvironmentObject var userState : UserStateViewModel
//    @State var event : Event
//    @State var eventManager : EventManager
//    @State private var inView: Bool = true
//    @State private var isActive: Bool = false
//    @State private var joining: Bool = false
//    @State private var size2 = 0.8
//    @State private var opacity = 0.5
//    @Namespace private var animation
//    @Namespace private var animation2
//
//    var safeArea: EdgeInsets
//    var size: CGSize
//
//    init(eventState: EventStateViewModel, event: Event,safeArea: EdgeInsets, size: CGSize ) {
//        self.eventState = eventState
//        self.safeArea = safeArea
//        self.size = size
//        self.event = event
//        self.eventState = eventState
//        self.eventManager = EventManager(event: event)
//    }
//
//    var body: some View {
//            NavigationView {
//                if isActive{
//                    ScrollView(.vertical, showsIndicators: false) {
//                        VStack{
//                            Cover()
//                            GeometryReader{proxy in
//                                // MARK: Since We Ignored Top Edge
//                                let minY = proxy.frame(in: .named("SCROLL")).minY - safeArea.top
//                                VStack{
//                                    // JOIN/CANCEL TOGGLES
//                                    if (event.AttendeesString.contains(userState.user!.uid)) {
//                                        Button {
//                                            withAnimation(.spring()){
//                                                self.eventManager.removeAttendee(user: userState.user!.uid)
//                                                event.AttendeesString = event.AttendeesString.filter { $0 != userState.user!.uid }
//                                                userState.leaveEvent(event: event)
//                                                eventState.removeAttendee(event: event, userID: userState.user!.uid)
//                                                self.joining.toggle()
//                                            }
//                                        } label: {
//                                            HStack{
//                                                Text("Cancel")
//                                                    .font(.callout)
//                                                    .fontDesign(.serif)
//                                                    .foregroundColor(.gray)
//                                                Image(systemName: "calendar.badge.minus")
//                                            }
//                                            .padding(.horizontal,25)
//                                            .padding(.vertical,12)
//                                            .background {
//                                                Capsule()
//                                                    .fill(gtCream)
//                                            }
//
//                                        }
//                                        .frame(maxWidth: .infinity,maxHeight: .infinity)
//                                        .offset(y: minY < 50 ? -(minY - 50) : 0)
//                                    } else {
//                                        Button {
//                                            withAnimation(.spring()){
//                                                eventState.addAttendee(event: event, userID: userState.user!.uid)
//                                                event.AttendeesString.append(userState.user!.uid)
//                                                userState.joinEvent(event: event)
//                                                eventManager.addAttendee(user: userState.user!.uid)
//                                                self.joining.toggle()
//                                            }
//                                        } label: {
//                                            HStack{
//                                                Text("Join")
//                                                    .font(.callout)
//                                                    .fontWeight(.bold)
//                                                    .fontDesign(.serif)
//                                                    .foregroundColor(.white)
//                                                Image(systemName: "calendar.badge.plus").foregroundColor(.white)
//                                            }
//                                            .padding(.horizontal,25)
//                                            .padding(.vertical,12)
//                                            .background {
//                                                Capsule()
//                                                    .fill(gtGreen.gradient)
//                                            }
//                                        }
//                                        .frame(maxWidth: .infinity,maxHeight: .infinity)
//                                        .offset(y: minY < 50 ? -(minY - 50) : 0)
//                                    }
//                                    // MORE INFO TOGGLE
//                                        Button {
//                                            withAnimation(){
//                                                self.inView.toggle()
//                                            }
//                                        } label: {
//                                            VStack{
//                                                Image(systemName: inView ? "chevron.up" : "chevron.down" ).padding(.top, 10)
//                                            }
//                                        }
//                                }
//                            }
//                            .frame(height: 50)
//                            .padding(.top,-34)
//                            .zIndex(1)
//                            .matchedGeometryEffect(id: "VIEW", in: animation)
//
//                            VStack{
//                                //EXTRA INFO
//                                if inView{
//                                    EventInfoView(event: event)
//                                        .transition(.asymmetric(insertion: .push(from: Edge.top), removal: .push(from: Edge.bottom))).padding([.top, .bottom], 20)
//
//                                }
//                                //USER VIEW
//                                if joining {
//                                    loading().padding(.top, 20).matchedGeometryEffect(id: "list", in: animation2)
//                                }
//                                UserView().redacted(reason: joining ? .placeholder : []).matchedGeometryEffect(id: "list", in: animation2)
//
//                                Spacer()
//                                Image("Olives").resizable().frame(width: 50, height: 50).padding(.top, 40)
//                            }.padding(.top,10)
//                        }
//                    }
//                    .coordinateSpace(name: "SCROLL").ignoresSafeArea()
//
//                }else{
//                    SplashView(size: $size2, opacity: $opacity, isActive: $isActive).transition(.opacity)
//                }
//            }.ignoresSafeArea()
//        }
//
//    @ViewBuilder
//    func loading()-> some View{
//        var downloadAmount = 0.0
//        let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
//        VStack{
//            ProgressView("yasss slay…", value: downloadAmount, total: 100).progressViewStyle(.circular).tint(gtGreen).foregroundColor(gtGreen).fontDesign(.serif).onReceive(timer, perform: { _ in
//                if downloadAmount < 100 {
//                    downloadAmount += 10
//                } else{
////                    withAnimation {
//                        joining.toggle()
////                    }
//
//                }
//            })
//            }
//        }
//
//
//    @ViewBuilder
//    func Cover()->some View{
//        let height = size.height * 0.45
//        GeometryReader{proxy in
//            let size = proxy.size
//            let minY = proxy.frame(in: .named("SCROLL")).minY
//            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))
//
//            Image(uiImage: self.eventManager.cover)
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: size.width, height: size.height + (minY > 0 ? minY : 0))
//                .clipped()
//                .overlay(content: {
//                    ZStack(alignment: .bottom) {
//                        // MARK: Gradient Overlay
//                        Rectangle()
//                            .fill(
//                                .linearGradient(colors: [
//                                    .white.opacity(0 - progress),
//                                    .white.opacity(0.1 - progress),
//                                    .white.opacity(0.3 - progress),
//                                    .white.opacity(0.5 - progress),
//                                    .white.opacity(0.8 - progress),
//                                    .white.opacity(1),
//                                ], startPoint: .top, endPoint: .bottom)
//                            )
//
//                        VStack(spacing: 0){
//                            Text(event.Title)
//                                .font(.system(size: 36))
//                                .fontWeight(.bold)
//                                .fontDesign(.serif)
//
//                            Text(event.Date)
//                                .font(.caption)
//                                .fontWeight(.bold)
//                                .foregroundColor(.gray)
//                                .padding(.top,15)
//                                .fontDesign(.serif)
//                        }
//                        .opacity(1 + (progress > 0 ? -progress : progress))
//                        .padding(.bottom,55)
//                        // Moving With ScrollView
//                        .offset(y: minY < 0 ? minY : 0)
//                    }
//                })
//                .offset(y: -minY)
//        }
//        .frame(height: height + safeArea.top)
//    }
//    @ViewBuilder
//    func UserView()->some View{
//        VStack(spacing: 25){
//            ForEach(self.eventManager.userBase.users ,id: \.self){user in
//                    UserCardView(user: user)
//                }
//        }.padding(15)
//    }
//    @ViewBuilder
//    func HeaderView()->some View{
//        GeometryReader{proxy in
//            let minY = proxy.frame(in: .named("SCROLL")).minY
//            let height = size.height * 0.45
//            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))
//            let titleProgress = minY / height
//
//            HStack(spacing: 15){
//                Button {
//
//                } label: {
//                    Image(systemName: "chevron.left")
//                        .font(.title3)
//                        .foregroundColor(.white)
//                }
//
//                Spacer(minLength: 0)
//
//                Button {
//
//                } label: {
//                    Text("FOLLOWING")
//                        .font(.caption)
//                        .fontWeight(.semibold)
//                        .foregroundColor(.white)
//                        .padding(.horizontal,10)
//                        .padding(.vertical,6)
//                        .border(.white, width: 1.5)
//                }
//                .opacity(1 + progress)
//
//                Button {
//
//                } label: {
//                    Image(systemName: "ellipsis")
//                        .font(.title3)
//                        .foregroundColor(.white)
//                }
//            }
//            .overlay(content: {
//                Text(event.Title)
//                    .fontWeight(.semibold)
//                    // Your Choice Where to display the title
//                    .offset(y: -titleProgress > 0.75 ? 0 : 45)
//                    .clipped()
//                    .animation(.easeInOut(duration: 0.25), value: -titleProgress > 0.75)
//            })
//            .padding(.top,safeArea.top + 10)
//            .padding([.horizontal,.bottom],15)
//            .background(content: {
//                Color.black
//                    .opacity(-progress > 1 ? 1 : 0)
//            })
//            .offset(y: -minY)
//        }
//        .frame(height: 35)
//    }
//
//    }
