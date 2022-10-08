//
//  ListView.swift
//  Demo
//
//  Created by ykq on 2022/3/19.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        NavigationView {
            List{
                Section{
    //                HStack {
    //                    Image(systemName: "square.and.arrow.up.trianglebadge.exclamationmark")
    //                        .font(.system(size: 20))
    //                        .foregroundStyle(Color.red,Color.blue)
    //                    Text("通用")
    //                }
                    NavigationLink {
                        ContentView()
                    } label: {
                        Label("通用", systemImage: "square.and.arrow.up.trianglebadge.exclamationmark")
                    }
                    Label("控制中心", systemImage: "folder")
                }
               
                Section{
                    Label("关于我们", systemImage: "pencil.circle")
                }
                
            }
            .listStyle(.insetGrouped)
            .navigationTitle("设置")
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
