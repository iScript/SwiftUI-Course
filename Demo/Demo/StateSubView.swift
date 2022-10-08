//
//  StateSubView.swift
//  Demo
//
//  Created by ykq on 2022/3/20.
//

import SwiftUI

struct StateSubView: View {
    
    @Binding var number:Int
    
    var body: some View {
        Image(systemName: "die.face.\(number)")
            .font(.system(size: 40))
            .foregroundColor(number == 6 ? Color.red : Color.blue)
    }
}

struct StateSubView_Previews: PreviewProvider {
    static var previews: some View {
        StateSubView(number: .constant(5))
    }
}
