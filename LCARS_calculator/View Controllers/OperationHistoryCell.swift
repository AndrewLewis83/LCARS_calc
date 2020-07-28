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
    
    class func createCell() -> OperationHistoryCell {
        let nib = UINib(nibName: "OperationHistoryCell", bundle: nil)
        let cell = (nib.instantiate(withOwner: self, options: nil).last as? OperationHistoryCell)!
        cell.backgroundColor = .black
        return cell
    }
    
    func setLabel(operationText: String){
        
        operationLabel.textColor = textColorTwo
        operationLabel.text = operationText
    }
    
}
