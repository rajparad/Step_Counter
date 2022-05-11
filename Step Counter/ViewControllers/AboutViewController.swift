//
//  AboutViewController.swift
//  Step Counter
//
//  Created by Sukhdev Banwait on 2022-04-03.
//

import UIKit
import AVFoundation

class AboutViewController: UIViewController, AVAudioPlayerDelegate {

    // create connections to storyboard elements
    @IBOutlet weak var slider: UISlider!
    var soundPlayer : AVAudioPlayer?

    // attach sound volume to slider value
    @IBAction func volumeDidChange(sender: UISlider) {
        soundPlayer?.volume = slider.value

    }

    
    // set everything up before view is fully rendered
    override func viewWillAppear(_ animated: Bool) {
        // retrieve the song url from the bundle
        let soundUrl = Bundle.main.path(forResource: "darkSong", ofType: "mp3")
        let url = URL(fileURLWithPath: soundUrl!)
        // configure sound player initialization
        soundPlayer = try! AVAudioPlayer.init(contentsOf: url)
        soundPlayer?.currentTime = 0
        soundPlayer?.volume = 0.5  // default setting
        soundPlayer?.numberOfLoops = -1
        soundPlayer?.play()  // play as soon as view is loaded
    }

    // disable sound if user leaves view
    override func viewDidDisappear(_ animated: Bool) {
        soundPlayer?.stop()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // attach the slider action to the volume change handler above
    slider.addTarget(self, action:#selector(volumeDidChange(sender:)), for: .valueChanged)

    }

}
