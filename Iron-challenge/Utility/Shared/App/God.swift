//
//  God.swift
//  Terra
//
//  Created by Ludovico Veniani on 1/19/22.
//

import Foundation
import UIKit

class God {
    static func initialize(containerVC: ContainerVC) {
        Self.containerVC = containerVC
    }
    
    static var containerVC: ContainerVC!
    
    static let ISOFormatter = ISO8601DateFormatter()
    static let dateFormatter = DateFormatter()
    
    
    static let loader = UIImageView()
    
}
