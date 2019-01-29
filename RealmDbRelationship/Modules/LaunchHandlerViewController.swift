//
//  LaunchHandlerViewController.swift
//  RealmDbRelationship
//
//  Created by Rifat Firdaus on 19/12/18.
//  Copyright © 2018 Rifat Firdaus. All rights reserved.
//

import UIKit

class LaunchHandlerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let controller = SearchFilterViewController.instantiate()
        present(controller, animated: true, completion: nil)
    }
    
}
