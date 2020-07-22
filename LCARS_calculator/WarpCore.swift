//
//  WarpCore.swift
//  LCARS_calculator
//
//  Created by Andrew Lewis on 7/20/20.
//  Copyright © 2020 Andrew Lewis. All rights reserved.
//

import UIKit

class WarpCore: UIView {

    @IBOutlet weak var backgroundView: WarpCore!
    
    // Warp core outlets
    @IBOutlet weak var warpCoreStackView: UIStackView!
    @IBOutlet weak var topCap: UIImageView!
    @IBOutlet weak var warpSectionOne: UIImageView!
    @IBOutlet weak var warpSectionTwo: UIImageView!
    @IBOutlet weak var warpSectionThree: UIImageView!
    @IBOutlet weak var warpSectionFour: UIImageView!
    @IBOutlet weak var warpSectionFive: UIImageView!
    @IBOutlet weak var centerSection: UIImageView!
    @IBOutlet weak var warpSectionSix: UIImageView!
    @IBOutlet weak var warpSectionSeven: UIImageView!
    @IBOutlet weak var warpSectionEight: UIImageView!
    @IBOutlet weak var warpSectionNine: UIImageView!
    @IBOutlet weak var warpSectionTen: UIImageView!
    @IBOutlet weak var bottomCap: UIImageView!
    
    private var timer = Timer()
    var sequence = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        
        Bundle.main.loadNibNamed("WarpCore", owner: self, options: nil)
        addSubview(backgroundView)
        backgroundView.frame = self.bounds
        backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bottomCap.transform = bottomCap.transform.rotated(by: .pi)
        
        backgroundView.layer.cornerRadius = 30
        backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    
    func configureIPadView(){
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(counter), userInfo: nil, repeats: true)
        
        warpSectionOne.image = UIImage(named: "warp_core_section.png")?.withRenderingMode(.alwaysTemplate)
        warpSectionOne.tintColor = warpColorOne
        warpSectionTwo.image = UIImage(named: "warp_core_section.png")?.withRenderingMode(.alwaysTemplate)
        warpSectionTwo.tintColor = warpColorOne
        warpSectionThree.image = UIImage(named: "warp_core_section.png")?.withRenderingMode(.alwaysTemplate)
        warpSectionThree.tintColor = warpColorOne
        warpSectionFour.image = UIImage(named: "warp_core_section.png")?.withRenderingMode(.alwaysTemplate)
        warpSectionFour.tintColor = warpColorOne
        warpSectionFive.image = UIImage(named: "warp_core_section.png")?.withRenderingMode(.alwaysTemplate)
        warpSectionFive.tintColor = warpColorOne
        warpSectionSix.image = UIImage(named: "warp_core_section.png")?.withRenderingMode(.alwaysTemplate)
        warpSectionSix.tintColor = warpColorOne
        warpSectionSeven.image = UIImage(named: "warp_core_section.png")?.withRenderingMode(.alwaysTemplate)
        warpSectionSeven.tintColor = warpColorOne
        warpSectionEight.image = UIImage(named: "warp_core_section.png")?.withRenderingMode(.alwaysTemplate)
        warpSectionEight.tintColor = warpColorOne
        warpSectionNine.image = UIImage(named: "warp_core_section.png")?.withRenderingMode(.alwaysTemplate)
        warpSectionNine.tintColor = warpColorOne
        warpSectionTen.image = UIImage(named: "warp_core_section.png")?.withRenderingMode(.alwaysTemplate)
        warpSectionTen.tintColor = warpColorOne
        
        warpSectionOne.tintColor = warpColorOne
           
    }
    
    @objc func counter(){
        
        sequence += 1
        
        if sequence > 3 {
            sequence = 0
        }
        
        if sequence == 0 {
            warpSectionOne.tintColor = warpColorOne
            warpSectionTwo.tintColor = warpColorTwo
            warpSectionThree.tintColor = warpColorThree
            warpSectionFour.tintColor = warpColorTwo
            warpSectionFive.tintColor = warpColorOne
            warpSectionSix.tintColor = warpColorTwo
            warpSectionSeven.tintColor = warpColorThree
            warpSectionEight.tintColor = warpColorTwo
            warpSectionNine.tintColor = warpColorOne
            warpSectionTen.tintColor = warpColorTwo
        }else if sequence == 1 {
            warpSectionOne.tintColor = warpColorTwo
            warpSectionTwo.tintColor = warpColorThree
            warpSectionThree.tintColor = warpColorTwo
            warpSectionFour.tintColor = warpColorOne
            warpSectionFive.tintColor = warpColorTwo
            warpSectionSix.tintColor = warpColorThree
            warpSectionSeven.tintColor = warpColorTwo
            warpSectionEight.tintColor = warpColorOne
            warpSectionNine.tintColor = warpColorTwo
            warpSectionTen.tintColor = warpColorThree
        }else if sequence == 2 {
            warpSectionOne.tintColor = warpColorThree
            warpSectionTwo.tintColor = warpColorTwo
            warpSectionThree.tintColor = warpColorOne
            warpSectionFour.tintColor = warpColorTwo
            warpSectionFive.tintColor = warpColorThree
            warpSectionSix.tintColor = warpColorTwo
            warpSectionSeven.tintColor = warpColorOne
            warpSectionEight.tintColor = warpColorTwo
            warpSectionNine.tintColor = warpColorThree
            warpSectionTen.tintColor = warpColorTwo
        }else if sequence == 3 {
            warpSectionOne.tintColor = warpColorTwo
            warpSectionTwo.tintColor = warpColorThree
            warpSectionThree.tintColor = warpColorTwo
            warpSectionFour.tintColor = warpColorOne
            warpSectionFive.tintColor = warpColorTwo
            warpSectionSix.tintColor = warpColorThree
            warpSectionSeven.tintColor = warpColorTwo
            warpSectionEight.tintColor = warpColorOne
            warpSectionNine.tintColor = warpColorTwo
            warpSectionTen.tintColor = warpColorThree
        }
        
    }
}
