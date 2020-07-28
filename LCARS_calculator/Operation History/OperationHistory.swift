//
//  OperationHistory.swift
//  LCARS_calculator
//
//  Created by Andrew Lewis on 7/23/20.
//  Copyright © 2020 Andrew Lewis. All rights reserved.
//

import UIKit

protocol HistoryDelegate {
    func didTapCell(value: String)
}

class OperationHistory: UIView {
    
    @IBOutlet weak var operationHistoryLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var operationHistory: [String] = [String]()
    var historyDelegate: HistoryDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        
        Bundle.main.loadNibNamed("OperationHistory", owner: self, options: nil)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        setLayout()
    }
    
    func setLayout(){
        
        addSubview(operationHistoryLabel)
        addSubview(tableView)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 106
        
        operationHistoryLabel.translatesAutoresizingMaskIntoConstraints = false
        operationHistoryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        operationHistoryLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: operationHistoryLabel.bottomAnchor, constant: 8).isActive = true
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200.0
    }

}

extension OperationHistory: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return operationHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "operationHistoryCell") as? OperationHistoryCell
        
        if cell == nil {
            cell = OperationHistoryCell.createCell()
        }
        
        cell?.setLabel(operationText: operationHistory[indexPath.row])
        self.frame.size.height = heightToFitContent(label: (cell?.operationLabel)!)
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let historyValue = operationHistory[indexPath.row]
        
        let index = historyValue.firstIndex(of: "=")
        let modifiedIndex = historyValue.index(index!, offsetBy: 2)
        
        historyDelegate.didTapCell(value: String(historyValue[modifiedIndex..<historyValue.endIndex]))
        
    }

}

func heightToFitContent(label: UILabel) -> CGFloat {
    
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    let maximumLabelSize : CGSize = CGSize(width: label.frame.size.width, height: CGFloat.greatestFiniteMagnitude)
    let expectedLabelSize : CGSize = label.sizeThatFits(maximumLabelSize);
    
    label.sizeToFit()
    
    return expectedLabelSize.height
}
