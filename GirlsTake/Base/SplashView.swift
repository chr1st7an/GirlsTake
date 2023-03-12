//
//  SplashView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/6/23.
//

import SwiftUI

struct SplashView: View {
    @Binding var size : Double
    @Binding var opacity : Double
    @Binding var isActive : Bool
    var body: some View {
        VStack {
                        VStack {
                            Image("Olives")
                                .resizable()
                                .frame(width: 250, height: 250)
                                .font(.system(size: 80))
                                .foregroundColor(.red)
                                .padding(.bottom, -35)
                            Text("Girls Take")
                                .font(Font.custom("Baskerville-Bold", size: 26))
                                .foregroundColor(.black.opacity(0.80))
                        }
                        .scaleEffect(size)
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.2)) {
                                self.size = 0.9
                                self.opacity = 1.00
                            }
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation {
                                self.isActive = true
                            }
                        }
                    }
                }
    }
