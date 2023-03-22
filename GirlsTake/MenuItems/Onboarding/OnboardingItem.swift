//
//  RegistrationItem.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/17/23.
//

import SwiftUI
import Lottie

struct OnboardingItem: Identifiable,Equatable{
    var id: UUID = .init()
    var value : String
    var title: String
    var subTitle: String
    var lottieView: LottieAnimationView = .init()
}
