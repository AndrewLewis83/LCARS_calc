//
//  ContentView.swift
//  LCARS calc
//
//  Created by Andy Lewis on 8/2/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    let fontSize: CGFloat = 50
    let buttonSize: CGFloat = 50

    var body: some View {
        GeometryReader { metrics in
            
            ZStack {
            
                Color.black
            
                VStack {
                    ReadoutView()
                        .frame(height: 200)
                    
                    Spacer(minLength: 10)
                    
                    ZStack {
                        buttonColorFive

                        ZStack {
                            Color.black
                            CalculatorButtonsView(fontSize: fontSize)
                                .padding(.leading, 20)
                                .padding(.top, 10)
                                .padding(.bottom, 10)

                        }
                        .padding(.leading, 20)
                        .padding(.top, 5)
                        
                    }
                }
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
