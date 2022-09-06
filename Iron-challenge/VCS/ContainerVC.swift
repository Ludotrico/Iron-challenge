//
//  MainVC.swift
//  Iron-challenge
//
//  Created by Ludovico Veniani on 9/5/22.
//

import UIKit

class ContainerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Sizing.initialize(frame: self.view.frame, navBarFrame: self.navigationController!.navigationBar.frame)

        configure()
    }
    
    // MARK: - State
    var logs: [LiftLog] = []
    
    static let btnWidth = Fonts.navigationTitle.lineHeight * (2/3)
    
    // MARK: - Views
    lazy var titleLbl: PaddingLabel = {
        return ViewFactory.Label.standard(text: "My Log", font: Fonts.navigationTitle, textColor: .label, alignment: .left, numberOfLines: 1)
    }()
    
    var noResultsLbl: PaddingLabel = {
        return ViewFactory.Label.standard(text: "No Sets Logged", font: Fonts.standard, textColor: .secondaryLabel, alignment: .center, numberOfLines: 1)
    }()
    
    lazy var plusBtn: UIButton = {
        return ViewFactory.Button.image(image: ViewFactory.Image.plusFill, tint: .label, background: .clear, padding: 0, hideBackground: false, target: self, selector: #selector(plusBtnTapped))
    }()
    
    lazy var tableView: UITableView = {
        let view = ViewFactory.Table.standard(dataSource: self, delegate: self, bgColor: .clear, showScrollIndicator: false)
        
        view.register(LogCell.self, forCellReuseIdentifier: LogCell.reuseID)
        return view
    }()
    
    
    // MARK: - Functions
    func configure() {
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        
        view.addSubview(titleLbl)
        view.addSubview(plusBtn)
        view.addSubview(tableView)
        view.addSubview(noResultsLbl)
        
        
        titleLbl.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: Sizing.padding, paddingLeft: Sizing.padding, paddingBottom: 0, paddingRight: 0, width: 0, height: Fonts.navigationTitle.lineHeight)
        
        
        plusBtn.anchor(top: nil, left: nil, bottom: nil, right: view.rightAnchor, centerY: titleLbl.centerYAnchor, paddingTop: Sizing.padding, paddingLeft: Sizing.padding, paddingBottom: 0, paddingRight: Sizing.padding, width: Self.btnWidth, height: Self.btnWidth)
        
        tableView.anchor(top: titleLbl.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: Sizing.padding, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        noResultsLbl.pinEdges(to: self.view)
        
        updateTableView()
    }
    
    func updateTableView() {
        Self.getLogs() { logs in
            self.logs = logs ?? []
            
            self.tableView.isHidden = self.logs.isEmpty
            self.noResultsLbl.isHidden = !self.logs.isEmpty

            self.tableView.reloadData()
        }
    }
    
    static func getLogs(completion: (([LiftLog]?) -> Void)?=nil) {
        CacheManager.getObjects(key: .liftLogs) { (logs:[LiftLog]?) in
            completion?(logs)
        }
    }
    
    // MARK: - Selectors
    @objc func plusBtnTapped() {
        let logVC = LogVC()
        logVC.configure(containerVC: self)
        logVC.modalPresentationStyle = .fullScreen
        present(logVC, animated: true)
    }

}

// MARK: - Delegates
extension ContainerVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.logs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LogCell.reuseID, for: indexPath) as! LogCell
        cell.configure(liftLog: self.logs[indexPath.row], index: indexPath.row)
        return cell
    }
}
