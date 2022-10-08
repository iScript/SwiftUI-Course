//
//  GustureIView.swift
//  Demo
//
//  Created by ykq on 2022/3/20.
//

import SwiftUI

struct GustureIView: View {
    
    @State var text = "?"
    
    @State var  viewState :CGSize = .zero
    
    var body: some View {
        
        
        VStack {
            
            Text("\(text)")
            
            Circle()
                .frame(width: 100, height: 100)
                .foregroundColor(Color.blue)
                .offset(x: viewState.width, y: viewState.height)
                .animation(.easeInOut, value: viewState)
//                .onTapGesture {
//                    //
//                    text = "我被点击了"
//                }
//                .gesture(TapGesture().onEnded({ () in
//                    text = "我被点击了2"
//                }))
//                .gesture(LongPressGesture(minimumDuration: 3).onEnded({ bool in
//                    //
//                    text = "我被长按了"
//                }))
                .gesture(
                    DragGesture().onChanged({ value in
                        //
                        text = "正在拖拽"
                        viewState = value.translation
                    }).onEnded({ value in
                        text = "拖拽结束"
                        viewState = .zero
                    })
                )
                
        }
    }
}

struct GustureIView_Previews: PreviewProvider {
    static var previews: some View {
        GustureIView()
    }
}
