//
//  PlusCell.swift
//  Iron-challenge
//
//  Created by Ludovico Veniani on 9/5/22.
//


import UIKit

class PlusCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    //MARK: -Variables
    static let reuseID = "PlusCell"
    
    weak var logVC: LogVC?
    
    //MARK: -Views
    lazy var plusBtn: UIButton = {
        return ViewFactory.Button.image(image: ViewFactory.Image.plusFill, tint: .label, background: .clear, padding: 0, hideBackground: false, target: self, selector: #selector(plusBtnTapped))
    }()


    
    
    //MARK: -Helper Functions
    func setup() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        let view = self.contentView
        view.addSubview(plusBtn)
        
        plusBtn.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: Sizing.padding, paddingLeft: Sizing.padding*2, paddingBottom: Sizing.padding, paddingRight: 0, width: ContainerVC.btnWidth, height: ContainerVC.btnWidth)
    }
    
    func configure(logVC: LogVC) {
        self.logVC = logVC
      
    }

    @objc func plusBtnTapped() {
        self.logVC?.addSet()
    }
}


