//
//  HomeViewController.swift
//  RestAPIPOC
//
//  Created by Siddharth Kumar on 07/10/20.
//  Copyright © 2020 MyOrganisation. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
    }

}

private extension HomeViewController {
    
    func setNavigationTitle(_ title: String? = nil) {
        self.navigationItem.title = title ?? "About Canada"
    }
    
}
