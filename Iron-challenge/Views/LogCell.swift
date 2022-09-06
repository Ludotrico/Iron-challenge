//
//  LogCell.swift
//  Iron-challenge
//
//  Created by Ludovico Veniani on 9/5/22.
//

import UIKit

class LogCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    //MARK: -Variables
    static let reuseID = "LogCell"
    
    
    //MARK: -Views
    let primaryLbl: PaddingLabel = {
        let view = ViewFactory.Label.standard(text: "", font: Fonts.standardBold, alignment: .left, numberOfLines: 1)
        return view
    }()

    let secondaryLbl: PaddingLabel = {
        let view = ViewFactory.Label.standard(text: "", font: Fonts.standard, alignment: .left, numberOfLines: 0)
        return view
    }()
    
    let dateLbl: PaddingLabel = {
        let view = ViewFactory.Label.standard(text: "", font: Fonts.standard, textColor: .secondaryLabel, alignment: .left, numberOfLines: 0)
        return view
    }()
    
    let editBt = ViewFactory.Button.text(text: "Edit", font: Fonts.standardBold, textColor: .label)
    
    let topSeperator = ViewFactory.View.standard(backgroundColor: .quaternaryLabel)
    let bottomSeperator = ViewFactory.View.standard(backgroundColor: .quaternaryLabel)

    
    
    //MARK: -Helper Functions
    func setup() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        let view = self.contentView
        view.addSubview(primaryLbl)
        view.addSubview(secondaryLbl)
        view.addSubview(dateLbl)
        view.addSubview(editBt)
        view.addSubview(topSeperator)
        view.addSubview(bottomSeperator)
        
        
        topSeperator.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: Sizing.padding, paddingBottom: 0, paddingRight: Sizing.padding, width: 0, height: 1)
        
        bottomSeperator.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: Sizing.padding, paddingBottom: 0, paddingRight: Sizing.padding, width: 0, height: 1)
        
        primaryLbl.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: Sizing.padding, paddingLeft: Sizing.padding, paddingBottom: 0, paddingRight: 0)
        
        secondaryLbl.anchor(top: primaryLbl.bottomAnchor, left: primaryLbl.leftAnchor, bottom: nil, right: primaryLbl.rightAnchor, paddingTop: Sizing.padding/2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        dateLbl.anchor(top: secondaryLbl.bottomAnchor, left: primaryLbl.leftAnchor, bottom: view.bottomAnchor, right: primaryLbl.rightAnchor, paddingTop: Sizing.padding, paddingLeft: 0, paddingBottom: Sizing.padding, paddingRight: 0)
        
        editBt.anchor(top: nil, left: nil, bottom: nil, right: view.rightAnchor, centerY: view.centerYAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: Sizing.padding)
    }
    
    func configure(liftLog: LiftLog, index: Int) {
        topSeperator.isHidden = index > 0
        
        primaryLbl.text = liftLog.name
        
        var secondaryText = ""
        for (i, log) in liftLog.sets.enumerated() {
            secondaryText += "\(i+1). \(log.reps!) Reps, \(log.lbs!) Lbs\n"
        }
        secondaryText.removeLast()
        
        secondaryLbl.text = secondaryText
        
        dateLbl.text = "\(liftLog.date.simplifyDelta(pastDate: Date(), showNow: false, extraAccurate: false)) ago"
       
      
    }

}


