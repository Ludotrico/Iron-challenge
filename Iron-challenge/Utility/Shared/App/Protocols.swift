//
//  Protocols.swift
//  Terra
//
//  Created by Ludovico Veniani on 1/19/22.
//

import Foundation
import UIKit
import SafariServices

protocol CustomNavBar: AnyObject {
    func done()
    func back()
}

protocol CustomPopup: AnyObject {
    func action1()
    func action2()
    func action3()
}

protocol DismissView : AnyObject {
    func dismissView()
}

protocol TextVCDelegate : AnyObject {
    func finishedEditing(title: String, text: String)
}


@objc protocol StoryDelegate : AnyObject {
    @objc func storyTapped(sender: UITapGestureRecognizer)
    @objc func profileTapped(sender: UITapGestureRecognizer)
}

protocol PresentationDelegate : AnyObject {
    func wasDismissed()
}


protocol MediaCollectionDelegate : AnyObject {
    func getMediaCount() -> Int
    func getViewWidth() -> CGFloat
    func deleteCell(identifier: Int)
    func getMediaURL(at indexPath: IndexPath) -> URL
}


protocol EventPresentationDelegate : AnyObject {
    func getEventIDTapped() -> Int
}




protocol SpinnerDelegate : AnyObject {
    func startAnimatingSpinner()
    func stopAnimatingSpinner()
}
