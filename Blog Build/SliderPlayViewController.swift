//
//  SliderPlayViewController.swift
//  Blog Build
//
//  Created by Jack on 3/31/15.
//  Copyright (c) 2015 Jack. All rights reserved.
//

import UIKit
import AVFoundation

class SliderPlayViewController: UIViewController {
    var speedSliderValue:Float!
    var pitchSliderValue:Float!
    var echoSliderValue:Float!
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        speedSliderValue = 1.0
        pitchSliderValue = 1.0
        echoSliderValue = 0.0
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    @IBAction func SpeedSlider(sender: UISlider) {
        speedSliderValue = sender.value
        playAudioWithVariablePitch(pitchSliderValue, speed: speedSliderValue, echo: echoSliderValue)
    }
    
    @IBAction func PitchSlider(sender: UISlider) {
        pitchSliderValue = sender.value
        playAudioWithVariablePitch(pitchSliderValue, speed: speedSliderValue, echo: echoSliderValue)
    }
    
    @IBAction func EchoSlider(sender: UISlider) {
        echoSliderValue = sender.value
        playAudioWithVariablePitch(pitchSliderValue, speed: speedSliderValue, echo:echoSliderValue)
    }
    
    func playAudioWithVariablePitch(pitch: Float, speed: Float, echo: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        var changeBothEffects = AVAudioUnitTimePitch()
        changeBothEffects.pitch = pitch
        changeBothEffects.rate = speed
        audioEngine.attachNode(changeBothEffects)
        var reverb = AVAudioUnitReverb()
        reverb.wetDryMix = echo
        audioEngine.attachNode(reverb)
        audioEngine.connect(audioPlayerNode, to: changeBothEffects, format: nil)
        audioEngine.connect(changeBothEffects, to: reverb, format: nil)
        audioEngine.connect(reverb, to: audioEngine.mainMixerNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
   }

    @IBAction func Play_Slider_Action(sender: UIButton) {
        playAudioWithVariablePitch(pitchSliderValue, speed: speedSliderValue, echo: echoSliderValue)
    }
    
    @IBAction func Stop_Slider_Action(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    @IBAction func Snail_Play(sender: UIButton) {
        playAudioWithVariablePitch(pitchSliderValue, speed: speedSliderValue, echo: echoSliderValue)
    }
    
    @IBAction func Rabbit_Play(sender: UIButton) {
        playAudioWithVariablePitch(pitchSliderValue, speed: speedSliderValue, echo: echoSliderValue)
    }
    
    @IBAction func Darth_Play(sender: UIButton) {
        playAudioWithVariablePitch(pitchSliderValue, speed: speedSliderValue, echo: echoSliderValue)
    }
    
    @IBAction func Squirrel_Play(sender: UIButton) {
        playAudioWithVariablePitch(pitchSliderValue, speed: speedSliderValue, echo: echoSliderValue)
    }
}
