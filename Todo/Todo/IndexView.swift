//
//  IndexView.swift
//  Todo
//
//  Created by ykq on 2022/3/20.
//

import SwiftUI

struct IndexView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var showAddView = false

    
    @FetchRequest(entity: YTodo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \YTodo.created_at, ascending: false)], predicate: NSPredicate(format: "is_finished ==0")) var todos : FetchedResults<YTodo>
    
    @FetchRequest(entity: YTodo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \YTodo.created_at, ascending: false)], predicate: NSPredicate(format: "is_finished ==1")) var todos_finished : FetchedResults<YTodo>
    
    
    var body: some View {
        NavigationView {
            VStack {
                List{
                    
                    
                    if(todos.count > 0){
                        Section{
                            
                            
                            ForEach(self.todos, id:\.self){ todo in
                                
                                NavigationLink(destination: TomatoView(todo: todo)) {
                                    HStack(spacing:10) {
                                        Image(systemName: "square")
                                            .foregroundColor(Color( todo.priority ?? "gray" ))
                                            .onTapGesture {
                                                todo.is_finished = 1;
                                                do{
                                                    try self.managedObjectContext.save()
                                                }catch{
                                                    print(error)
                                                }
                                            }
                                        Text(todo.name ?? "")
                                    }
                                    .padding(.horizontal)
                                }
                                
                                
                            }
                            .onDelete(perform: deleteTodo)
                            
                            
                        }
                        .listRowSeparator(.hidden)
                    }
                   
                    if(todos_finished.count > 0 ){
                        Section("已完成") {
                            
                            ForEach(self.todos_finished, id:\.self){ todo in
                                HStack(spacing:10) {
                                    
                                    Text(todo.name ?? "")
                                        .strikethrough()
                                        .foregroundColor(Color.gray)
                                }
                                .padding(.horizontal)
                            }
                            .onDelete(perform: deleteTodoFinished)
                        }
                        .listRowSeparator(.hidden)
                    }
                    
                    
                }
            }
            .overlay(
                ZStack{
                    Circle()
                        .frame(width: 70)
                        .foregroundColor(Color("MainColor"))
                        .shadow(color: Color.gray, radius: 5, x: 1, y: 3)
                    
                    Text("+")
                        .font(.title)
                        .foregroundColor(Color.white)
                        .onTapGesture {
                            showAddView.toggle()
                        }
                }
                .padding(.bottom,15)
                .padding(.trailing,15)
                .frame(height: 70)
                ,alignment: .bottomTrailing
            )
            .sheet(isPresented: $showAddView, content: {
                AddView()
            })
            .navigationBarTitle("待办事项",displayMode: .inline)
        }
    }
    
    func deleteTodo(at offsets:IndexSet){
        let todo = todos[offsets.first!]
        managedObjectContext.delete(todo)
        do{
            try self.managedObjectContext.save()
        }catch{
            print(error)
        }
        
    }
    
    func deleteTodoFinished(at offsets:IndexSet){
        let todo = todos_finished[offsets.first!]
        managedObjectContext.delete(todo)
        do{
            try self.managedObjectContext.save()
        }catch{
            print(error)
        }
        
    }
}

struct IndexView_Previews: PreviewProvider {
    static var previews: some View {
        IndexView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
