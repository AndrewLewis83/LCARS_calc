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
    
    @IBOutlet weak var _historyView: OperationHistory!
    
    //sound effects
    private var soundEffect: AVAudioPlayer?
    private let errorSoundPath = Bundle.main.path(forResource: "consolewarning.mp3", ofType:nil)!
    private let buttonSoundPath = Bundle.main.path(forResource: "computerbeep_5.mp3", ofType:nil)!
    private let alertSoundPath = Bundle.main.path(forResource: "computerbeep_13.mp3", ofType:nil)!

    //variables
    private var _hasDecimal = false
    private var _mainValue: Double = 0
    private var _secondaryValue: Double = 0
    private var _currentOperation = CurrentOperation.addition
    private var _typingInProgress = false
    private enum CurrentOperation {
        
        case addition, subtraction, multiplication, division
        
        func simpleDescription() -> String {
            switch self {
            case .addition:
                return "addition"
            case .subtraction:
                return "discrete"
            case .multiplication:
                return "multiplication"
            case .division:
                return "division"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainReadout.text = "0.0"
        secondaryReadout.text = "Enter value"
        configureUI()
        loadUserDefaults()
        loadHistoryView()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        tipButton.setTitle(String(Settings.getPercentTip()) + "%", for: .normal)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            adaptForCurrentSizeClass()

        }else{
            _historyView?.isHidden = true
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        adaptForCurrentSizeClass()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        adaptForCurrentSizeClass()
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
            _historyView?.isHidden = true
        } else if traitCollection.horizontalSizeClass == .regular {
            // load wide view
            _historyView?.isHidden = false
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        guard let viewControllers = navigationController?.viewControllers,
            let index = viewControllers.index(of: self) else { return }
        navigationController?.viewControllers.remove(at: index)
    }
    
    func loadUserDefaults(){
        
        Settings.setMuteSetting(newSetting: UserDefaults.standard.bool(forKey: "muteSetting"))
        Settings.setPercentTip(newTip: UserDefaults.standard.integer(forKey: "tipSetting"))
    }
    
    func loadHistoryView(){
        
        _historyView?.historyDelegate = self
        
    }
    
    @IBAction func numberButtonPressed(_ sender: Any) {
        
        if _typingInProgress == false {
            mainReadout.text = ""
            secondaryReadout.text = ""
            _typingInProgress = true
        }
        
        if (sender as AnyObject).tag >= 0 && (sender as AnyObject).tag < 10 {
            if mainReadout.text! == "0" && (sender as AnyObject).tag == 0 {
                mainReadout.text! = "0"
            }else{
                if mainReadout.text! == "0"{
                    mainReadout.text = String((sender as AnyObject).tag)
                }else{
                    mainReadout.text = mainReadout.text! + String((sender as AnyObject).tag)

                }
            }
            
            if mainReadout.text != nil {
                _mainValue = Double(mainReadout.text!)!
            }
        }
        
        if (sender as AnyObject).tag == 10 {
            
            if _hasDecimal == false {
                mainReadout.text = mainReadout.text! + "."
                _hasDecimal = true
            }else{
                secondaryReadout.text = "Invalid operation"
                playSound(soundEffectName: "errorSound")
            }
        }
        
        playSound(soundEffectName: "buttonSound")
    }
    
    @IBAction func functionButtonPressed(_ sender: Any) {
        
        switch ((sender as AnyObject).tag) {
            
        case 11: //division
            playSound(soundEffectName: "buttonSound")
            _currentOperation = CurrentOperation.division
            checkProgress()
        case 12://multiplication
            playSound(soundEffectName: "buttonSound")
            _currentOperation = CurrentOperation.multiplication
            checkProgress()
        case 13://subtraction
            playSound(soundEffectName: "buttonSound")
            _currentOperation = CurrentOperation.subtraction
            checkProgress()
        case 14://addition
            playSound(soundEffectName: "buttonSound")
            _currentOperation = CurrentOperation.addition
            checkProgress()
        case 15: //%20
            if _mainValue == 0.0 && _secondaryValue == 0{
                // play error sound and display error message.
                secondaryReadout.text = "Invalid operation"
                playSound(soundEffectName: "errorSound")
            } else if _secondaryValue == 0.0 {
                _secondaryValue = _mainValue
            }
            
            if _secondaryValue != 0 {
                var historyText = ""
                let tip = _secondaryValue * (Double(Settings.getPercentTip()) * 0.01)
                mainReadout.text = " Tip = $" + String(format: "%.2f", tip)
                secondaryReadout.text = "$" + String(format: "%.2f", _secondaryValue) + " + $" + String(format: "%.2f", tip) + " = $" + String(format: "%.2f", _secondaryValue+tip)
                historyText = "\(secondaryReadout.text ?? "")"
                if historyText != "Value copied to clipboard"{
                    _historyView?.operationHistory.append(historyText)
                }
                _historyView?.tableView.reloadData()
                _secondaryValue = tip
                playSound(soundEffectName: "buttonSound")
    
            }
            _hasDecimal = false
        case 16: //equals
            
            performOperation()
            playSound(soundEffectName: "buttonSound")
            _hasDecimal = false
            
        case 17://copies secondaryValue to clipboard
            
            playSound(soundEffectName: "alertSound")
            
            if _secondaryValue == 0 {
                UIPasteboard.general.string = String(_mainValue)
            } else {
                UIPasteboard.general.string = String(_secondaryValue)
            }
            
            secondaryReadout.text = "Value copied to clipboard"
            _hasDecimal = false
            
        case 18: // Clear
            
            playSound(soundEffectName: "buttonSound")
            mainReadout.text = "0.0"
            secondaryReadout.text = "Enter value"
            _hasDecimal = false
            _mainValue = 0
            _secondaryValue = 0
        case 19: // Negative/positive
            
            var historyText: String = ""
            playSound(soundEffectName: "buttonSound")
            if _mainValue != 0 {
                _mainValue = _mainValue * -1
                 mainReadout.text = String(_mainValue)
            }else{
                _secondaryValue = _secondaryValue * -1
                mainReadout.text = String(_secondaryValue)
                historyText = historyText + "\(mainReadout.text ?? "")"
                _historyView?.operationHistory.append(historyText)
                _historyView?.tableView.reloadData()
            }
            
        case 20: //backspace
            playSound(soundEffectName: "buttonSound")
            print("backspace button pressed")
            
            var mainReadoutString: String = mainReadout.text ?? ""
            _mainValue = Double(mainReadoutString) ?? 0.0
            
            if mainReadoutString.contains("Tip") == true {
                
                mainReadoutString = String(format: "%.2f", _secondaryValue)
                mainReadout.text = mainReadoutString
                _mainValue = Double(mainReadoutString) ?? 0.0
                _secondaryValue = 0.0
                mainReadout.text = String(_mainValue)
                mainReadoutString = mainReadout.text ?? ""
                secondaryReadout.text = ""
                
            }
            
            if _mainValue != 0 {
                
                mainReadoutString.removeLast()
                _mainValue = Double(mainReadoutString) ?? 0.0
                mainReadout.text = mainReadoutString
                if mainReadout.text == "" || mainReadout.text == "-" {
                    _mainValue = 0.0
                    mainReadout.text = "0.0"
                }
                
                secondaryReadout.text = ""
            }else{
                
                playSound(soundEffectName: "errorSound")
                secondaryReadout.text = "Invalid operation"
            }

        default:
            break
        }
        
        _typingInProgress = false
    }
    
    func checkProgress(){
        
        _hasDecimal = false
        if _secondaryValue == 0 {
            _secondaryValue = _mainValue
        } else if _mainValue != 0 {
            performOperation()
        }
    }
    
    func performOperation(){
        
        var finalValue:Double = 0
        var operationSymbol = ""
        
        switch(_currentOperation){
            
        case CurrentOperation.division:
            if _mainValue == 0 {
                playSound(soundEffectName: "errorSound")
                secondaryReadout.text = "Invalid operation: cannot divide by zero."
            }else{
                finalValue = _secondaryValue/_mainValue
                operationSymbol = "/"
            }
            
        case CurrentOperation.multiplication:
            finalValue = _mainValue*_secondaryValue
            operationSymbol = "X"
        case CurrentOperation.subtraction:
            finalValue = _secondaryValue-_mainValue
            operationSymbol = "-"
        case CurrentOperation.addition:
            finalValue = _mainValue+_secondaryValue
            operationSymbol = "+"
        }
        
        mainReadout.text = String(format: "%.3f", finalValue)
        if _mainValue != 0{
            var historyText: String = ""
            secondaryReadout.text = "\(String(format: "%.3f", _secondaryValue)) \(operationSymbol) \(String(format: "%.3f", _mainValue))"
            historyText = historyText + "\(String(format: "%.3f", _secondaryValue)) \(operationSymbol) \(String(format: "%.3f", _mainValue)) = \(String(format: "%.3f", finalValue))"
            
            if historyText != "Value copied to clipboard"{
                _historyView?.operationHistory.append(historyText)
            }
            
            _historyView?.tableView.reloadData()
        }
        _secondaryValue = finalValue
        _mainValue = 0
        _typingInProgress = false

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
    
    
    func playSound(soundEffectName: String){
        
        if Settings.getMuteSetting() == false {
        
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

extension iPadMainVC: HistoryDelegate {
    
    func didTapCell(value: String) {
        
        mainReadout.text = value
        if let copiedValue = Double(mainReadout.text ?? ""){
            _mainValue = copiedValue
            secondaryReadout.text = "Value copied."
            _secondaryValue = 0
            playSound(soundEffectName: "alertSound")
        }else{
            secondaryReadout.text = "Could not copy value."
            playSound(soundEffectName: "errorSound")
        }
        
        
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



