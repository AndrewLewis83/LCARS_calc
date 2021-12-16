//
//  PriceEntryView.swift
//  LCARS_watch WatchKit Extension
//
//  Created by Andrew Lewis on 12/14/21.
//  Copyright © 2021 Andrew Lewis. All rights reserved.
//

import SwiftUI

struct PriceEntryView: View {
    
    let buttonFontSize: CGFloat = 20
    let buttonHeight: CGFloat = 32
    let customRadius: CGFloat = 20
    @Environment(\.presentationMode) var presentationMode
    @State var price: String = "$0.00"
    @State var showResult: Bool = false
    @Binding var tipPercentage: CGFloat
    var resultFontSize: CGFloat = 40
    
    var body: some View {
        
        if showResult == false {
            
            VStack(spacing: 1){
                Spacer(minLength: 10)
                Text(price)
                    .font(.custom("Okuda", size: 25))
                    .foregroundColor(Color(warpColorOne))
                
                HStack(spacing: 1) {
                    Button(action: {
                        if price != "$0.00" {
                            price.append("1")
                        }else{
                            price = "$1"
                        }
                    }){
                        Text("1")
                            .font(.custom("Okuda", size: buttonFontSize))
                    }.frame(height: buttonHeight)
                    .foregroundColor(.black)
                    .background(Color(buttonColorOne))
                    .cornerRadius(customRadius, corners: [.topLeft, .bottomLeft])
                    
                    
                    Button(action: {
                        if price != "$0.00" {
                            price.append("2")
                        }else{
                            price = "$2"
                        }
                    }){
                        Text("2")
                            .font(.custom("Okuda", size: buttonFontSize))
                    }.frame(height: buttonHeight)
                    .foregroundColor(.black)
                    .background(Color(buttonColorTwo))
                    
                    Button(action: {
                        if price != "$0.00" {
                            price.append("3")
                        }else{
                            price = "$3"
                        }
                    }){
                        Text("3")
                            .font(.custom("Okuda", size: buttonFontSize))
                    }.frame(height: buttonHeight)
                    .foregroundColor(.black)
                    .background(Color(buttonColorThree))
                    .cornerRadius(customRadius, corners: [.topRight, .bottomRight])
                    
                }.padding(.leading)
                .padding(.trailing)
                
                
                HStack(spacing: 1) {
                    Button(action: {
                        if price != "$0.00" {
                            price.append("4")
                        }else{
                            price = "$4"
                        }
                    }){
                        Text("4")
                            .font(.custom("Okuda", size: buttonFontSize))
                    }.frame(height: buttonHeight)
                    .foregroundColor(.black)
                    .background(Color(buttonColorFour))
                    .cornerRadius(customRadius, corners: [.topLeft, .bottomLeft])
                    
                    
                    Button(action: {
                        if price != "$0.00" {
                            price.append("5")
                        }else{
                            price = "$5"
                        }
                    }){
                        Text("5")
                            .font(.custom("Okuda", size: buttonFontSize))
                    }.frame(height: buttonHeight)
                    .foregroundColor(.black)
                    .background(Color(buttonColorOne))
                    
                    Button(action: {
                        if price != "$0.00" {
                            price.append("6")
                        }else{
                            price = "$6"
                        }
                    }){
                        Text("6")
                            .font(.custom("Okuda", size: buttonFontSize))
                    }.frame(height: buttonHeight)
                    .foregroundColor(.black)
                    .background(Color(buttonColorTwo))
                    .cornerRadius(customRadius, corners: [.topRight, .bottomRight])
                    
                }.padding(.leading)
                .padding(.trailing)
                
                
                HStack(spacing: 1) {
                    Button(action: {
                        if price != "$0.00" {
                            price.append("7")
                        }else{
                            price = "$7"
                        }
                    }){
                        Text("7")
                            .font(.custom("Okuda", size: buttonFontSize))
                    }.frame(height: buttonHeight)
                    .foregroundColor(.black)
                    .background(Color(buttonColorThree))
                    .cornerRadius(customRadius, corners: [.topLeft, .bottomLeft])
                    
                    Button(action: {
                        if price != "$0.00" {
                            price.append("8")
                        }else{
                            price = "$8"
                        }
                    }){
                        Text("8")
                            .font(.custom("Okuda", size: buttonFontSize))
                    }.frame(height: buttonHeight)
                    .foregroundColor(.black)
                    .background(Color(buttonColorFour))

                    Button(action: {
                        if price != "$0.00" {
                            price.append("9")
                        }else{
                            price = "$9"
                        }
                    }){
                        Text("9")
                            .font(.custom("Okuda", size: buttonFontSize))
                    }.frame(height:buttonHeight)
                    .foregroundColor(.black)
                    .background(Color(buttonColorOne))
                    .cornerRadius(customRadius, corners: [.topRight, .bottomRight])

                }.padding(.leading)
                .padding(.trailing)
                
                HStack(spacing: 1) {
                    
                    Button(action: {
                        if price != "$0.00" && price.contains(where: {$0 == "."}) == false {
                            price.append(".")
                        }else if price == "$0.00"{
                            price = "$0."
                        }
                    }){
                        Text(".")
                    }.frame(height: buttonHeight)
                    .foregroundColor(.black)
                    .background(Color(UIColor.red))
                    .cornerRadius(customRadius, corners: [.topLeft])
                    
                    Button(action: {
                        if price != "$0.00" {
                            price.append("0")
                        }else{
                            price = "$0.00"
                        }
                    }){
                        Text("0")
                            .font(.custom("Okuda", size: buttonFontSize))
                    }.frame(height: buttonHeight)
                    .foregroundColor(.black)
                    .background(Color(buttonColorOne))
                    
                    Button(action: {
                        
                        if price != "$0.00" {
                            price.removeLast()
                            
                        }
                        
                        if price == "$"{
                            price = "$0.00"
                        }
                    }){
                        Image(systemName: "delete.backward.fill")
                    }.frame(maxHeight: buttonHeight)
                    .foregroundColor(.black)
                    .background(Color(UIColor.red))
                    .cornerRadius(customRadius, corners: [.topRight])
                    
                    
                }.padding(.leading)
                .padding(.trailing)
                
                HStack(spacing: 1) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        Image(systemName: "house.fill")
                    }.frame(height: buttonHeight)
                    .foregroundColor(.black)
                    .background(Color(UIColor.red))
                    .cornerRadius(customRadius, corners: [.bottomLeft])
                    
                    Button(action: {
                        showResult.toggle()
                    }){
                        Text("tip")
                            .font(.custom("Okuda", size: buttonFontSize))
                    }.frame(height: buttonHeight)
                    .foregroundColor(.black)
                    .background(Color(UIColor.red))
                    .cornerRadius(customRadius, corners: [.bottomRight])
                    
                }.padding(.leading)
                .padding(.trailing)
                
            }
        }else{
            
            if let convertedPrice = Double(String(price.dropFirst())){
                VStack {
                    
                    Text(String(format: "$%.2f +", convertedPrice) + String(format: "$%.2f = " + String(format: "$%.2f", convertedPrice + (convertedPrice*(tipPercentage*0.01))), convertedPrice*(tipPercentage*0.01)))
                        .font(.custom("Okuda", size: resultFontSize))
                        .foregroundColor(Color(warpColorOne))
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                    
                    HStack {
                        
                        Button(action: {
                            price = "$0.00"
                            showResult.toggle()
                        }){
                            Text("back")
                                .font(.custom("Okuda", size: 30))
                                .minimumScaleFactor(0.5)
                        }.frame(height: 50)
                        .foregroundColor(.black)
                        .background(Color(buttonColorOne))
                        .cornerRadius(customRadius, corners: [.bottomLeft, .topLeft])
                        
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }){
                            Image(systemName: "house.fill")
                        }.frame(height: 50)
                        .foregroundColor(.black)
                            .background(Color(UIColor.red))
                        .cornerRadius(customRadius, corners: [.bottomRight, .topRight])
                    }
                }
            }
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
