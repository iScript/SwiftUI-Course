//
//  RingView.swift
//  Todo
//
//  Created by ykq on 2022/3/22.
//

import SwiftUI

struct RingView: View {
    
    var value : CGFloat=0.4
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .foregroundColor(.gray).opacity(0.2)
            
            Circle()
                .trim(from: 0, to: value)
                .stroke(AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3843137255, green: 0.5176470588, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.4470588235, blue: 0.7137254902, alpha: 1)), Color(#colorLiteral(red: 0.8509803922, green: 0.6862745098, blue: 0.8509803922, alpha: 1)), Color(#colorLiteral(red: 0.5921568627, green: 0.8509803922, blue: 0.8823529412, alpha: 1)), Color(#colorLiteral(red: 0.3843137255, green: 0.5176470588, blue: 1, alpha: 1))]), center: .center),style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .foregroundColor(.gray)
                .rotationEffect(.degrees(270))
                .animation(.easeInOut(duration: 0.5), value: value)
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView()
    }
}
