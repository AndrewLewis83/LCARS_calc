//
//  ViewController.swift
//  LCARS_calculator
//
//  Created by Andrew Lewis on 2/23/19.
//  Copyright © 2019 Andrew Lewis. All rights reserved.
//

import UIKit
import AVFoundation

class iPadMainVC: UIViewController {
    
    @IBOutlet weak var readoutBackgroundView: UIView!
    @IBOutlet weak var readoutBlackBackgroundPanel: UIView!
    
    @IBOutlet weak var mainPanelBackground: UIView!
    @IBOutlet weak var mainPanelBlackBackground: UIView!
  
    
    @IBOutlet weak var controlButtonsStackView: UIStackView!
    @IBOutlet weak var extraButtonsStackView: UIStackView!
    
    @IBOutlet weak var controlPanelStackView: UIStackView!
    @IBOutlet weak var starfleetEmblem: UIImageView!
    @IBOutlet weak var starfleetLabel: UILabel!
    @IBOutlet weak var unitedFederationOfPlanetsLabel: UILabel!
    @IBOutlet weak var spacerView: UIView!
    
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
    
    @IBOutlet weak var historyView: OperationHistory!
    
    private var soundEffect: AVAudioPlayer?
    private var calculator: AnotherCalc!
    
    private var iPadMini: Bool {
        return UIDevice.modelName == "iPad mini" || UIDevice.modelName == "iPad mini 2" || UIDevice.modelName == "iPad mini 3" || UIDevice.modelName == "iPad mini 4" || UIDevice.modelName == "iPad mini (5th generation)" || UIDevice.modelName == "iPad mini (6th generation)"
    }
    
    private var iPadMini6: Bool {
        return UIDevice.modelName == "iPad mini (6th generation)" || UIDevice.modelName == "Simulator iPad mini (6th generation)"
    }
    
    private var iPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculator = AnotherCalc(recordHistory: false) // set to false because OperationHistory.swift isn't adapted to use it. Yet. Maybe.
        mainReadout.text = calculator.primaryReadout
        secondaryReadout.text = calculator.secondaryReadout
        configureUI()
        loadHistoryView()
        adaptForOrientation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        tipButton.setTitle(String(Settings.tipSetting) + "%", for: .normal)
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        adaptForCurrentSizeClass()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        adaptForOrientation()
        adaptForCurrentSizeClass()
    }
    
    func adaptForOrientation() {
        if UIDevice.current.orientation.isLandscape {
            
        
            if iPadMini6 {
                extraButtonsStackView.isHidden = false
                controlButtonsStackView.isHidden = true
            }
            starfleetEmblem.isHidden = true
            starfleetLabel.isHidden = true
            unitedFederationOfPlanetsLabel.isHidden = true
            spacerView.isHidden = true
            
        } else {
            
            if iPadMini6 {
                extraButtonsStackView.isHidden = true
                controlButtonsStackView.isHidden = false
            }
            starfleetEmblem.isHidden = false
            starfleetLabel.isHidden = false
            unitedFederationOfPlanetsLabel.isHidden = false
            spacerView.isHidden = false
        }
    }
    
    func configureUI(){
        
        one_button.layer.cornerRadius = one_button.frame.height/2
        one_button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        one_button.backgroundColor = buttonColorOne
        two_button.backgroundColor = buttonColorTwo
        three_button.backgroundColor = buttonColorThree
        four_button.layer.cornerRadius = one_button.frame.height/2
        four_button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        four_button.backgroundColor = buttonColorFour
        five_button.backgroundColor = buttonColorOne
        six_button.backgroundColor = buttonColorTwo
        seven_button.layer.cornerRadius = one_button.frame.height/2
        seven_button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        seven_button.backgroundColor = buttonColorThree
        eight_button.backgroundColor = buttonColorFour
        nine_button.backgroundColor = buttonColorOne
        clear_button.layer.cornerRadius = one_button.frame.height/2
        clear_button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        zero_button.backgroundColor = buttonColorTwo
        backspaceButton.layer.cornerRadius = one_button.frame.height/2
        backspaceButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        multiplicationButton.layer.cornerRadius = one_button.frame.height/2
        multiplicationButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        division_button.layer.cornerRadius = one_button.frame.height/2
        division_button.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        subtractionButton.layer.cornerRadius = one_button.frame.height/2
        subtractionButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        additionButton.layer.cornerRadius = one_button.frame.height/2
        additionButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        tipButton.layer.cornerRadius = one_button.frame.height/2
        tipButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        
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
    
    func adaptForCurrentSizeClass(){
        
        if traitCollection.horizontalSizeClass == .compact {
            // load slim view
            historyView?.isHidden = true
        } else if traitCollection.horizontalSizeClass == .regular {
            // load wide view
            historyView?.isHidden = false
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        guard let viewControllers = navigationController?.viewControllers,
            let index = viewControllers.index(of: self) else { return }
        navigationController?.viewControllers.remove(at: index)
    }
    
    func loadHistoryView(){
        
        historyView?.historyDelegate = self
        
    }
    
    @IBAction func decimalButtonPressed(_ sender: Any) {
        
        if calculator.addDecimal() {
            playSound(soundEffectName: "buttonSound")
        } else {
            signalError("number already contains decimal")
        }
        
        mainReadout.text = calculator.primaryReadout
    }
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        
        if calculator.addNewDigit(digit: sender.tag) {
            playSound(soundEffectName: "buttonSound")
            mainReadout.text = calculator.primaryReadout
        } else {
            signalError()
        }
    }
    
    // TODO: each one of these called a function that would update the history
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
    
        case 15: //%20
            let convertedTip = Double(Settings.tipSetting)/100
            
            if calculator.calculateTip(convertedTip) {
                // play error sound and display error message.
                mainReadout.text = calculator.primaryReadout
                secondaryReadout.text = calculator.secondaryReadout
                playSound(soundEffectName: "buttonSound")
                historyView.addValue(value: calculator.secondaryReadout)
                
            } else {
                signalError()
            }
            
        case 16: //equals
            
            if calculator.equals() {
                playSound(soundEffectName: "buttonSound")
            } else {
                signalError()
            }
            
            mainReadout.text = calculator.primaryReadout
            secondaryReadout.text = calculator.secondaryReadout
            historyView.addValue(value: calculator.secondaryReadout)
            
        case 17://copies secondaryValue to clipboard
            
            playSound(soundEffectName: "alertSound")
            UIPasteboard.general.string = calculator.primaryReadout
            secondaryReadout.text = "Value copied to clipboard"
            
        case 18: // Clear
            
            if calculator.clear() {
                playSound(soundEffectName: "buttonSound")
            } else {
                signalError()
            }

            mainReadout.text = calculator.primaryReadout
            secondaryReadout.text = calculator.secondaryReadout
            
        case 19: // Negative/positive
            
            if calculator.negative() {
                playSound(soundEffectName: "buttonSound")
            } else {
                signalError()
            }

            mainReadout.text = calculator.primaryReadout
            secondaryReadout.text = calculator.secondaryReadout
            
        case 20: //backspace
            
            if calculator.backSpace() {
                playSound(soundEffectName: "buttonSound")
            } else {
                signalError()
            }
            
            mainReadout.text = calculator.primaryReadout
            secondaryReadout.text = calculator.secondaryReadout

        default:
            break
        }
    }
    
    @IBAction func infoButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "showInfoScreen", sender: nil)
    }
    
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        //placeholder for possible future functionality
        playSound(soundEffectName: "buttonSound")
        performSegue(withIdentifier: "showSettings", sender: nil)
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
    
    func signalError(_ errorMessage: String = "Invalid operation"){
        secondaryReadout.text = errorMessage
        playSound(soundEffectName: "errorSound")
    }

}

extension iPadMainVC: HistoryDelegate {
    
    func didTapCell(value: String) {
    
        calculator.clear()
        calculator.primaryReadout = value
        mainReadout.text = calculator.primaryReadout
        secondaryReadout.text = calculator.secondaryReadout

    }
}

extension UIView {
    
    func pushTransition(_ duration:CFTimeInterval) {
        
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype.fromRight
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.push.rawValue)
    }
}



