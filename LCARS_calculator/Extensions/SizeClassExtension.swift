//
//  SizeClassExtension.swift
//  LCARS_calculator
//
//  Created by Andrew Lewis on 7/10/20.
//  Copyright © 2020 Andrew Lewis. All rights reserved.
//

import UIKit

extension UIViewController {
    func sizeClass() -> (UIUserInterfaceSizeClass, UIUserInterfaceSizeClass) {
        return (UIScreen.main.traitCollection.horizontalSizeClass, self.traitCollection.verticalSizeClass)
    }
}
