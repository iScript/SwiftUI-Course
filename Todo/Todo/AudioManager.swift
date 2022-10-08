//
//  AudioManager.swift
//  Todo
//
//  Created by ykq on 2022/3/24.
//

import Foundation
import AVKit

class AudioManager : ObservableObject{
    
    var player : AVAudioPlayer?
    @Published public var isPlaying :Bool = false
    
    func startPlayer(name:String,preLoad:Bool = false){
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else{
            print("未找到文件"); return;
        }
        
        do{
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url)
            
            if(preLoad){
                player?.numberOfLoops = -1
                player?.prepareToPlay()
            }else{
                player?.play()
            }
        }catch{
            print(error)
        }
        
    }
    
    func playToggle(){
        guard let player = player else {
            print("player未实例化")
            return
        }
        
        if(player.isPlaying){
            player.pause()
            isPlaying = false
        }else{
            player.play()
            isPlaying = true
        }

    }
    
}
