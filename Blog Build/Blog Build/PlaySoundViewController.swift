//
//  PlaySoundViewController.swift
//  Blog Build
//
//  Created by Jack on 3/24/15.
//  Copyright (c) 2015 Jack. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        //code from thiago_243118
        //This piece of code sets the sound to always play on the Speakers
        let session = AVAudioSession.sharedInstance()
        var error: NSError?
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: &error)
        session.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker, error: &error)
        session.setActive(true, error: &error)
        // end code from thiago_243118
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }
   
    @IBAction func AdvancedSettingActionButton(sender: UIButton) {
         performSegueWithIdentifier("ToAdvancedSettings", sender: receivedAudio)
        audioPlayer.currentTime = 0.0
        stopTheAudioPlayer()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ToAdvancedSettings"){
            let SliderPlayVC:SliderPlayViewController = segue.destinationViewController as SliderPlayViewController
            let data = sender as RecordedAudio
            SliderPlayVC.receivedAudio = data
        }
    }

    @IBAction func Rabbit_Fast(sender: UIButton) {
        controlSpeed(1.5)
    }
    
    @IBAction func Snail_Slow(sender: UIButton) {
        controlSpeed(0.5)
    }

    @IBAction func Stop_Action_Button(sender: UIButton) {
        audioPlayer.currentTime = 0.0
        stopTheAudioPlayer()
    }
    
    @IBAction func Chipmunk_Action_Button(sender: UIButton) {
        playAudioWithVariablePitch(1000)
     }
    
    @IBAction func DarthVader_Action_Button(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
     }
    
    func playAudioWithVariablePitch(pitch: Float){
        stopTheAudioPlayer()
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    
    func stopTheAudioPlayer(){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func controlSpeed(speed: Float){
        audioPlayer.currentTime = 0.0
        stopTheAudioPlayer()
        audioPlayer.rate = speed
        audioPlayer.play()
    }
}
