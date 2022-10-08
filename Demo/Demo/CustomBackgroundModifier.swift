//
//  CustomBackgroundModifier.swift
//  Demo
//
//  Created by ykq on 2022/3/19.
//

import SwiftUI

struct CustomBackgroundModifier : ViewModifier{
    
    var cornerRadius:CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial)
            .background(Image("logo"))
            .mask(RoundedRectangle(cornerRadius: cornerRadius))
            //.cornerRadius(13)
            .shadow(color: Color.gray, radius: 10, x: 10, y: 10)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius).stroke(.linearGradient(colors: [Color.white.opacity(0.3),Color.blue.opacity(0.4)], startPoint: .top, endPoint: .bottom))
            )
    }
}
