//
//  ContentView.swift
//  Animations
//
//  Created by Ping Yun on 9/28/20.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double //controls how much rotation should be applied
    let anchor: UnitPoint //controls where rotation should take place
    
    func body(content: Content) -> some View {
        //clipped() means that when view rotates, parts outside natural rectangle do not get drawn
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

//makes rectangle rotate from -90 to 0 degrees on top leading corner
extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0,  anchor: .topLeading)
        )
    }
}

struct ContentView: View {
    @State private var isShowingRed = false //rectangle only appears when this is true
    
    var body: some View {
        VStack {
            Button("Tap Me") {
                //gets SwiftUI's default view transition
                withAnimation {
                    //toggles isShowingRed between true and false when button is tapped
                    self.isShowingRed.toggle()
                }
            }
            
            //uses isShowingRed as condition for showing rectangle
            if isShowingRed {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                    //attatches pivot animation to view
                    .transition(.pivot)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11")
    }
}
