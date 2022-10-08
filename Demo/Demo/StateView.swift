//
//  StateView.swift
//  Demo
//
//  Created by ykq on 2022/3/20.
//

import SwiftUI

struct StateView: View {
    
    @State var number = 0
    
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(spacing:5) {
            
            
            Text( colorScheme == .dark ?  "现在是暗黑模式" : "现在是浅色模式")
            
            StateSubView(number: $number)
            
            Text("你的点数是：")
            Text("\(number)")
            Button {
                //
                
                if(colorScheme == .dark){
                    number = Int(arc4random_uniform(5)+1)
                }else{
                    number = Int(arc4random_uniform(6)+1)
                }
                
            } label: {
                Text("掷骰子")
                    .padding(8)
                    .padding(.horizontal)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(15)
            }

        }
    }
}

struct StateView_Previews: PreviewProvider {
    static var previews: some View {
        StateView()
            .preferredColorScheme(.light)
    }
}
