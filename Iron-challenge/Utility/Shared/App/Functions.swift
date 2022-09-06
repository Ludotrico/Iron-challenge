//
//  static functions.swift
//  Terra
//
//  Created by Ludovico Veniani on 1/19/22.
//

import UIKit

class Functions {
    static func numberOfLines(text: String, font: UIFont, width: CGFloat, lineHeight: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height / lineHeight
    }
    
    static func heightForView(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    
    static func widthForView(text: String, font: UIFont, height: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: height))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.width
    }
    
    static func getMaximumFontInWidth(text: String, width: CGFloat, font: String) -> (maxFont: UIFont, maxHeight: CGFloat) {
        //        print("Target Width: \(width)")
        var lastDifference = CGFloat(0)
        var lastHeight = CGFloat(0)
        var lastFont = UIFont()
        var firstLoop = true
        for x in 1 ... 150 {
            let font = UIFont(name: font, size: CGFloat(x))!
            let height = Self.heightForView(text: text, font: font, width: width)
            lastDifference = height - lastHeight
            if lastDifference > 5, !firstLoop {
                break
            }
            lastHeight = height
            lastFont = font
            firstLoop = false
        }
        //        print(lastDifference)
        //        print(lastFont)
        return (maxFont: lastFont, maxHeight: lastHeight)
    }
    
    static func getMaximumFontInHeight(text: String, height: CGFloat, font: String) -> (maxFont: UIFont, maxWidth: CGFloat) {
        var lastWidth = CGFloat(0)
        var lastHeight = CGFloat(0)
        var lastFont = UIFont()
        //        print("TARGET Height: \(height)")
        for x in 1 ... 150 {
            let font = UIFont(name: font, size: CGFloat(x))!
            let width = Self.widthForView(text: text, font: font, height: height)
            let currHeight = Self.heightForView(text: text, font: font, width: width)
            if currHeight > height {
                break
            }
            lastWidth = width
            lastFont = font
            lastHeight = currHeight
            print(lastFont)
            print(lastHeight)
        }
        //        print(lastFont)
        //        print(lastWidth)
        //        print(lastHeight    )
        return (maxFont: lastFont, maxWidth: lastWidth)
    }
    
    static func getMaximumFont(text: String, width: CGFloat, height: CGFloat, font: String) -> (maxFont: UIFont, maxWidth: CGFloat, maxHeight: CGFloat) {
        var lastWidth = CGFloat(0)
        var lastHeight = CGFloat(0)
        var lastFont = UIFont()
        //        print("TARGET Width: \(width)")
        
        var lastDifference = CGFloat(0)
        var firstLoop = true
        
        //        print("TARGET Height: \(height)")
        for x in 1 ... 150 {
            let font = UIFont(name: font, size: CGFloat(x))!
            let currWidth = Self.widthForView(text: text, font: font, height: height)
            let currHeight = Self.heightForView(text: text, font: font, width: width)
            lastDifference = currHeight - lastHeight
            if currHeight > height {
                break
            }
            if lastDifference > 5, !firstLoop {
                break
            }
            if currWidth > width {
                break
            }
            
            lastWidth = currWidth
            lastFont = font
            lastHeight = currHeight
            
            firstLoop = false
            
            //            print(lastFont)
            //            print(lastHeight)
            //            print(lastWidth)
            //            print(lastDifference)
        }
        //        print(lastFont)
        //        print(lastWidth)
        //        print(lastHeight    )
        return (maxFont: lastFont, maxWidth: lastWidth, maxHeight: lastHeight)
    }
    
    static func seperateValues(string: String, seperator: String) -> [String] {
        return string.components(separatedBy: seperator)
    }
    
    static func stringify(_ ints: [Int]) -> String {
        var result = ""
        for x in ints {
            result.append("\(x),")
        }
        result.removeLast()
        return result
    }
    
    static func isPointInPolygon(polygon: [CGPoint], point: CGPoint) -> Bool {
        if polygon.count <= 1 {
            return false //or if first point = test -> return true
        }

        let p = UIBezierPath()
        let firstPoint = polygon[0] as CGPoint

        p.move(to: firstPoint)

        for index in 1...polygon.count-1 {
            p.addLine(to: polygon[index] as CGPoint)
        }

        p.close()

        return p.contains(point)
    }
    
    static func safe(present VC2: UIViewController, over VC: UIViewController, completion: (()-> Void)?=nil) {
        let v: UIViewController = VC.getAllPresentedViewControllers().last ?? VC
        
        
        v.present(VC2, animated: true, completion: completion)
    }
    
    static func downloadImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    static func copy(_ str: String) {
        UIPasteboard.general.string = str
    }
    
    static func shareURL(VC: UIViewController, presentationDelegate: UIAdaptivePresentationControllerDelegate?,  url: URL, text: String?) {

        var objects: [Any] = [url]
        if let text = text {
            objects.append(text)
        }
        
        let ac = UIActivityViewController(activityItems: objects, applicationActivities: nil)
        
        Functions.safe(present: ac, over: VC) { [weak presentationDelegate] in
            ac.presentationController?.delegate = presentationDelegate
        }
    }

}
