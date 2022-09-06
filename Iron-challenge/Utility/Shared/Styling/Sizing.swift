//
//  Sizing.swift
//  Terra
//
//  Created by Ludovico Veniani on 1/19/22.
//

import Foundation
import UIKit

class Sizing {
    static func initialize(frame: CGRect, navBarFrame: CGRect) {
        Self.padding = frame.width/30
        Self.deviceWidth = frame.width
        Self.deviceHeight = frame.height
        
        Self.standard = Functions.getMaximumFont(text: "AMXTWQ", width: Self.deviceWidth, height: Self.deviceWidth / 15, font: Fonts.Name.bold)
        
        Self.imageConfig =  UIImage.SymbolConfiguration(pointSize: Self.standard.maxFont.pointSize, weight: .bold)
        
        Fonts.navigationTitle = Functions.getMaximumFont(text: "WQASZXY", width: 999, height: navBarFrame.height * (3/3), font: Fonts.Name.bold).maxFont
    }
    
    static var padding: CGFloat!
    static var deviceHeight: CGFloat!
    static var deviceWidth: CGFloat!
    
    static var standard: (maxFont: UIFont, maxWidth: CGFloat, maxHeight: CGFloat)!
    static var imageConfig: UIImage.SymbolConfiguration!
}
