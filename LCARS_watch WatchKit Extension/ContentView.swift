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
    
    var body: some View {
        VStack {
            Button(action: {
                showTipCalculator.toggle()
            }){
                Text("calculate tip")
                    .font(.custom("Okuda", size: 30))
            }.foregroundColor(.black)
            .background(Color(buttonColorOne))
            .cornerRadius(25)
            
            Button(action: {}){
                Text("set tip amount")
                    .font(.custom("Okuda", size: 30))
            }.foregroundColor(.black)
            .background(Color(buttonColorFive))
            .cornerRadius(25)
        }.sheet(isPresented:$showTipCalculator, content: {
            PriceEntryView()
        })
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
