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
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Prepare fpr segue")
        if segue.identifier == "stopRecording" {
            let playPitchVC = segue.destination as! PlaySoundVC
            let recordedAudioURL = sender as! URL
            print("URL in PlayVC: \(recordedAudioURL.absoluteString)")
            playPitchVC.recordedAudioURL = recordedAudioURL
        }
    }

    // MARK: - Record/Stop Function
    @IBAction func onRecord(_ sender: Any) {
        configureUI(true)
        
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
        configureUI(false)

        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }

    // MARK: - UI Configuration Function
    private func configureUI(_ recordState: Bool) {
        stopButton.isHidden = !recordState
        recordButton.isHidden = recordState

        stopButton.isUserInteractionEnabled = recordState
        recordButton.isUserInteractionEnabled = !recordState

        switch recordState {
        case false: recordLabel.text = "Tap to start recording"
        case true: recordLabel.text = "Recording in Progress"
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
