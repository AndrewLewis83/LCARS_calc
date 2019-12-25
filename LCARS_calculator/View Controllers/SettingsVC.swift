//
//  SettingsVC.swift
//  LCARS_calculator
//
//  Created by Andrew Lewis on 5/24/19.
//  Copyright © 2019 Andrew Lewis. All rights reserved.
//

import UIKit
import AVFoundation

class SettingsVC: UIViewController {
    
    @IBOutlet weak var muteButton: UIButton!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    
    //sound effects
    private var soundEffect: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipSlider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
        tipLabel.text = String(Settings.getPercentTip()) + "% tip"
        tipSlider.setValue(Float(Settings.getPercentTip()), animated: false)
        
        if (Settings.getMuteSetting() == false){
            muteButton.setBackgroundImage(UIImage(named: "LCARS_mute_button.png"), for: .normal)
            muteButton.setTitle(NSLocalizedString("mute audio", comment: ""), for: UIControl.State.normal)
        }else{
            muteButton.setBackgroundImage(UIImage(named: "LCARS_mute_button_2.png"), for: .normal)
            muteButton.setTitle(NSLocalizedString("unmute audio", comment: ""), for: UIControl.State.normal)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        guard let viewControllers = navigationController?.viewControllers,
            let index = viewControllers.index(of: self) else { return }
        navigationController?.viewControllers.remove(at: index)
    }
    
    @IBAction func muteButtonPressed(_ sender: Any) {
        
        playSound()
        
        if (Settings.getMuteSetting() == false){
            Settings.setMuteSetting(newSetting: true)
            muteButton.setBackgroundImage(UIImage(named: "LCARS_mute_button_2.png"), for: .normal)
            muteButton.setTitle(NSLocalizedString("unmute audio", comment: ""), for: UIControl.State.normal)
        }else{
            Settings.setMuteSetting(newSetting: false)
            muteButton.setBackgroundImage(UIImage(named: "LCARS_mute_button.png"), for: .normal)
            muteButton.setTitle(NSLocalizedString("mute audio", comment: ""), for: UIControl.State.normal)
        }
        
        saveSettings() // if you call when the return button is pressed, it won't save in time. It probably needs a completion handler or something. Not a big deal here, though. 
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
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        tipLabel.text = String(Int(sender.value)) + "% tip"
        Settings.setPercentTip(newTip: Int(sender.value))
        saveSettings()
    }
    
    
    func saveSettings(){
        UserDefaults.standard.set(Settings.getMuteSetting(), forKey: "muteSetting")
        UserDefaults.standard.set(Settings.getPercentTip(), forKey: "tipSetting")
    }
}
