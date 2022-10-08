//
//  TimeManager.swift
//  Todo
//
//  Created by ykq on 2022/3/23.
//

import Foundation

enum TimeState{
    case notStarted
    case started
    case suspended
    case finished
}

enum TimePeriods{
    case tenMinutes
    case tweentyFiveMinutes
    case sixtyMinutes
    case tenSecond
    
    var timePeriodSecond:Double{
        switch self{
        case .sixtyMinutes : return 60*60.00
        case .tenMinutes:
            return 10*60.00
        case .tweentyFiveMinutes:
            return 25*60.00
        case .tenSecond:
            return 10.00
        }
    }
}

class TimeManager : ObservableObject{
    
    @Published public var remainTimeSecond:Double = 0.00;
    @Published public var remainTimeText:String = "";
    @Published public var timeState : TimeState = .notStarted;
    @Published public var timePeriod: TimePeriods = .tweentyFiveMinutes;
    @Published public var progress:Double = 0.00;
    
    
    func toggle(){
        if(timeState == .notStarted){
            remainTimeSecond = timePeriod.timePeriodSecond
            updateRemainTimeText()
            timeState = .started
        } else if(timeState == .started){
            timeState = .suspended
        }else if(timeState == .suspended){
            timeState = .started
        }
    }
    
    func tick(){
        if(timeState == .started){
            if(remainTimeSecond == 0){
                timeState = .finished;return
            }
            remainTimeSecond -= 1
            
            progress = (timePeriod.timePeriodSecond - remainTimeSecond) / timePeriod.timePeriodSecond
        }
        
        updateRemainTimeText()
    }
    
    func updateRemainTimeText(){
        if(timeState == .finished){
            self.remainTimeText = "0:00";return;
        }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour,.minute,.second], from: Date(), to: Date().addingTimeInterval(remainTimeSecond))
        
        let date = calendar.date(from:components)
        let dfromatter = DateFormatter()
        dfromatter.dateFormat = "m:ss"
        
        let datestr = dfromatter.string(from: date!)
        self.remainTimeText = datestr
    }
}
