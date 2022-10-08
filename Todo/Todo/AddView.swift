//
//  AddView.swift
//  Todo
//
//  Created by ykq on 2022/3/20.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var name = "";
    @State private var priority = "gray"
    
    @State private var showError = false
    @State private var errorMessage = ""
    
    let priorities = ["red","orange","yellow","gray","purple" ,"blue", "green"]
    
    var body: some View {
        NavigationView {
            VStack(spacing:30) {
                TextField("待办事项", text: $name)
                    .padding()
                    .background(Color(UIColor.tertiarySystemFill))
                    .cornerRadius(9)
                    .font(.body)
                
                HStack(spacing:13){
                    
                    ForEach(priorities,id:\.self){ item in
                        Circle()
                            .fill(Color(item))
                            .frame(width: 35, height: 35)
                            .opacity(priority == item ? 1 : 0.2)
                            .onTapGesture {
                                priority = item
                            }
                            
                    }
                    
                }
                
                Button {
                    //
                    if(name == ""){
                        showError = true
                        errorMessage = "待办事项必填"
                        return
                    }
                    
                    let todo = YTodo(context: self.managedObjectContext)
                    todo.name = self.name
                    todo.priority = self.priority
                    todo.is_finished = 0
                    todo.created_at = Date()
                    
                    do{
                        try self.managedObjectContext.save()
                    }catch{
                        print(error)
                    }
                    
                    self.presentationMode.wrappedValue.dismiss()
                    
                } label: {
                    Text("保存")
                        .font(.body)
                        .padding(15)
                        .frame(maxWidth:.infinity)
                        .background(Color.blue)
                        .cornerRadius(9)
                        .foregroundColor(.white)
                    
                }
                
                Spacer()

            }
            .padding(.horizontal)
            .navigationBarTitle("新增任务",displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                //
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
            }))
            .alert(isPresented: $showError) {
                Alert(title: Text("提示"), message: Text(errorMessage), dismissButton: .default(Text("确定")))
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
