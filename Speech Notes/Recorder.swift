////
////  Recorder.swift
////  Speech Notes
////
////  Created by Richard Richard on 02/04/18.
////  Copyright © 2018 Richard Richard. All rights reserved.
////
//
//import UIKit
//import Speech
//
//class Recorder {
//    internal let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
//    internal var recognitionRequest:SFSpeechAudioBufferRecognitionRequest?
//    internal var recognitionTask:SFSpeechRecognitionTask?
//    internal let audioEngine = AVAudioEngine()
//    
//    var finalResult:String?
//    
//    internal var timer:Timer?
//    internal var volumeData:Float = 0
//    internal var frequency:Float = 0
//    
//    
//    var updateParentView: ((String)->())?
//    
//    init(frame: CGRect) {
//        self.startRecord()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//extension Recorder: SFSpeechRecognizerDelegate{
////    func toogleRecord() {
//        if audioEngine.isRunning {
//            stopRecord()
//            print("Stop Recording")
//        } else {
//            startRecord()
//            print("Start Recording")
//        }
//    }
//    
//    func stopRecord() {
//        DispatchQueue.main.async(execute: {() -> Void in
//            self.audioEngine.inputNode?.removeTap(onBus: AVAudioNodeBus(0))
//            self.audioEngine.inputNode?.reset()
//            self.audioEngine.stop()
//            self.recognitionRequest?.endAudio()
//            self.recognitionTask?.cancel()
//            self.recognitionTask = nil
//            self.recognitionRequest = nil
//        })
//    }
//    
//    func startRecord(){
//        wordResult = ""
//        finalResult = ""
//        if recognitionTask != nil {
//            recognitionTask?.cancel()
//            recognitionTask = nil
//        }
//        
//        let audioSession = AVAudioSession.sharedInstance()
//        do{
//            try audioSession.setCategory(AVAudioSessionCategoryRecord)
//            try audioSession.setMode(AVAudioSessionModeMeasurement)
//            try audioSession.setActive(true)
//        }catch{
//        }
//        
//        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
//        
//        guard let inputNode = audioEngine.inputNode else {
//            fatalError("Audio engine has no input node")
//        }
//        
//        guard let recognitionRequest = recognitionRequest else {
//            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
//        }
//        
//        recognitionRequest.shouldReportPartialResults = true
//        recognitionTask = self.speechRecognizer?.recognitionTask(with: recognitionRequest, delegate: self)
//        
//        var vol:Float = 0.0
//        var rep: Int = 0
//        var silence: Int = 0
//        var isSpoken = false
//        let recordingFormat = inputNode.outputFormat(forBus: 0)
//        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
//            self.recognitionRequest?.append(buffer)
//            
//            let dtaPtr = buffer.floatChannelData!
//            let dta = dtaPtr.pointee
//            let dtum = dta[Int(buffer.frameLength) - 1]
//            var freq = fabs(dtum) * 100.0
//            if freq > 1.3 {
//                isSpoken = true
//            }
//            if freq < 1{
//                vol = 1.0
//            }else if freq > 2.0{
//                vol = 2
//            }else{
//                vol = freq
//            }
//            print(freq)
//            self.volumeData = vol
//            self.frequency = freq
//            
//            if isSpoken == true {
//                if freq<0.5 {
//                    rep += 1
//                } else {
//                    rep = 0
//                }
//            } else {
//                silence += 1
//            }
//            
//            if rep == 10 {
//                self.recognitionTask?.finish()
//                self.stopRecord()
//            }
//            
//            if silence == 20 {
//                if let rv = self.updateParentView {
//                    rv("")
//                }
//                self.recognitionTask?.cancel()
//                self.stopRecord()
//            }
//        }
//        timer?.invalidate()
//        if isSpoken {
//            self.timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.updatePulse), userInfo: nil, repeats: true)
//        } else {
//            self.timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.updatePulse), userInfo: nil, repeats: true)
//        }
//        
//        audioEngine.prepare()
//        
//        do {
//            try audioEngine.start()
//        } catch {
//            print("audioEngine couldn't start because of an error.")
//        }
//    }
//    
//    func speechRecognitionTask(_ task: SFSpeechRecognitionTask, didFinishRecognition recognitionResult: SFSpeechRecognitionResult) {
//        finalResult = recognitionResult.bestTranscription.formattedString
//        if let rv = updateParentView  {
//            rv(finalResult!)
//        }
//    }
//    
//    func updatePulse() {
//        if frequency < 0.2 {
//            animatePulsatingCircle(val: 0.2)
//        } else {
//            animatePulsatingCircle(val: frequency)
//        }
//    }
//}

