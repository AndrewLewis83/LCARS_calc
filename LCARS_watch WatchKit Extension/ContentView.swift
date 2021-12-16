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
