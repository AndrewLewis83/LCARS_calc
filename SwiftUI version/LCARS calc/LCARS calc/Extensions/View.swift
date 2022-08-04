//
//  View.swift
//  LCARS calc
//
//  Created by Andy Lewis on 8/3/22.
//

import Foundation
import SwiftUI

/// this allows you to apply a corner radius to specific corners. Got this from StackOverflow, https://stackoverflow.com/a/58606176/8697268

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
