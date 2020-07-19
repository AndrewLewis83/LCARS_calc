//
//  OperationHistoryCell.swift
//  LCARS_calculator
//
//  Created by Andrew Lewis on 7/19/20.
//  Copyright © 2020 Andrew Lewis. All rights reserved.
//

import UIKit

class OperationHistoryCell: UITableViewCell {
    
    @IBOutlet weak var operationLabel: UILabel!
    
    func setLabel(operationText: String){
        
        operationLabel.textColor = textColorTwo
        operationLabel.text = operationText
    }
    
}
