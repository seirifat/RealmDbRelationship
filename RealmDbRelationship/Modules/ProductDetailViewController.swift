//
//  ProductDetailViewController.swift
//  RealmDbRelationship
//
//  Created by Rifat Firdaus on 28/01/19.
//  Copyright © 2019 Rifat Firdaus. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var labelDesc: UILabel!
    @IBOutlet private weak var labelPrimaryApplication: UILabel!
    @IBOutlet private weak var labelApplication: UILabel!
    
    var product: Product!
    
    static func instance(product: Product) -> UINavigationController {
        let controller = ProductDetailViewController(nibName: self.className(), bundle: nil)
        controller.product = product
        let nav = ViewManager.createNavigationController(rootController: controller)
        return nav
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackBarButtonItems()
        
        setupView()
    }
    
    func setupView() {
        if let product = product {
            
            labelDesc.numberOfLines = 0
            labelTitle.text = product.name ?? ""
            
            labelDesc.numberOfLines = 0
            let stringSakuraNumber = "Sakura Number : \(product.id ?? "")\n"
            let stringType = "Type : \(product.type ?? "")\n"
            labelDesc.text = stringSakuraNumber + stringType
            
            let primaryApps = product.originalsList.map({ $0.name ?? ""})
            labelPrimaryApplication.numberOfLines = 0
            labelPrimaryApplication.text = primaryApps.joined(separator: "\n")
            
            let vehicle = product.vehiclesList.map({ $0.name ?? ""})
            labelApplication.numberOfLines = 0
            labelApplication.text = vehicle.joined(separator: "\n")
        }
    }
    
}
