//
//  PlayPitchVC.swift
//  PitchPerfect
//
//  Created by Matthias Wagner on 12.11.17.
//  Copyright © 2017 Michael Wagner. All rights reserved.
//

import UIKit
import AVFoundation

class PlayPitchVC: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var pauseButton: UIButton!

    var recordedAudioURL: URL!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onFast(_ sender: Any) {

    }

    @IBAction func onSlow(_ sender: Any) {
    }

    @IBAction func onEcho(_ sender: Any) {
    }

    @IBAction func onReverb(_ sender: Any) {
    }

    @IBAction func onLowPitch(_ sender: Any) {
    }

    @IBAction func onHighPitch(_ sender: Any) {
    }

    @IBAction func onRecordNewSound(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func onPause(_ sender: Any) {

    }


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playPitchVC = segue.destination as! PlayPitchVC
            let recordedAudioURL = sender as! URL
            playPitchVC.recordedAudioURL = recordedAudioURL
        }
    }

}
