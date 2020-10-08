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
    lazy var countryInfoViewModel = CountryInfoViewModel()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        return activityIndicator
    }()
    
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refreshControl.tintColor = .lightGray
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        registerCell()
        setNavigationTitle()
        countryInfoViewModel.delegate = self
        countryInfoViewModel.getCountryInfo()
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
        infoTableView.delegate = self
        infoTableView.allowsSelection = false
        infoTableView.addSubview(refreshControl)
    }
    
    func setNavigationTitle(_ title: String? = nil) {
        self.navigationItem.title = title
    }
    
    func registerCell() {
        infoTableView.register(InfoTableViewCell.self, forCellReuseIdentifier: "InfoTableViewCell")
    }
    
    func startLoader() {
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return  }
            weakSelf.infoTableView.isHidden = true
            weakSelf.view.addSubview(weakSelf.activityIndicatorView)
            weakSelf.activityIndicatorView.configureForAutoLayout()
            weakSelf.activityIndicatorView.autoAlignAxis(.vertical, toSameAxisOf: weakSelf.view)
            weakSelf.activityIndicatorView.autoAlignAxis(.horizontal, toSameAxisOf: weakSelf.view)
            weakSelf.activityIndicatorView.startAnimating()
        }
    }
    
    func stopLoader() {
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return  }
            weakSelf.infoTableView.isHidden = false
            weakSelf.activityIndicatorView.stopAnimating()
            weakSelf.activityIndicatorView.removeFromSuperview()
        }
    }
    
    func showErrorAlert(title: String = "Error", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alertAction) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func handleRefresh() {
        countryInfoViewModel.getCountryInfo()
        refreshControl.endRefreshing()
    }
    
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryInfoViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as! InfoTableViewCell
        countryInfoViewModel.configureCell(cell: cell, index: indexPath.row)
        countryInfoViewModel.showImageForCell(cell: cell, index: indexPath.row, completion: { [weak self] in
            self?.infoTableView.reloadRows(at: [indexPath], with: .none)
        })
        return cell
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension HomeViewController: CountryInfoViewModelDelegate {
    
    func fetchCountryInfoStarted() {
        startLoader()
    }
    
    func fetchCountryInfoEnded() {
        DispatchQueue.main.async { [weak self] in
            self?.infoTableView.reloadData()
            self?.setNavigationTitle(self?.countryInfoViewModel.screenTitle())
        }
        stopLoader()
    }
    
    func fetchCountryEndedWithError(error: Error?, code: Int) {
        var message = ""
        if let error = error as NSError? {
            message = error.localizedDescription
        } else if let error = error as? NetworkService.NetworkError {
            message = error.localizedDescription
        }
        DispatchQueue.main.async { [weak self] in
            self?.showErrorAlert(message: message)
        }
    }
}
