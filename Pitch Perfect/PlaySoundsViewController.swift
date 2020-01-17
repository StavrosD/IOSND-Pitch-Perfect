//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Dimopoulos Stavros tou Athanasiou on 17/1/20.
//  Copyright © 2020 Dimopoulos Stavros tou Athanasiou. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    // MARK: Declarations

    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!

    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
    arrangeIcons()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      
setupAudio()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        arrangeIcons()
    }
    // MARK: Arrange buttons
    func arrangeIcons(){
        let centerX:CGFloat = stopButton.center.x
              let centerY:CGFloat = stopButton.center.y
              let circleRadius:CGFloat = (min( self.view.frame.size.width,self.view.frame.height)/3)
              
              for i in 1...6{
                  var tmpButton  : UIButton
                  if i==6{ // get the first button. There are many items with tag == 0, I dont want to change the enum with the button tags and I do not want to change the tag for every other UI item so I just use this conditio to get the "snail" button
                      tmpButton = snailButton
                  }
                  else{ //
                      tmpButton = self.view.viewWithTag(i) as! UIButton
                  }
                  let angle = Double(i) * ( Double.pi / 3.0)
                  tmpButton.center.x = centerX + circleRadius * CGFloat(cos(angle))
                  tmpButton.center.y = centerY + circleRadius * CGFloat(sin(angle))
                tmpButton.frame.size.width=90
                tmpButton.frame.size.height=90
                
              }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: Actions

    @IBAction func playSoundForButton(_ sender: UIButton) {
       switch(ButtonType(rawValue: sender.tag)!) {
            case .slow:
                playSound(rate: 0.5)
            case .fast:
                playSound(rate: 1.5)
            case .chipmunk:
                playSound(pitch: 1000)
            case .vader:
                playSound(pitch: -1000)
            case .echo:
                playSound(echo: true)
            case .reverb:
                playSound(reverb: true)
            }

            configureUI(.playing)
        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)

    }

    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
        
    }
}
