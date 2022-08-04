//
//  CalculatorButtonsView.swift
//  LCARS calc
//
//  Created by Andy Lewis on 8/3/22.
//

import SwiftUI

struct CalculatorButtonsView: View {
    
    var fontSize: CGFloat
    let widthMultiplier: CGFloat = 4.25
    
    var body: some View {
        
        GeometryReader { metrics in
            
            HStack {
                NumberPadView(buttonWidth: metrics.size.width/widthMultiplier, fontSize: fontSize)
                MathOperationButtons(fontSize: fontSize, buttonWidth: metrics.size.width/widthMultiplier)
            }
        }
        
    }
}

struct CalculatorButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButtonsView(fontSize: 50)
    }
}
