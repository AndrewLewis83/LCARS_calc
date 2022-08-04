//
//  NumberPadView.swift
//  independent_study
//
//  Created by Andy Lewis on 7/20/22.
//  Copyright © 2022 Andrew Lewis. All rights reserved.
//

import SwiftUI

struct NumberPadView: View {

    let buttonWidth: CGFloat
    let fontSize: CGFloat

    @EnvironmentObject var calculator: AnotherCalc

    var body: some View {
        
        VStack {
            HStack {
                ForEach((1...3), id: \.self) { number in
                    ZStack {
                        getColor(id: number)
                        Button(action: {
                            addDigit(character: "\(number)")
                        }, label: {
                            Text("\(number)")
                                .foregroundColor(Color.black)
                                .padding()
                                .font(Font.custom("Okuda", size: fontSize))
                        })
                        .frame(width: buttonWidth, height: buttonWidth, alignment: .center)
                        .cornerRadius(25)
                    }
                }
            }
            
            HStack {
                ForEach((4...6), id: \.self) { number in
                    ZStack {
                        getColor(id: number)
                        Button(action: {
                            addDigit(character: "\(number)")
                        }, label: {
                            Text("\(number)")
                                .foregroundColor(Color.black)
                                .padding()
                                .font(Font.custom("Okuda", size: fontSize))
                        })
                        .frame(width: buttonWidth, height: buttonWidth, alignment: .center)
                        .cornerRadius(25)
                    }
                }
            }
            
            HStack {
                ForEach((7...9), id: \.self) { number in
                    ZStack {
                        getColor(id: number)
                        Button(action: {
                            addDigit(character: "\(number)")
                        }, label: {
                            Text("\(number)")
                                .foregroundColor(Color.black)
                                .padding()
                                .font(Font.custom("Okuda", size: fontSize))
                        })
                        .frame(width: buttonWidth, height: buttonWidth, alignment: .center)
                        .cornerRadius(25)
                    }
                }
            }
            
            HStack {
                
                ZStack {
                    redAlertColor
                    Button(action: {
                        
                    }, label: {
                        Text("CLR")
                            
                            .foregroundColor(Color.black)
                            .padding()
                            .font(Font.custom("Okuda", size: fontSize))
                    })
                    .frame(width: buttonWidth, height: buttonWidth, alignment: .center)
                    .cornerRadius(25)
                }
                
                ZStack {
                    buttonColorFive
                    Button(action: {
                        
                    }, label: {
                        Text("0")
                            
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
                        addDigit(character: ".")
                    }, label: {
                        Text(".")
                            .foregroundColor(Color.black)
                            .padding()
                            .font(Font.custom("Okuda", size: fontSize))
                    })
                    .frame(width: buttonWidth, height: buttonWidth, alignment: .center)
                    .cornerRadius(25)
                }
            }
            
            HStack {
                
                ZStack {
                    redAlertColor
                    Button(action: {
                        backspace()
                    }, label: {
                        Image(systemName: "delete.backward.fill")
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
                        Text("=")
                            
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
                        addDigit(character: "+/-")
                    }, label: {
                        Text(".")
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
    
    func getColor(id: Int) -> Color {
        
        switch id {
        case 1, 5, 9:
            return buttonColorOne
        case 2, 6:
            return buttonColorTwo
        case 3, 7:
            return buttonColorThree
        case 4, 8:
            return buttonColorFour
        default:
            return buttonColorFive
        }
        
    }
    
    func addDigit(character: String) {
        
//        if character != "." || bodyweightManager.bodyweightReadout.contains(".") == false {
//
//            if bodyweightManager.bodyweightReadout != "0.0" {
//                bodyweightManager.bodyweightReadout += character
//            } else {
//                bodyweightManager.bodyweightReadout = character
//            }
//        }
    }
    
    func backspace() {
        
//        if bodyweightManager.bodyweightReadout != "0.0" && bodyweightManager.bodyweightReadout != "" {
//            bodyweightManager.bodyweightReadout.removeLast()
//        } else {
//            bodyweightManager.bodyweightReadout = "0.0"
//        }
    }
}

struct NumberPadView_Previews: PreviewProvider {
    static var previews: some View {
        NumberPadView(buttonWidth: 100, fontSize: 50)
    }
}
