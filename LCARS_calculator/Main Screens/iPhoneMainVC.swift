//
//  ViewController.swift
//  LCARS_calculator
//
//  Created by Andrew Lewis on 2/23/19.
//  Copyright © 2019 Andrew Lewis. All rights reserved.
//

import UIKit
import AVFoundation
import SimpleCalcFramework

class iPhoneMainVC: UIViewController {
    
    @IBOutlet weak var readoutBackgroundView: UIView!
    @IBOutlet weak var readoutBlackBackgroundPanel: UIView!
    @IBOutlet weak var mainPanelBackground: UIView!
    @IBOutlet weak var mainPanelBlackBackground: UIView!
  
    // number buttons
    @IBOutlet weak var one_button: UIButton!
    @IBOutlet weak var two_button: UIButton!
    @IBOutlet weak var three_button: UIButton!
    @IBOutlet weak var four_button: UIButton!
    @IBOutlet weak var five_button: UIButton!
    @IBOutlet weak var six_button: UIButton!
    @IBOutlet weak var seven_button: UIButton!
    @IBOutlet weak var eight_button: UIButton!
    @IBOutlet weak var nine_button: UIButton!
    @IBOutlet weak var zero_button: UIButton!
    @IBOutlet weak var decimal_point_button: UIButton!
    @IBOutlet weak var clear_button: UIButton!
    @IBOutlet weak var backspaceButton: UIButton!
    
    // function buttons
    @IBOutlet weak var division_button: UIButton!
    @IBOutlet weak var multiplicationButton: UIButton!
    @IBOutlet weak var subtractionButton: UIButton!
    @IBOutlet weak var additionButton: UIButton!
    @IBOutlet weak var tipButton: UIButton!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var equalsButton: UIButton!
    @IBOutlet weak var negativePositiveButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var mainReadout: UILabel!
    @IBOutlet weak var secondaryReadout: UILabel!
    
    private var cornerRadius: CGFloat = 0
    private var spacing: CGFloat = 0
    @IBOutlet weak var mainStackViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet weak var firstRowStackView: UIStackView!
    @IBOutlet weak var secondRowStackView: UIStackView!
    @IBOutlet weak var thirdRowStackView: UIStackView!
    @IBOutlet weak var fourthRowStackView: UIStackView!
    @IBOutlet weak var fifthRowStackView: UIStackView!
    @IBOutlet weak var extraButtonsStackView: UIStackView!
    
    //sound effects
    private var soundEffect: AVAudioPlayer?

    //variables
    private var calculator: SimpleCalc!
    private var iPodTouch: Bool {
        return UIDevice.modelName == "iPod touch (5th generation)" || UIDevice.modelName == "iPod touch (6th generation)" || UIDevice.modelName == "iPod touch (7th generation)"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculator = SimpleCalc()
        mainReadout.text = "0.0"
        secondaryReadout.text = "Enter value"
        tipButton.setTitle(String(Settings.tipSetting) + "%", for: .normal)
        setModelConstraints(modelName: UIDevice.modelName)
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if iPodTouch == false {
            tipButton.setTitle(String(Settings.tipSetting) + "%", for: .normal)
        }
    }
    
    func setModelConstraints(modelName: String){

        if modelName == "iPhone 12 Pro Max" {
        
            cornerRadius = 40
            spacing = 8
            
        } else if modelName == "iPhone 12 mini" {

            cornerRadius = 35
            spacing = 4
            
        } else if modelName == "iPhone SE (2nd generation)" || modelName == "iPhone 7" || modelName == "iPhone 8" {
            
            cornerRadius = 30
            spacing = 4
            infoButton.isHidden = true
            copyButton.frame.size.height = 45
            settingsButton.frame.size.height = 45
            mainStackViewBottomConstraint.constant = spacing
            
        } else if iPodTouch {
            
            cornerRadius = 30
            spacing = 4
            infoButton.isHidden = true
            copyButton.isHidden = true
            settingsButton.isHidden = true
            if #available(iOS 13.0, *) {
                tipButton.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
            }
            tipButton.setTitle("", for: .normal)
            mainStackViewBottomConstraint.constant = spacing
            
        } else {
            
            cornerRadius = one_button.frame.height/2
            spacing = 8
        }
            
    }
    
    func configureUI(){
        
        one_button.layer.cornerRadius = cornerRadius
        one_button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        one_button.backgroundColor = buttonColorOne
        two_button.backgroundColor = buttonColorTwo
        three_button.backgroundColor = buttonColorThree
        four_button.layer.cornerRadius = cornerRadius
        four_button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        four_button.backgroundColor = buttonColorFour
        five_button.backgroundColor = buttonColorOne
        six_button.backgroundColor = buttonColorTwo
        seven_button.layer.cornerRadius = cornerRadius
        seven_button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        seven_button.backgroundColor = buttonColorThree
        eight_button.backgroundColor = buttonColorFour
        nine_button.backgroundColor = buttonColorOne
        clear_button.layer.cornerRadius = cornerRadius
        clear_button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        zero_button.backgroundColor = buttonColorTwo
        backspaceButton.layer.cornerRadius = cornerRadius
        backspaceButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        tipButton.layer.cornerRadius = cornerRadius
        tipButton.layer.maskedCorners = [.layerMaxXMaxYCorner]
        
        buttonsStackView.spacing = spacing
        firstRowStackView.spacing = spacing
        secondRowStackView.spacing = spacing
        thirdRowStackView.spacing = spacing
        fourthRowStackView.spacing = spacing
        fifthRowStackView.spacing = spacing
        extraButtonsStackView.spacing = spacing
        mainStackView.spacing = spacing
        
        readoutBackgroundView.layer.cornerRadius = 30
        readoutBackgroundView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        readoutBlackBackgroundPanel.layer.cornerRadius = 30
        readoutBlackBackgroundPanel.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        
        mainPanelBackground.layer.cornerRadius = 30
        mainPanelBackground.layer.maskedCorners = [.layerMinXMinYCorner]
        mainPanelBlackBackground.layer.cornerRadius = 30
        mainPanelBlackBackground.layer.maskedCorners = [.layerMinXMinYCorner]
        
        mainPanelBackground.backgroundColor = backgroundColorThree
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        guard let viewControllers = navigationController?.viewControllers,
            let index = viewControllers.index(of: self) else { return }
        navigationController?.viewControllers.remove(at: index)
    }
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        
        if calculator.addNewDigit(digit: sender.tag) {
            playSound(soundEffectName: "buttonSound")
            mainReadout.text = calculator.primaryReadoutValue
        } else {
            signalError()
        }
    }
    
    
    @IBAction func decimalButtonPressed(_ sender: Any) {
        
        if calculator.addDecimal() {
            playSound(soundEffectName: "buttonSound")
        } else {
            signalError()
        }
    }
    
    @IBAction func functionButtonPressed(_ sender: Any) {
        
        switch ((sender as AnyObject).tag) {
            
        case 11: //division
            if calculator.divide() {
                playSound(soundEffectName: "buttonSound")
            } else {
                signalError()
            }

        case 12://multiplication
            if calculator.times() {
                playSound(soundEffectName: "buttonSound")
            } else {
                signalError()
            }

        case 13://subtraction
            if calculator.minus() {
                playSound(soundEffectName: "buttonSound")
            } else {
                signalError()
            }
       
        case 14://addition
            if calculator.plus() {
                playSound(soundEffectName: "buttonSound")
            } else {
                signalError()
            }
    
        case 15: //%20 or settings on iPod touch
            
            if iPodTouch {
                
                performSegue(withIdentifier: "showiPodSettings", sender: nil)
                
            } else {
            
                let convertedTip = Double(Settings.tipSetting)/100
                
                if calculator.calculateTip(convertedTip) {
                    // play error sound and display error message.
                    mainReadout.text = calculator.primaryReadoutValue
                    secondaryReadout.text = calculator.secondaryReadoutValue
                    playSound(soundEffectName: "buttonSound")
                    
                } else {
                    signalError()
                }
            }
            
        case 16: //equals
            
            if calculator.equals() {
                playSound(soundEffectName: "buttonSound")
            } else {
                signalError()
            }
            
            mainReadout.text = calculator.primaryReadoutValue
            secondaryReadout.text = calculator.secondaryReadoutValue
            
        case 17://copies secondaryValue to clipboard
            
            playSound(soundEffectName: "alertSound")
            UIPasteboard.general.string = calculator.primaryReadoutValue
            secondaryReadout.text = "Value copied to clipboard"

        case 18: // Clear
            
            if calculator.clear() {
                playSound(soundEffectName: "buttonSound")
            } else {
                signalError()
            }

            mainReadout.text = calculator.primaryReadoutValue
            secondaryReadout.text = calculator.secondaryReadoutValue

        case 19: // Negative/positive
            
            if calculator.negative() {
                playSound(soundEffectName: "buttonSound")
            } else {
                signalError()
            }

            mainReadout.text = calculator.primaryReadoutValue
            secondaryReadout.text = calculator.secondaryReadoutValue
            
        case 20: //backspace
            
            if calculator.backSpace() {
                playSound(soundEffectName: "buttonSound")
            } else {
                signalError()
            }
            
            mainReadout.text = calculator.primaryReadoutValue
            secondaryReadout.text = calculator.secondaryReadoutValue
            
        default:
            break
        }
        
    }
    
    @IBAction func infoButtonPressed(_ sender: Any) {
        playSound(soundEffectName: "buttonSound")
        performSegue(withIdentifier: "showInfoScreen", sender: nil)
    }
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        //placeholder for possible future functionality
        playSound(soundEffectName: "buttonSound")
        performSegue(withIdentifier: "showSettings", sender: nil)
    }
    
    func signalError(){
        secondaryReadout.text = "Invalid operation"
        playSound(soundEffectName: "errorSound")
    }
    
    func playSound(soundEffectName: String){
        
        if Settings.muteSetting == false {
        
            var url = URL(fileURLWithPath: errorSoundPath)
            
            switch (soundEffectName) {
            case "errorSound":
                url = URL(fileURLWithPath: errorSoundPath)
            case "buttonSound":
                url = URL(fileURLWithPath: buttonSoundPath)
            case "alertSound":
                url = URL(fileURLWithPath: alertSoundPath)
            default:
                url = URL(fileURLWithPath: errorSoundPath)
            }
            
            do {
                soundEffect = try AVAudioPlayer(contentsOf: url)
                soundEffect?.play()
            } catch {
                // couldn't load sound file
                print("Couldn't load sound file in playSound()")
            }
        }
    }
}



