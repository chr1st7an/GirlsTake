//
//  EventCardView.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/8/23.
//

import SwiftUI
import FirebaseStorage

func EventCardView(event: Event) -> some View {
    
    GeometryReader {
        let size = $0.size
        let rect = $0.frame(in: .named("SCROLLVIEW"))
        
        HStack {

            VStack(alignment: .leading, spacing: 6) {
                Spacer(minLength: 10)
                Text(event.Title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .fontDesign(.serif)
                    .padding(.top, 10)
                
                Text("@\(event.Venue)")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .fontDesign(.serif)
                
                // Rating View
                RatingView(rating: 4)
                    .padding(.top, 10)
                
                
                HStack(spacing: 3) {
                    Text("\(event.Date)")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .fontDesign(.serif)
                    
                    Spacer(minLength: 0)
                    
                    Image(systemName: "wineglass.fill").resizable()
                        .foregroundColor(gtGreen)
                        .frame(width: 45, height: 75)
                        .padding(.trailing, 60)
                        .padding(.bottom, 55)
                }.padding(.top, -35)
                Spacer(minLength: 10)
            }.padding(.leading, 28)
                .padding(.top, 25)
            .frame(width: 350, height: size.height * 0.8)
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(gtCream)
                /// Applying Shadow
//                    .shadow(color: .black.opacity(0.08), radius: 8, x: 5, y: 5)
                    .frame(width: 350)
            }

            }
            .frame(width: size.width)
            .rotation3DEffect(.init(degrees: convertOffsetToRotation(rect)), axis: (x: 5, y: 0, z: 0), anchor: .bottom, anchorZ: 1, perspective: 0.4)
        }
        .frame(height: 220)
    }

func convertOffsetToRotation(_ rect: CGRect) -> CGFloat {
    let cardHeight = rect.height + 20
    let minY = rect.minY - 20
    let progress = minY < 0 ? (minY / cardHeight) : 0
    let constrainedProgress = min(-progress, 1.0)
    return constrainedProgress * 90
}
struct RatingView: View {
    var rating: Int
    var body: some View {
        HStack(spacing: 4) {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: "star.fill")
                    .font(.caption2)
                    .foregroundColor(index <= rating ? .yellow : .gray.opacity(0.5))
            }
            
            Text("(\(rating))")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.yellow)
                .padding(.leading, 5)
        }
    }
}
func bottomPadding(_ size: CGSize = .zero) -> CGFloat {
    let cardHeight: CGFloat = 220
    let scrollViewHeight: CGFloat = size.height
    
    return scrollViewHeight - cardHeight - 40
}

struct ScrollViewDetector: UIViewRepresentable {
    @Binding var carouselMode: Bool
    var totalCardCount: Int
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async {
            if let scrollView = uiView.superview?.superview?.superview as? UIScrollView {
                scrollView.decelerationRate = carouselMode ? .fast : .normal
                if carouselMode {
                    scrollView.delegate = context.coordinator
                } else {
                    scrollView.delegate = nil
                }
                /// Updating Total Count in real time
                context.coordinator.totalCount = totalCardCount
            }
        }
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: ScrollViewDetector
        init(parent: ScrollViewDetector) {
            self.parent = parent
        }
        
        var totalCount: Int = 0
        var velocityY: CGFloat = 0
        
        func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            /// Removing Invalid Scroll Position's
            let cardHeight: CGFloat = 220
            let cardSpacing: CGFloat = 35
            /// Adding velocity for more natural feel
            let targetEnd: CGFloat = scrollView.contentOffset.y + (velocity.y * 60)
            let index = (targetEnd / cardHeight).rounded()
            let modifiedEnd = index * cardHeight
            let spacing = cardSpacing * index
            
            if !scrollView.isDecelerating {
                targetContentOffset.pointee.y = modifiedEnd + spacing
            }
            velocityY = velocity.y
        }
        
        func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
            /// Removing Invalid Scroll Position's
            let cardHeight: CGFloat = 220
            let cardSpacing: CGFloat = 35
            /// Adding velocity for more natural feel
            let targetEnd: CGFloat = scrollView.contentOffset.y + (velocityY * 60)
            let index = max(min((targetEnd / cardHeight).rounded(), CGFloat(totalCount - 1)), 0.0)
            let modifiedEnd = index * cardHeight
            let spacing = cardSpacing * index
            
            scrollView.setContentOffset(.init(x: 0, y: modifiedEnd + spacing), animated: true)
        }
    }
}

