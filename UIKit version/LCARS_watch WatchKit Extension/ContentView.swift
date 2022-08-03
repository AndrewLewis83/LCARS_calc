//
//  ContentView.swift
//  LCARS_watch WatchKit Extension
//
//  Created by Andrew Lewis on 12/14/21.
//  Copyright © 2021 Andrew Lewis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var showTipCalculator: Bool = false
    @State var showTipSettings: Bool = false
    @State var tipPercentage: CGFloat
    
    var body: some View {
        VStack {
            
            if let image = UIImage(named: "starfleet_logo") {
            
                ZStack {
                
                    Circle()
                        .frame(width: 48, height: 48)
                        .foregroundColor(Color(textColorOne))
                    Circle()
                        .frame(width: 45, height: 45)
                        .foregroundColor(Color.black)
                    
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 36.0, height: 36.0)
                        .colorMultiply(Color(textColorOne))
                        .padding()
                }
            }
            
            
            Button(action: {
                setTipPercentage()
                showTipCalculator.toggle()
            }){
                Text("calculate tip")
                    .font(.custom("Okuda", size: 30))
            }.foregroundColor(.black)
            .background(Color(buttonColorOne))
            .cornerRadius(25)
            
            Button(action: {
                setTipPercentage()
                showTipSettings.toggle()
            }){
                Text("set tip amount")
                    .font(.custom("Okuda", size: 30))
            }.foregroundColor(.black)
            .background(Color(buttonColorFive))
            .cornerRadius(25)
        }.sheet(isPresented:$showTipCalculator, content: {
            PriceEntryView(tipPercentage: $tipPercentage)
        })
        .sheet(isPresented:$showTipSettings, content: {
            TipSettingsView(tipPercentage: $tipPercentage)
        })
        
    }
    
    func setTipPercentage() {
        if let tip = UserDefaults.standard.object(forKey: "tipPercentage") as? CGFloat {
            tipPercentage = tip
        }else{
            tipPercentage = CGFloat(0.0)
        }
    }
}
