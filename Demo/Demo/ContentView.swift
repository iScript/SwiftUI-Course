//
//  ContentView.swift
//  Demo
//
//  Created by ykq on 2022/3/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            Image("logo")
                .resizable()
                .frame(width: 60.0, height: 60.0)
                .cornerRadius(/*@START_MENU_TOKEN@*/12.0/*@END_MENU_TOKEN@*/)
            VStack(alignment: .leading, spacing: 5.0) {
                Text("Hello, SwiftUI!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                
                Text("I Love iOS")
            }
        }
        .padding()
        .modifier(CustomBackgroundModifier(cornerRadius: 13))
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
