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
    
    var body: some View {
        
        VStack {
            
            ZStack {
                Circle()
                    .stroke(lineWidth: 7.0)
                    .opacity(0.3)
                    .foregroundColor(Color(buttonColorTwo))
                
                Circle()
                    .trim(from: 0.0, to: tipPercentage/20)
                    .stroke(style: StrokeStyle(lineWidth: 7.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color(buttonColorOne))
                    .frame(width: 77, height: 77)
                
                Text("\(Int(tipPercentage))%")
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
                .background(Color(UIColor.red))
            .cornerRadius(25)
            .padding()
        }
        
    }
}

//struct TipSettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        TipSettingsView()
//    }
//}
