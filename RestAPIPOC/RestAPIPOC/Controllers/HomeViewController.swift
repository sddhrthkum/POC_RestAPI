//
//  HomeViewController.swift
//  RestAPIPOC
//
//  Created by Siddharth Kumar on 07/10/20.
//  Copyright © 2020 MyOrganisation. All rights reserved.
//

import UIKit
import PureLayout

class HomeViewController: UIViewController {

    lazy var infoTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        registerCell()
        setNavigationTitle()
    }

}

private extension HomeViewController {
    
    func setUpUI() {
        setupTableView()
        self.view.addSubview(infoTableView)
        infoTableView.configureForAutoLayout()
        infoTableView.autoPinEdge(.top, to: .top, of: self.view)
        infoTableView.autoPinEdge(.bottom, to: .bottom, of: self.view)
        infoTableView.autoPinEdge(.left, to: .left, of: self.view)
        infoTableView.autoPinEdge(.right, to: .right, of: self.view)
    }
    
    func setupTableView() {
        infoTableView.separatorStyle = .none
        infoTableView.dataSource = self
        infoTableView.allowsSelection = false
    }
    
    func setNavigationTitle(_ title: String? = nil) {
        self.navigationItem.title = title ?? "About Canada"
    }
    
    func registerCell() {
        infoTableView.register(InfoTableViewCell.self, forCellReuseIdentifier: "InfoTableViewCell")
    }
    
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as! InfoTableViewCell
        cell.title = "Siddharth"
        cell.messageDescription = "He is a programmer who loves palying with code. He works in Techjini Solutions."
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
