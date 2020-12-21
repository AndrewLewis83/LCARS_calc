//
//  iPodTouchSettings.swift
//  LCARS_calculator
//
//  Created by Andrew Lewis on 12/21/20.
//  Copyright © 2020 Andrew Lewis. All rights reserved.
//

import UIKit
import AVFoundation

class iPodTouchSettings: UIViewController {

    @IBOutlet weak var muteButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var returnButton: UIButton!
    
    //sound effects
    private var soundEffect: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        muteButton.layer.cornerRadius = muteButton.frame.height/2
        infoButton.layer.cornerRadius = infoButton.frame.height/2
        infoButton.backgroundColor = buttonColorTwo
        
        if (Settings.getMuteSetting() == false){
            muteButton.backgroundColor = buttonColorFive
            muteButton.setTitle(NSLocalizedString("mute audio", comment: ""), for: UIControl.State.normal)
        }else{
            muteButton.backgroundColor = UIColor.red
            muteButton.setTitle(NSLocalizedString("unmute audio", comment: ""), for: UIControl.State.normal)
        }
    }
    
    @IBAction func muteButtonPressed(_ sender: Any) {
        
        playSound()
        
        if (Settings.getMuteSetting() == false){
            Settings.setMuteSetting(newSetting: true)
            muteButton.backgroundColor = UIColor.red
            muteButton.setTitle(NSLocalizedString("unmute audio", comment: ""), for: UIControl.State.normal)
        }else{
            Settings.setMuteSetting(newSetting: false)
            muteButton.backgroundColor = buttonColorFive
            muteButton.setTitle(NSLocalizedString("mute audio", comment: ""), for: UIControl.State.normal)
        }
        
        saveSettings() // if you call when the return button is pressed, it won't save in time. It probably needs a completion handler or something. Not a big deal here, though.
    }
    
    @IBAction func infoButtonPressed(_ sender: Any) {
        
        playSound()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.performSegue(withIdentifier: "showInfoScreen", sender: nil)
        }
    }
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        
        playSound()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    func playSound() {
        
        if Settings.getMuteSetting() == false {
            
            let buttonSoundPath = Bundle.main.path(forResource: "computerbeep_5.mp3", ofType:nil)!
            let url = URL(fileURLWithPath: buttonSoundPath)
            
            do {
                soundEffect = try AVAudioPlayer(contentsOf: url)
                soundEffect?.play()
            } catch {
                // couldn't load sound file
                print("Couldn't load sound file in playSound()")
            }
        }
    }
    
    func saveSettings(){
        UserDefaults.standard.set(Settings.getMuteSetting(), forKey: "muteSetting")
    }
}
