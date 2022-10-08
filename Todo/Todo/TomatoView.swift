//
//  TomatoView.swift
//  Todo
//
//  Created by ykq on 2022/3/22.
//

import SwiftUI

struct TomatoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @StateObject var timeManager = TimeManager()
    @StateObject var audioManager = AudioManager()
    
    let todo:YTodo
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var buttonTitle:String{
        switch timeManager.timeState{
        case .notStarted : return "开始"
        case .started : return "暂停"
        case .suspended : return "继续"
        case .finished : return "已结束"
        }
    }
    
    var body: some View {
        VStack(spacing:30) {
            Text(todo.name ?? "未知")
                .font(.title)
                .foregroundColor(Color.gray)
                .padding(.vertical,70)
            
            ZStack{
                RingView(value: timeManager.progress)
                if(timeManager.timeState == .notStarted){
                    Picker("time", selection: $timeManager.timePeriod) {
                        Text("0:10").tag(TimePeriods.tenSecond)
                        Text("10:00").tag(TimePeriods.tenMinutes)
                        Text("25:00").tag(TimePeriods.tweentyFiveMinutes)
                        Text("60:00").tag(TimePeriods.sixtyMinutes)
                    }
                    .frame(width:160)
                    .clipShape(Circle())
                    .pickerStyle(.wheel)
                }else{
                    Text(timeManager.remainTimeText)
                        .font(.largeTitle)
                }
                
            }
            .frame(width: 300, height:300)
            
            Button {
                //
                timeManager.toggle()
            } label: {
                Text(buttonTitle)
                    .foregroundColor(Color.white)
                    .padding(.horizontal,24)
                    .padding(.vertical,8)
                    .background(Color("MainColor"))
                    .cornerRadius(20)
            }
            
            if(timeManager.timeState != .notStarted){
                Button {
                    //
                    todo.is_finished = 1
                    do{
                        try self.managedObjectContext.save()
                    }catch{
                        print(error)
                    }
                    
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("完成")
                        .foregroundColor(Color.red)
                }
            }
            
            
            Spacer()

            
        }
        .navigationBarTitle("番茄钟",displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            //
            if(timeManager.timeState != .finished){
                audioManager.playToggle()
            }
        }, label: {
            Image(systemName: audioManager.isPlaying == true ? "beats.headphones" : "speaker.slash" )
        }) )
        .onReceive(timer) { timer in
            if(timeManager.timeState == .finished){ return}
            
            timeManager.tick()
            if(timeManager.timeState == .finished){
                audioManager.startPlayer(name: "finish")
            }
        }
        .onAppear {
            audioManager.startPlayer(name: "water", preLoad: true)
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear {
            UIApplication.shared.isIdleTimerDisabled = false
        }
    }
}

struct TomatoView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView{
            TomatoView(todo: YTodo(context: PersistenceController.shared.container.viewContext))
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        }
        
    }
}
