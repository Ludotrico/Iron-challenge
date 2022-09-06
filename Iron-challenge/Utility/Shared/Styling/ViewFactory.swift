//
//  ViewFactory.swift
//  Terra
//
//  Created by Ludovico Veniani on 1/19/22.
//

import Foundation
import UIKit

class ViewFactory {
    struct View {
        static func standard(backgroundColor: UIColor) -> UIView {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = backgroundColor
            view.clipsToBounds = true
            return view
        }
    }
    
    struct Stack {
        static func standard(axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution, alignment: UIStackView.Alignment, backgroundColor: UIColor, padding: CGFloat?=nil, spacing: CGFloat?=nil) -> UIStackView {
            let view = UIStackView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.axis = axis
            view.distribution = distribution
            view.alignment = alignment
            view.backgroundColor = backgroundColor
            view.isLayoutMarginsRelativeArrangement = true
            
            if let padding = padding {
                view.layoutMargins = .init(top: padding, left: padding, bottom: padding, right: padding)
            }
            if let spacing = spacing {
                view.spacing = spacing
            }
            
            return view
        }
    }
    
    struct ImageView {
        static func standard(image: UIImage?, contentMode: UIView.ContentMode, tint: UIColor, backgroundColor: UIColor = .clear) -> UIImageViewSpinner {
            let view = UIImageViewSpinner(image: image)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.contentMode = contentMode
            view.tintColor = tint
            view.backgroundColor = backgroundColor
            view.clipsToBounds = true
            view.layer.masksToBounds = true
            return view
        }
    }
    
    struct Button {
        static func standard(text: String, font: UIFont, textColor: UIColor, target: AnyObject?=nil, selector: Selector?=nil, hideBackground: Bool=true) -> UIButtonSpinner {
            let view = UIButtonSpinner(type: .system)
            view.configureSpinner(color: textColor, hideBackground: hideBackground)
            view.setTitle(text, for: .normal)
            view.titleLabel?.font = font
            view.titleLabel?.textColor = textColor
            view.titleLabel?.lineBreakMode = .byTruncatingTail
            view.tintColor = textColor
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .clear
            view.clipsToBounds = true
            if let target = target, let selector = selector {
                view.addTarget(target, action: selector, for: .touchUpInside)
            }
           
            return view
        }
        
        static func image(image: UIImage?, tint: UIColor, background: UIColor, padding: CGFloat=0, hideBackground: Bool, target: AnyObject?=nil, selector: Selector?=nil) -> UIButtonSpinner {
            let button = UIButtonSpinner(type: .system)
            button.configureSpinner(color: tint, hideBackground: hideBackground)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(image, for: .normal)
            button.imageView?.pinEdges(to: button, padding: padding)
            button.tintColor = tint
            button.backgroundColor = background
            button.imageView?.layer.masksToBounds = true
            button.imageView?.clipsToBounds = true
            button.imageView?.contentMode = .scaleAspectFit
            button.isUserInteractionEnabled = true
            if let target = target, let selector = selector {
                button.addTarget(target, action: selector, for: .touchUpInside)
            }
            
            return button
        }
        
        static func text(text: String, font: UIFont, textColor: UIColor, target: AnyObject?=nil, selector: Selector?=nil) -> UIButton {
            let view = UIButton(type: .system)
            view.setTitle(text, for: .normal)
            view.titleLabel?.font = font
            view.titleLabel?.textColor = textColor
            view.tintColor = textColor
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .clear
            view.clipsToBounds = true
            view.titleLabel?.lineBreakMode = .byTruncatingTail
            if let target = target, let selector = selector {
                view.addTarget(target, action: selector, for: .touchUpInside)
            }
            return view
        }
    }
    
    struct Label {
        static func standard(text: String?=nil, font: UIFont=Fonts.standard, textColor: UIColor=UIColor.label, alignment: NSTextAlignment, numberOfLines: Int=0) -> PaddingLabel {
            let lbl = PaddingLabel()
            lbl.insets(top: 0, bottom: 0, left: 0, right: 0)
            lbl.text = text
            lbl.textColor = textColor
            
            lbl.textAlignment = alignment
            lbl.translatesAutoresizingMaskIntoConstraints = false
            lbl.adjustsFontSizeToFitWidth = false
            lbl.font =  font
            
            lbl.numberOfLines = numberOfLines
            lbl.lineBreakMode = .byTruncatingTail
            lbl.adjustsFontForContentSizeCategory = true
            lbl.clipsToBounds = true
            return lbl
        }
        
        static func standardSpinner(text: String?=nil, font: UIFont=Fonts.standard, textColor: UIColor=UIColor.label, spinnerColor: UIColor=UIColor.label, alignment: NSTextAlignment, numberOfLines: Int=0) -> UILabelSpinner {
            let lbl = UILabelSpinner()
            lbl.configureSpinner(color: spinnerColor)
            lbl.insets(top: 0, bottom: 0, left: 0, right: 0)
            lbl.text = text
            lbl.textColor = textColor
            
            lbl.textAlignment = alignment
            lbl.translatesAutoresizingMaskIntoConstraints = false
            lbl.adjustsFontSizeToFitWidth = false
            lbl.font =  font
            
            lbl.numberOfLines = numberOfLines
            lbl.lineBreakMode = .byTruncatingTail
            lbl.adjustsFontForContentSizeCategory = true
            lbl.clipsToBounds = true
            return lbl
        }
    }
    
    struct SegmentedControl {
        static func standard(items: [String], target: AnyObject, onChange: Selector) -> UISegmentedControl {
            let control = UISegmentedControl(items: items)
            control.layer.masksToBounds = true
            
            control.addTarget(target, action: onChange, for: .valueChanged)
            control.tintColor = .label
            control.selectedSegmentTintColor = .systemBlue
            control.translatesAutoresizingMaskIntoConstraints = false
            
            control.setTitleTextAttributes([NSAttributedString.Key.font: Fonts.standardBold], for: .normal)
            return control
        }
    }
    
    struct Scroll {
        static func standard(isPagingEnabled: Bool=false, bounceV: Bool=true, bounceH: Bool=true, showVIndicator: Bool=false, showHIndicator: Bool=false) -> UIScrollView {
            
            let scroll = UIScrollView()
            scroll.translatesAutoresizingMaskIntoConstraints = false
            scroll.isScrollEnabled = true
            scroll.showsVerticalScrollIndicator = showVIndicator
            scroll.showsHorizontalScrollIndicator = showHIndicator
            scroll.alwaysBounceHorizontal = bounceH
            scroll.alwaysBounceVertical = bounceV
            scroll.isPagingEnabled = isPagingEnabled
            
            return scroll
            
        }
    }
    
    struct TextField {
        static func standard(withPlaceolder placeholder: String?, textColor: UIColor, isSecureTextEntry: Bool, isTextEntry: Bool, autoCapitalize: Bool=true, target: AnyObject?=nil, onChange: Selector?=nil) -> UITextField {
            let tf = UITextField()
            tf.translatesAutoresizingMaskIntoConstraints = false
            tf.borderStyle = .none
            tf.font = Fonts.standard // UIFont.systemFont(ofSize: 16)
            tf.textColor = textColor
            tf.isSecureTextEntry = isSecureTextEntry
            if placeholder != nil {
                tf.placeholder = placeholder
            }
            tf.autocorrectionType = .no
            tf.autocapitalizationType = autoCapitalize ? .sentences : .none
            if isTextEntry {
                tf.keyboardType = .default
            } else {
                tf.keyboardType = .decimalPad
            }
            
            if let target = target, let onChange = onChange {
                tf.addTarget(target, action: onChange, for: .editingChanged)
            }
            
            
            return tf
        }
    }
    

    
    struct Table {
        static func standard(dataSource: UITableViewDataSource, delegate: UITableViewDelegate, bgColor: UIColor, showScrollIndicator: Bool) -> UITableView {
            let view = UITableView()
            view.dataSource = dataSource
            view.delegate = delegate
            view.separatorStyle = .none
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = bgColor
            view.isScrollEnabled = true
            view.alwaysBounceVertical = true
            view.showsVerticalScrollIndicator = showScrollIndicator
            view.rowHeight = UITableView.automaticDimension
            return view
        }
    }
    
    struct InputField {
        static func container(image: UIImage, textField: UITextField, tintColor: UIColor, hideLine: Bool=false, target: AnyObject?=nil, onTap: Selector?=nil, imageRenderingMode: UIImage.RenderingMode = .alwaysTemplate) -> UIView {
            
            let container = ViewFactory.View.standard(backgroundColor: .clear)
            
            let image = image.withRenderingMode(imageRenderingMode)
            let totalHeight = textField.font!.lineHeight + (Sizing.padding*2)
            let imageHeight = totalHeight/2
            
            container.heightAnchor.constraint(equalToConstant: totalHeight).isActive = true
            
            let imageView = ViewFactory.ImageView.standard(image: image, contentMode: .scaleAspectFit, tint: tintColor)
            imageView.alpha = 0.87
            
            
            
            container.addSubview(imageView)
            imageView.anchor(top: nil, left: container.leftAnchor, bottom: nil, right: nil, centerY: container.centerYAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: imageHeight, height: imageHeight)
            imageView.tag = 0
            
            container.addSubview(textField)
            textField.anchor(top: container.topAnchor, left: imageView.rightAnchor, bottom: container.bottomAnchor, right: container.rightAnchor, paddingTop: 0, paddingLeft: Sizing.padding, paddingBottom: 0, paddingRight: 0)
            
            
            if !hideLine {
                let separatorView = ViewFactory.View.standard(backgroundColor: tintColor.withAlphaComponent(0.7))
                container.addSubview(separatorView)
                separatorView.anchor(top: nil, left: container.leftAnchor, bottom: container.bottomAnchor, right: container.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.75)
            }
            
            if let onTap = onTap, let target = target {
                container.isUserInteractionEnabled = true
                
                let tap = UITapGestureRecognizer(target: target, action: onTap)
                container.addGestureRecognizer(tap)
                textField.isUserInteractionEnabled = false
            }
            
            return container
        }
    }
    
    struct Nav {
        static func setup(VC: UIViewController, title: String, leftButton: UIBarButtonItem? = nil, rightButton: UIBarButtonItem? = nil, rightButtons: [UIBarButtonItem]? = nil, titleView: UIView? = nil) {
            let NC = VC.navigationController
            NC?.setNavigationBarHidden(false, animated: false)
            NC?.interactivePopGestureRecognizer?.isEnabled = true
            
            VC.title = title
            
            if leftButton != nil {
                VC.navigationItem.setLeftBarButton(leftButton!, animated: false)
            }
            if rightButton != nil {
                VC.navigationItem.setRightBarButton(rightButton!, animated: false)
            }
            
            if rightButtons != nil {
                //            if rightButtons?.count == 3 {
                //                rightButtons?[0].imageInsets =  UIEdgeInsets(top: 0.0, left: 0, bottom: 0, right: 0);
                //                rightButtons?[1].imageInsets = UIEdgeInsets(top: 0.0, left: 0, bottom: 0, right: 50);
                //                rightButtons?[2].imageInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0, right: 50);
                //            }
                VC.navigationItem.setRightBarButtonItems(rightButtons!, animated: false)
            }
            
            if let view = titleView {
                VC.navigationItem.titleView = view
            }
            
            
            
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            //            appearance.backgroundColor = .white
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label, NSAttributedString.Key.font: Fonts.navigationTitle]
            NC?.navigationBar.standardAppearance = appearance
            NC?.navigationBar.scrollEdgeAppearance = NC?.navigationBar.standardAppearance
        }
        
        
        static func imageBarItem(VC: UIViewController, image: String, color: UIColor? = .black, f: Selector) -> UIBarButtonItem {
            let backArrow = UIButton(type: .system)
            let imageConfig = UIImage.SymbolConfiguration(pointSize: Fonts.navigationTitle.pointSize, weight: .bold)
            backArrow.setImage(UIImage(systemName: image, withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate), for: .normal)
            
            backArrow.tintColor = color
            backArrow.addTarget(VC, action: f, for: .touchUpInside)
            
            let barButtonItem = UIBarButtonItem(customView: backArrow)
            backArrow.widthAnchor.constraint(equalToConstant: 30).isActive = true
            backArrow.heightAnchor.constraint(equalToConstant: 30).isActive = true
            
            return barButtonItem
        }
        
        static func textBarItem(VC: UIViewController, text: String, f: Selector, color: UIColor? = UIColor.systemBlue) -> UIBarButtonItem {
            // Done Btn
            let doneBtn = UIButton(type: .system)
            let font: UIFont = Fonts.navigationBtn
            let attributedTitle = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color!])
            doneBtn.setAttributedTitle(attributedTitle, for: .normal)
            
            doneBtn.tintColor = color!
            doneBtn.addTarget(VC, action: f, for: .touchUpInside)
            
            let barButtonItem = UIBarButtonItem(customView: doneBtn)
            doneBtn.widthAnchor.constraint(equalToConstant: Functions.widthForView(text: text, font: font, height: 500)).isActive = true
            doneBtn.heightAnchor.constraint(equalToConstant: 80).isActive = true
            
            return barButtonItem
        }
    }
    
    struct Image {
        static let imageConfig = UIImage.SymbolConfiguration(pointSize: Fonts.customFonts[.headline]!, weight: .bold)
        
        static let heart = UIImage(systemName: "heart", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let hammer = UIImage(systemName: "hammer", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let sparkles = UIImage(systemName: "sparkles", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let heartFilled = UIImage(systemName: "heart.fill", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)//
        
        static let xmark = UIImage(systemName: "xmark", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let plusFill = UIImage(systemName: "plus.circle.fill", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let rightArrow = UIImage(systemName: "chevron.right", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let downArrow = UIImage(systemName: "chevron.down", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let upArrow = UIImage(systemName: "chevron.up", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let checkmark = UIImage(systemName: "checkmark", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let trash = UIImage(systemName: "trash", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let flag = UIImage(systemName: "flag", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let person = UIImage(systemName: "person", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let socialMedia = UIImage(systemName: "list.bullet", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let textBubble = UIImage(systemName: "text.bubble", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let clock = UIImage(systemName: "clock", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let questionmarkDiamond = UIImage(systemName: "questionmark.diamond", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let walking = UIImage(systemName: "figure.walk", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let pencil = UIImage(systemName: "pencil", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let chartBars = UIImage(systemName: "chart.bar.xaxis", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let shoppingCart = UIImage(systemName: "cart", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let bag = UIImage(systemName: "bag", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let shoppingCartFill = UIImage(systemName: "cart.fill", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let train = UIImage(systemName: "train.side.front.car", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let click =  UIImage(systemName: "cursorarrow.rays", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let menuCard =  UIImage(systemName: "menucard", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let textBook =  UIImage(systemName: "text.book.closed", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let books =  UIImage(systemName: "books.vertical", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let bookClosed =  UIImage(systemName: "book.closed", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let handPointing = UIImage(systemName: "hand.point.up", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let bolt = UIImage(systemName: "bolt.horizontal", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let airplane = UIImage(systemName: "airplane", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let airstrike = UIImage(systemName: "airplane.arrival", withConfiguration: imageConfig)?.withRenderingMode(.alwaysTemplate) ?? Image.airplane
        static let globe = UIImage(systemName: "globe", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let earth = UIImage(systemName: "globe.europe.africa", withConfiguration: imageConfig)?.withRenderingMode(.alwaysTemplate) ?? Self.globe
        static let dollarSignCircle = UIImage(systemName: "dollarsign.circle", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let priceTag = UIImage(systemName: "tag", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let megaPhone = UIImage(systemName: "megaphone", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let brain = UIImage(systemName: "brain", withConfiguration: imageConfig)?.withRenderingMode(.alwaysTemplate) ?? Self.questionmarkDiamond
        static let flags = UIImage(systemName: "flag.2.crossed.fill", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let skew = UIImage(systemName: "skew", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate) 
        static let people = UIImage(systemName: "person.3.fill", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        static let logo = UIImage(named: "quadraLogo_transparent.png")!
        static let comingSoon = UIImage(systemName: "timelapse", withConfiguration: imageConfig)!.withRenderingMode(.alwaysTemplate)
        
        
        
        
        static var activity: UIImage {
            Self.bolt
        }
        
       
        static var dottedSquare: UIImage {
            UIImage(named: "dottedSquare")!.withTintColor(.label)
        }
        static var eth: UIImage {
            UIImage(named: "eth")!.withTintColor(.label)
        }
    }
}
