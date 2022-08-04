//
//  ReadoutView.swift
//  LCARS calc
//
//  Created by Andy Lewis on 8/3/22.
//

import SwiftUI

struct ReadoutView: View {
    
    @EnvironmentObject var calculator: AnotherCalc
    var largeFontSize: CGFloat = 70
    var smallFontSize: CGFloat = 50
    var cornerRadius: CGFloat = 30
    
    var body: some View {
        
        GeometryReader { metrics in
            
            VStack {
                ZStack {
                    buttonColorFive
                    ZStack {
                        Color.black
                        
                        Text("30.456")
                            .foregroundColor(fontColor)
                            .padding()
                            .font(Font.custom("Okuda", size: largeFontSize))
                        
                    }
                    .cornerRadius(cornerRadius, corners: [.topLeft])
                    .padding(.top, 5)
                    .padding(.leading, 20)
                    
                }
                .cornerRadius(cornerRadius, corners: [.topLeft])
                
                Spacer(minLength: 5)
            
                ZStack {
                    buttonColorFive
                    ZStack {
                        Color.black
                        
                        Text("Error")
                            .foregroundColor(fontColor)
                            .padding()
                            .font(Font.custom("Okuda", size: smallFontSize))
                        
                    }
                    .cornerRadius(cornerRadius, corners: [.bottomLeft])
                    .padding(.leading, 20)
                    .padding(.bottom, 5)
                    
                }
                .frame(height: metrics.size.height/3)
                .cornerRadius(cornerRadius, corners: [.bottomLeft])
                
            }
        }
    }
}

struct ReadoutView_Previews: PreviewProvider {
    static var previews: some View {
        ReadoutView()
    }
}
