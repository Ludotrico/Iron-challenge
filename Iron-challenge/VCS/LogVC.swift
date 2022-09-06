//
//  LogVC.swift
//  Iron-challenge
//
//  Created by Ludovico Veniani on 9/5/22.
//

import UIKit

class LogVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    
    // MARK: - State
    weak var containerVC: ContainerVC?
    var log: LiftLog = .init(name: "", sets: [.init(reps: nil, lbs: nil)], date: Date())
  
    
    // MARK: - Views
    var sLbl: UILabel!

    lazy var titleLbl: PaddingLabel = {
        return ViewFactory.Label.standard(text: "Log Sets", font: Fonts.navigationTitle, textColor: .label, alignment: .center, numberOfLines: 1)
    }()
    
    var secondaryTitleLabel: PaddingLabel = {
        return ViewFactory.Label.standard(text: "Performance", font: Fonts.small, textColor: .secondaryLabel, alignment: .center, numberOfLines: 1)
    }()
    
    lazy var closeBtn: UIButton = {
        return ViewFactory.Button.image(image: ViewFactory.Image.xmark, tint: .label, background: .clear, padding: 0, hideBackground: false, target: self, selector: #selector(closeBtnTapped))
    }()
    
    lazy var tableView: UITableView = {
        let view = ViewFactory.Table.standard(dataSource: self, delegate: self, bgColor: .clear, showScrollIndicator: false)
        
        view.register(PlusCell.self, forCellReuseIdentifier: PlusCell.reuseID)
        view.register(SetCell.self, forCellReuseIdentifier: SetCell.reuseID)
        return view
    }()
    
    lazy var logSetsBtn: UIButton = {
        let btn = ViewFactory.Button.text(text: "Log Sets", font: Fonts.standardBold, textColor: .systemBackground, target: self, selector: #selector(logSetsBtnTapped))
        btn.backgroundColor = .label
        
        return btn
    }()
    
    var exerciseLbl: PaddingLabel = {
        return ViewFactory.Label.standard(text: "Exercise", font: Fonts.standard, textColor: .secondaryLabel, alignment: .left, numberOfLines: 1)
    }()
    
    var container: UIView = {
        let view = ViewFactory.View.standard(backgroundColor: .clear)
        view.layer.borderColor = UIColor.quaternaryLabel.cgColor
        view.layer.borderWidth = 1
        
        return view
    }()
    
    lazy var textField: UITextField = {
        return ViewFactory.TextField.standard(withPlaceolder: "Bench Press, Deadlift, Squat", textColor: .label, isSecureTextEntry: false, isTextEntry: true, autoCapitalize: true, target: self, onChange: #selector(textFieldChanged(_:)))
    }()
    
    
    // MARK: - Functions
    func configure(containerVC: ContainerVC) {
        self.containerVC = containerVC
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        
        view.addSubview(closeBtn)
        view.addSubview(titleLbl)
        view.addSubview(secondaryTitleLabel)
        view.addSubview(logSetsBtn)
        view.addSubview(tableView)
        view.addSubview(exerciseLbl)
        view.addSubview(container)
        view.addSubview(textField)
        
        
        
        closeBtn.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: Sizing.padding, paddingLeft: Sizing.padding, paddingBottom: 0, paddingRight: Sizing.padding, width: ContainerVC.btnWidth, height: ContainerVC.btnWidth)
        
        secondaryTitleLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, centerX: view.centerXAnchor, centerY: closeBtn.centerYAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        titleLbl.anchor(top: closeBtn.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: view.centerXAnchor, paddingTop: Sizing.padding, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: Fonts.navigationTitle.lineHeight)
        
        exerciseLbl.anchor(top: titleLbl.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: Sizing.padding*2, paddingLeft: Sizing.padding, paddingBottom: 0, paddingRight: 0, width: 0, height: Fonts.standard.lineHeight)
        
        
        container.anchor(top: exerciseLbl.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: Sizing.padding/2, paddingLeft: Sizing.padding, paddingBottom: 0, paddingRight: Sizing.padding, width: 0, height: Fonts.standardBold.lineHeight*2.5)
        container.layer.cornerRadius = Sizing.padding
        
        textField.pinEdges(to: container, padding: Sizing.padding)
        
        let height = Fonts.standardBold.lineHeight*2
        logSetsBtn.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: Sizing.padding, paddingBottom: 0, paddingRight: Sizing.padding, width: 0, height: height)
        logSetsBtn.layer.cornerRadius = height/2
        
        
        
        let bubble1 = ViewFactory.View.standard(backgroundColor: .clear)
        let bubble2 = ViewFactory.View.standard(backgroundColor: .clear)
        let bubble3 = ViewFactory.View.standard(backgroundColor: .clear)
        
        view.addSubview(bubble1)
        view.addSubview(bubble2)
        view.addSubview(bubble3)
        
        bubble1.anchor(top: container.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: Sizing.padding, paddingLeft: Sizing.padding*2, paddingBottom: 0, paddingRight: 0, width: ContainerVC.btnWidth, height: ContainerVC.btnWidth)
        
        bubble3.anchor(top: container.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: Sizing.padding, width: view.frame.width/5, height: 1)
        
        bubble2.anchor(top: container.bottomAnchor, left: nil, bottom: nil, right: bubble3.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: Sizing.padding/2, width: view.frame.width/5, height: 1)
        
        
        let setsLbl = ViewFactory.Label.standard(text: "Sets", font: Fonts.standardBold, textColor: .secondaryLabel, alignment: .center, numberOfLines: 1)
        let repsLbl = ViewFactory.Label.standard(text: "Reps", font: Fonts.standardBold, textColor: .secondaryLabel, alignment: .center, numberOfLines: 1)
        let lbsLbl = ViewFactory.Label.standard(text: "Lbs", font: Fonts.standardBold, textColor: .secondaryLabel, alignment: .center, numberOfLines: 1)
        
        view.addSubview(setsLbl)
        view.addSubview(repsLbl)
        view.addSubview(lbsLbl)
        
        setsLbl.anchor(top: container.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: bubble1.centerXAnchor, paddingTop: Sizing.padding*2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: Fonts.standard.lineHeight)
        repsLbl.anchor(top: container.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: bubble2.centerXAnchor, paddingTop: Sizing.padding*2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        lbsLbl.anchor(top: container.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: bubble3.centerXAnchor, paddingTop: Sizing.padding*2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)

        self.tableView.anchor(top: setsLbl.bottomAnchor, left: self.view.leftAnchor, bottom: self.logSetsBtn.topAnchor, right: self.view.rightAnchor, paddingTop: Sizing.padding/2, paddingLeft: 0, paddingBottom: Sizing.padding/2, paddingRight: 0)
        
    }
    
    func addSet() {
        self.view.endEditing(true)
        self.log.sets.append(.init(reps: nil, lbs: nil))
        self.tableView.reloadData()
        
    }
    

    
    // MARK: - Selectors
    @objc func closeBtnTapped() {
        self.dismiss(animated: true)
    }
    
    @objc func logSetsBtnTapped() {
        guard let containerVC = containerVC else {
            return
        }

        if !self.log.name.isEmpty && !self.log.sets.filter({$0.reps != nil && $0.lbs != nil}).isEmpty {
            
            
            CacheManager.insertObject(objects:  [self.log] + containerVC.logs, for: .liftLogs, expiryTimeType: nil, completion: { _ in
                DispatchQueue.main.async {
                    self.containerVC?.updateTableView()
                    self.dismiss(animated: true)
                }
    
            })
  
        }
    }
    
    @objc func textFieldChanged(_ textField: UITextField) {
        self.log.name = textField.text ?? ""
    }

}

// MARK: - Delegates
extension LogVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.log.sets.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == self.log.sets.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: PlusCell.reuseID, for: indexPath) as! PlusCell
            cell.configure(logVC: self)
            return cell
        }


        let cell = tableView.dequeueReusableCell(withIdentifier: SetCell.reuseID, for: indexPath) as! SetCell
        cell.configure(set: self.log.sets[indexPath.row], logVC: self, index: indexPath.row)
        return cell
    }
}

