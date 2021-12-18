//
//  TipSettingsView.swift
//  LCARS_watch WatchKit Extension
//
//  Created by Andrew Lewis on 12/16/21.
//  Copyright © 2021 Andrew Lewis. All rights reserved.
//

import SwiftUI

struct TipSettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var tipPercentage: CGFloat
    let circleDiameter = WKInterfaceDevice.current().screenBounds.size.width*0.4
    
    var body: some View {
        
        VStack {
            
            ZStack {
                Circle()
                    .stroke(lineWidth: 7.0)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.red))
                
                Circle()
                    .trim(from: 0.0, to: tipPercentage/20)
                    .stroke(style: StrokeStyle(lineWidth: 7.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color(UIColor.red))
                    .frame(width: circleDiameter, height: circleDiameter)
                
                Text("\(Int(tipPercentage))%")
                    .foregroundColor(Color(textColorOne))
                    .font(.custom("Okuda", size: 30))
                    .focusable(true)
                    .digitalCrownRotation($tipPercentage, from: 1, through: 20, by: 1.0, sensitivity: .low, isContinuous: false, isHapticFeedbackEnabled: true)
                
            }.padding()
            
            Button(action: {
                UserDefaults.standard.set(Int(tipPercentage), forKey: "tipPercentage")
                self.presentationMode.wrappedValue.dismiss()
            }){
                Text("back")
                    .font(.custom("Okuda", size: 30))
            }.foregroundColor(.black)
                .background(Color(buttonColorOne))
            .cornerRadius(25)
            .padding()
        }
        
    }
}
