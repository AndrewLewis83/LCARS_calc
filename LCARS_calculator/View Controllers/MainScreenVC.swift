//
//  ViewController.swift
//  LCARS_calculator
//
//  Created by Andrew Lewis on 2/23/19.
//  Copyright © 2019 Andrew Lewis. All rights reserved.
//

import UIKit
import AVFoundation

class MainScreenVC: UIViewController {
  
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
    
    @IBOutlet weak var operationHistoryLabel: UILabel!

    //operation history tablview
    @IBOutlet weak var tableView: UITableView!
    var operationHistory: [String] = [String]()
    
    
    
    //sound effects
    private var soundEffect: AVAudioPlayer?
    private let errorSoundPath = Bundle.main.path(forResource: "consolewarning.mp3", ofType:nil)!
    private let buttonSoundPath = Bundle.main.path(forResource: "computerbeep_5.mp3", ofType:nil)!

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
        loadUserDefaults()
        tableView.delegate = self
        tableView.dataSource = self
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        tipButton.setTitle(String(Settings.getPercentTip()) + "%", for: .normal)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            adaptForCurrentSizeClass()

        }else{
            operationHistoryLabel.isHidden = true
            tableView.isHidden = true
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        adaptForCurrentSizeClass()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        adaptForCurrentSizeClass()
    }
    
    func adaptForCurrentSizeClass(){
        
        if traitCollection.horizontalSizeClass == .compact {
            // load slim view
            operationHistoryLabel.isHidden = true
            tableView.isHidden = true
        } else if traitCollection.horizontalSizeClass == .regular {
            // load wide view
            operationHistoryLabel.isHidden = false
            tableView.isHidden = false
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
                _mainValue = Double(mainReadout.text!) as! Double
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
                historyText = historyText + "\(mainReadout.text ?? "")"
                secondaryReadout.text = "$" + String(format: "%.2f", _secondaryValue) + " + $" + String(format: "%.2f", tip) + " = $" + String(format: "%.2f", _secondaryValue+tip)
                historyText = historyText + "\(secondaryReadout.text ?? "")"
                operationHistory.append(historyText)
                tableView.reloadData()
                _secondaryValue = tip
                playSound(soundEffectName: "buttonSound")
    
            }
            _hasDecimal = false
        case 16: //equals
            
            performOperation()
            playSound(soundEffectName: "buttonSound")
            _hasDecimal = false
            
        case 17://copies secondaryValue to clipboard
            
            var historyText = ""
            playSound(soundEffectName: "buttonSound")
            
            if _secondaryValue == 0 {
            	UIPasteboard.general.string = String(_mainValue)
            } else {
            	UIPasteboard.general.string = String(_secondaryValue)
            }
            
            secondaryReadout.text = "Value copied to clipboard."
            historyText = historyText + "\(secondaryReadout.text ?? "")"
            operationHistory.append(historyText)
            tableView.reloadData()
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
                operationHistory.append(historyText)
                tableView.reloadData()
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
        
        mainReadout.text = String(finalValue)
        if _mainValue != 0{
            var historyText: String = ""
            secondaryReadout.text = "(\(_secondaryValue) \(operationSymbol) \(_mainValue))"
            historyText = historyText + "\(_secondaryValue) \(operationSymbol) \(_mainValue) = \(finalValue)"
            operationHistory.append(historyText)
            tableView.reloadData()
        }
        _secondaryValue = finalValue
        _mainValue = 0
        _typingInProgress = false

    }
    
    @IBAction func infoButtonPressed(_ sender: Any) {
        playSound(soundEffectName: "buttonSound")

    }
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        //placeholder for possible future functionality
    }
    
    
    func playSound(soundEffectName: String){
        
        if Settings.getMuteSetting() == false {
        
            var url = URL(fileURLWithPath: errorSoundPath)
            
            switch (soundEffectName) {
            case "errorSound":
                url = URL(fileURLWithPath: errorSoundPath)
            case "buttonSound":
                url = URL(fileURLWithPath: buttonSoundPath)
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

extension MainScreenVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return operationHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "operationHistoryCell", for: indexPath) as? OperationHistoryCell{
            
            cell.setLabel(operationText: operationHistory[indexPath.row])
            
            return cell
            
        }else{
            return UITableViewCell()
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

