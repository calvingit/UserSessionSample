//
//  UserSessionViewController.swift
//  UserSessionSample
//
//  Created by zen on 08/08/15.
//  Copyright (c) 2015 dimazen. All rights reserved.
//

import UIKit

class UserSessionViewController: UIViewController {

    @IBOutlet
    weak private var userSessionLabel: UILabel!
    
    private func updateVisibleState() {
        userSessionLabel.text = userSession?.identifier
        title = userSession?.identifier
    }
    
    var userSession: UserSession? {
        didSet {
            if isViewLoaded {
                updateVisibleState()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let barItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(UserSessionViewController.logout))
        self.navigationItem.leftBarButtonItem = barItem;
        updateVisibleState()
    }
    
    var didSelectLogout: ((UIViewController) -> Void)?
    
    @objc func logout() {
        didSelectLogout?(self)
    }
}

