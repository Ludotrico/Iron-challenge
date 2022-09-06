//
//  SetCell.swift
//  Iron-challenge
//
//  Created by Ludovico Veniani on 9/5/22.
//

import Foundation
import UIKit

class SetCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    //MARK: -Variables
    static let reuseID = "SetCell"
    
    weak var logVC: LogVC?
    var loggedSet: LoggedSet!
    
    //MARK: -Views
    lazy var setLbl: PaddingLabel = {
        let view = ViewFactory.Label.standardSpinner(text: nil, font: Fonts.standard, textColor: .label,  alignment: .center, numberOfLines: 1)
        view.layer.borderColor = UIColor.quaternaryLabel.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    lazy var repField: UITextField = {
        let view = ViewFactory.TextField.standard(withPlaceolder: "Reps", textColor: .label, isSecureTextEntry: false, isTextEntry: false, autoCapitalize: false, target: self, onChange: #selector(textFieldChanged(_:)))
        view.delegate = self
        view.backgroundColor = .quaternaryLabel.withAlphaComponent(0.1)
        view.layer.cornerRadius = Sizing.padding/2
        view.textAlignment = .center
        view.tag = 0
        return view
    }()
    
    lazy var lbsField: UITextField = {
        let view = ViewFactory.TextField.standard(withPlaceolder: "Lbs", textColor: .label, isSecureTextEntry: false, isTextEntry: false, autoCapitalize: false, target: self, onChange: #selector(textFieldChanged(_:)))
        view.delegate = self
        view.backgroundColor = .quaternaryLabel.withAlphaComponent(0.1)
        view.textAlignment = .center
        view.layer.cornerRadius = Sizing.padding/2
        view.tag = 1
        return view
    }()


    
    
    //MARK: -Helper Functions
    func setup() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        let view = self.contentView
        view.addSubview(setLbl)
        view.addSubview(repField)
        view.addSubview(lbsField)
        
        setLbl.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: nil, centerY: view.centerYAnchor, paddingTop: Sizing.padding, paddingLeft: Sizing.padding*2, paddingBottom: 0, paddingRight: 0, width: ContainerVC.btnWidth, height: ContainerVC.btnWidth)
        setLbl.layer.cornerRadius = ContainerVC.btnWidth/2
        
        
        let h = Fonts.standardBold.lineHeight*2
        lbsField.anchor(top: view.topAnchor, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: Sizing.padding/2, paddingLeft: 0, paddingBottom: Sizing.padding/2, paddingRight: Sizing.padding, width: Sizing.deviceWidth/5, height: h)
        
        repField.anchor(top: view.topAnchor, left: nil, bottom: view.bottomAnchor, right: lbsField.leftAnchor, paddingTop: Sizing.padding/2, paddingLeft: 0, paddingBottom: Sizing.padding/2, paddingRight: Sizing.padding/2, width: Sizing.deviceWidth/5, height: h)
    }
    
    func configure(set: LoggedSet, logVC: LogVC, index: Int) {
        self.logVC = logVC
        self.loggedSet = set
        self.setLbl.text = String(index + 1)
        
        if let r = set.reps {
            self.repField.text = String(r)
        } else {
            self.repField.text = nil
        }
        
        if let s = set.lbs {
            self.lbsField.text = String(s)
        } else {
            self.lbsField.text = nil
        }      
    }

    @objc func plusBtnTapped() {
        self.logVC?.addSet()
    }
    
    func updateTextFields(textField: UITextField?) {
        guard let logVC = logVC else {
            return
        }

        for cell in logVC.tableView.visibleCells {
            if let cell = cell as? SetCell {
                cell.lbsField.backgroundColor = UIColor.quaternaryLabel.withAlphaComponent(0.1)
                cell.lbsField.addShadow(offset: .zero, opacity: 0, radius: 0, color: .clear)
                
                cell.repField.backgroundColor = UIColor.quaternaryLabel.withAlphaComponent(0.1)
                cell.repField.addShadow(offset: .zero, opacity: 0, radius: 0, color: .clear)
            }
        }
        
        if let tf = textField {
            tf.backgroundColor = UIColor.systemBackground
            tf.addShadow(offset: .zero, opacity: 0.1, radius: 3, color: .label)
        }
    }
    
    @objc func textFieldChanged(_ textField: UITextField) {
        if let i = textField.text, let intI = Int(i) {
            if textField.tag == 0 {
                self.loggedSet.reps = intI
            } else {
                self.loggedSet.lbs = intI
            }
        } else {
            if textField.tag == 0 {
                self.loggedSet.reps = nil
            } else {
                self.loggedSet.lbs = nil
            }
        }
    }
}


extension SetCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("DID BEGIN")
        updateTextFields(textField: textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print("DID END: \(reason)")
        
        updateTextFields(textField: nil)
    }
}
