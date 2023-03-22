//
//  OnboardingView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/18/23.
//


import SwiftUI
import Firebase
import PhotosUI
struct OnboardingView: View {
    @EnvironmentObject var userState: UserStateViewModel
    @State var onboardingItem : [OnboardingItem] = [
        .init(value: "",
              title: "Hi!",
              subTitle: "lets ditch the promoter",
              lottieView: .init(name: "Martini",bundle: .main)),
        .init(value: "",
              title: "busy this weekend?",
              subTitle: "take a look at what we've got in store",
              lottieView: .init(name: "Skyline",bundle: .main)),
        .init(value: "",
              title: "lets make plans",
              subTitle: "join, attend, and rate events. earn perks and promote your socials",
              lottieView: .init(name: "Calendar",bundle: .main))
    ]
    // MARK: Current Slide Index
    @State var currentIndex: Int = 0
    var body: some View {
        GeometryReader{
            let size = $0.size
            
            HStack(spacing: 0){
                ForEach($onboardingItem) { $item in
                    let isLastSlide = (currentIndex == onboardingItem.count - 1)
                    VStack{
                        // MARK: Top Nav Bar
                        HStack{
                            Button("Back"){
                                if currentIndex > 0{
                                    currentIndex -= 1
                                    playAnimation()
                                }
                            }
                            .opacity(currentIndex > 0 ? 1 : 0).foregroundColor(gtGreen)
                            
                            Spacer(minLength: 0)
                            
                            Button("Skip"){
                                currentIndex = onboardingItem.count - 1
                                playAnimation()
                            }
                            .opacity(isLastSlide ? 0 : 1)
                            .foregroundColor(gtPink)
                        }
                        .animation(.easeInOut, value: currentIndex)
                        .tint(Color("Green"))
                        .fontWeight(.bold)
                        
                        // MARK: Movable Slides
                        VStack(spacing: 15){
                            let offset = -CGFloat(currentIndex) * size.width
                            // MARK: Resizable Lottie View
                            ResizableLottieView(onboardingItem: $item)
                                .frame(height: size.width)
                                .onAppear {
                                    // MARK: Intially Playing First Slide Animation
                                    if currentIndex == indexOf(item){
                                        item.lottieView.play(toProgress: 0.7)
                                    }
                                }
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5), value: currentIndex)
                            
                            Text(item.title)
                                .font(.title.bold())
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5).delay(0.1), value: currentIndex)
                            
                            Text(item.subTitle)
                                .font(.system(size: 14))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal,15)
                                .foregroundColor(.gray)
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5).delay(0.2), value: currentIndex)
                        }
                        
                        Spacer(minLength: 0)
                        
                        // MARK: Next / Login Button
                        VStack(spacing: 15){
                            Text(isLastSlide ? "Get Started" : "Next")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding(.vertical,isLastSlide ? 13 : 12)
                                .frame(maxWidth: .infinity)
                                .background {
                                    Capsule()
                                        .fill(gtPink)
                                }
                                .padding(.horizontal,isLastSlide ? 30 : 100)
                                .onTapGesture {
                                    if isLastSlide{
                                        withAnimation(.easeInOut(duration: 20)){
                                            userState.isOnboarding.toggle()
                                        }
                                        // MARK: Updating to Next Index
                                    }else{
                                        if currentIndex < onboardingItem.count - 1{
                                            // MARK: Pausing Previous Animation
                                            let currentProgress = onboardingItem[currentIndex].lottieView.currentProgress
                                            onboardingItem[currentIndex].lottieView.currentProgress = (currentProgress == 0 ? 0.7 : currentProgress)
                                            currentIndex += 1
                                            // MARK: Playing Next Animation from Start
                                            playAnimation()
                                        }
                                    }
                                }
                            
                            HStack{
                                Text("Terms of Service")
                                
                                Text("Privacy Policy")
                            }
                            .font(.caption2)
                            .underline(true, color: .primary)
                            .offset(y: 5)
                        }
                    }
                    .animation(.easeInOut, value: isLastSlide)
                    .padding(15)
                    .frame(width: size.width, height: size.height)
                }
            }
            .frame(width: size.width * CGFloat(onboardingItem.count),alignment: .leading)
        }
        
    }
    func playAnimation(){
        onboardingItem[currentIndex].lottieView.currentProgress = 0
        onboardingItem[currentIndex].lottieView.play(toProgress: 0.7)
    }
    
    // MARK: Retreving Index of the Item in the Array
    func indexOf(_ item: OnboardingItem)->Int{
        if let index = onboardingItem.firstIndex(of: item){
            return index
        }
        return 0
    }

}


