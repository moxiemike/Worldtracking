//
//  Math.swift
//  Common Math Functions
//
//  Created by Joseph on 7/20/18.
//  Copyright © 2018 55B.ai. All rights reserved.
//

import UIKit
import ARKit
class Math {
//    Math Functions
    
    //    randInRange: Generate random number between two values
    //    Example: randInRange(0,3)
    func randInRange(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random())/CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
}


extension Int {
    var deg2rad: Double { return Double(self) * .pi/180}
}
