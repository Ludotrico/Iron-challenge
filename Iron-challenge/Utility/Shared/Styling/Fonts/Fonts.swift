//
//  Fonts.swift
//  Terra
//
//  Created by Ludovico Veniani on 1/19/22.
//

import Foundation
import UIKit

class Fonts {
    struct Name {
        static let extraBold = "Poppins-Black"
        static let bold = "Poppins-Bold"
        static let regular = "Poppins-Regular"
        static let italics = "Poppins-Italic"
    }
    
    
    
    static var navigationTitle: UIFont!
    static let navigationBtn: UIFont = Fonts.font(forTextStyle: .headline, fontName: Name.bold)

    static let standard: UIFont = Fonts.font(forTextStyle: .headline, fontName: Name.regular)
    static let standardItalics: UIFont = Fonts.font(forTextStyle: .headline, fontName: Name.italics)
    static let standardBold: UIFont = Fonts.font(forTextStyle: .headline, fontName: Name.bold)
    
    static let extraLargeExtraBold: UIFont = Fonts.font(forTextStyle: .largeTitle, fontName: Name.extraBold)
    static let largeExtraBold: UIFont = Fonts.font(forTextStyle: .title1, fontName: Name.extraBold)
    
    
    static let mediumExtraBold: UIFont = Fonts.font(forTextStyle: .title2, fontName: Name.extraBold)
    static let mediumBold: UIFont = Fonts.font(forTextStyle: .title2, fontName: Name.bold)
    static let medium: UIFont = Fonts.font(forTextStyle: .title2, fontName: Name.regular)
    
    static let small: UIFont = Fonts.font(forTextStyle: .caption2, fontName: Name.regular)
    static let smallItalics: UIFont = Fonts.font(forTextStyle: .caption2, fontName: Name.italics)
    static let smallBold: UIFont = Fonts.font(forTextStyle: .caption2, fontName: Name.bold)
    
    
    
    public static let customFonts: [UIFont.TextStyle: CGFloat] = [
        .largeTitle: 34,
        .title1: 28,
        .title2:  22,
        .title3:  20,
        .headline: 17,
        .body:  17,
        .callout:  16,
        .subheadline:  15,
        .footnote:  13,
        .caption1:  12,
        .caption2:  11
    ]
    
    
    private static func font(forTextStyle style: UIFont.TextStyle, fontName: String) -> UIFont {
        let customFont = UIFont(name: fontName, size: Self.customFonts[style]!)!
        let metrics = UIFontMetrics(forTextStyle: style)
        let scaledFont = metrics.scaledFont(for: customFont)
        
        return scaledFont
    }
    
}



