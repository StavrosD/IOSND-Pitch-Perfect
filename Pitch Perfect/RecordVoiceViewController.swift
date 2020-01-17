//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Dimopoulos Stavros tou Athanasiou on 16/1/20.
//  Copyright © 2020 Dimopoulos Stavros tou Athanasiou. All rights reserved.
//

import UIKit
import AVFoundation

class RecordVoiceViewController: UIViewController,AVAudioRecorderDelegate {
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    
    
    
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.isEnabled=false // I disable it because it is required by the rubric. There is no need to disable it, I hide it later.
        stopButton.isHidden=true  // The stop button should be enabled only during recording
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func recordAudio(_ sender: AnyObject) {
        recordingLabel.text = "Recording in progress"
        stopButton.isHidden = false
        stopButton.isEnabled = true
        recordButton.isHidden=true
        recordButton.isEnabled=false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    @IBAction func stopRecordingAudio(_ sender: AnyObject) {
        recordButton.isEnabled=true
        recordButton.isHidden=false
        stopButton.isEnabled=false
        stopButton.isHidden=true
        recordingLabel.text = "Tap to Record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else
        {
            print ("Finished recording")
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" as String	{
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recorderAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL =  recorderAudioURL
        }
    }
}




