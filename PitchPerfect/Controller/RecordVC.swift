//
//  RecordVC.swift
//  PitchPerfect
//
//  Created by Matthias Wagner on 12.11.17.
//  Copyright © 2017 Michael Wagner. All rights reserved.
//

import UIKit
import AVFoundation

class RecordVC: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!

    var audioRecorder: AVAudioRecorder!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Prepare fpr segue")
        if segue.identifier == "stopRecording" {
            let playPitchVC = segue.destination as! PlayPitchVC
            let recordedAudioURL = sender as! URL
            print("URL in PlayVC: \(recordedAudioURL.absoluteString)")
            playPitchVC.recordedAudioURL = recordedAudioURL
        }
    }

    @IBAction func onRecord(_ sender: Any) {
        switchButton()
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath ?? "")
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)

        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    @IBAction func onStop(_ sender: Any) {
        switchButton()

        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }

    private func switchButton() {
        stopButton.isHidden = !stopButton.isHidden
        recordButton.isHidden = !recordButton.isHidden

        stopButton.isUserInteractionEnabled = !stopButton.isUserInteractionEnabled
        recordButton.isUserInteractionEnabled = !recordButton.isUserInteractionEnabled

        switch stopButton.isHidden {
        case true: recordLabel.text = "Tap to start recording"
        case false: recordLabel.text = "Recording in Progress"
        }
    }
}

// MARK: - AVAudioRecorderDelegate
extension RecordVC: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("finished recording")

        if flag {
            self.performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Recording was not successful")
        }
    }
}
