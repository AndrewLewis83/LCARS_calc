//
//  MathOperationButtons.swift
//  LCARS calc
//
//  Created by Andy Lewis on 8/3/22.
//

import SwiftUI

struct MathOperationButtons: View {
    
    var fontSize: CGFloat
    var buttonWidth: CGFloat
    
    var body: some View {
        VStack {
            ZStack {
                redAlertColor
                Button(action: {
                    
                }, label: {
                    Text("+")
                        
                        .foregroundColor(Color.black)
                        .padding()
                        .font(Font.custom("Okuda", size: fontSize))
                })
                .frame(width: buttonWidth, height: buttonWidth, alignment: .center)
                .cornerRadius(25)
            }
            
            ZStack {
                redAlertColor
                Button(action: {
                    
                }, label: {
                    Text("-")
                        
                        .foregroundColor(Color.black)
                        .padding()
                        .font(Font.custom("Okuda", size: fontSize))
                       
                })
                .frame(width: buttonWidth, height: buttonWidth, alignment: .center)
                .cornerRadius(25)
            }
            
            ZStack {
                redAlertColor
                Button(action: {
                    
                }, label: {
                    Text("x")
                        .foregroundColor(Color.black)
                        .padding()
                        .font(Font.custom("Okuda", size: fontSize))
                })
                .frame(width: buttonWidth, height: buttonWidth, alignment: .center)
                .cornerRadius(25)
            }
            
            ZStack {
                redAlertColor
                Button(action: {
                    
                }, label: {
                    Text("/")
                        .foregroundColor(Color.black)
                        .padding()
                        .font(Font.custom("Okuda", size: fontSize))
                })
                .frame(width: buttonWidth, height: buttonWidth, alignment: .center)
                .cornerRadius(25)
            }
            
            ZStack {
                redAlertColor
                Button(action: {
                    
                }, label: {
                    Text("tip %")
                        .foregroundColor(Color.black)
                        .padding()
                        .font(Font.custom("Okuda", size: fontSize))
                })
                .frame(width: buttonWidth, height: buttonWidth, alignment: .center)
                .cornerRadius(25)
            }
        }
    }
}

struct MathOperationButtons_Previews: PreviewProvider {
    static var previews: some View {
        MathOperationButtons(fontSize: 50, buttonWidth: 100)
    }
}
