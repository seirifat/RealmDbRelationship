//
//  SearchFilterViewController.swift
//  RealmDbRelationship
//
//  Created by Rifat Firdaus on 25/01/19.
//  Copyright © 2019 Rifat Firdaus. All rights reserved.
//

import UIKit
import RealmSwift

class SearchFilterViewController: UIViewController {

    @IBOutlet private var textFieldSearch: UITextField!
    @IBOutlet private var stackViewResult: UIStackView!
    
    var data = [Product]()
    
    static func instantiate() -> SearchFilterViewController {
        let controller = SearchFilterViewController(nibName: self.className(), bundle: nil)
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldSearch.addDoneButtonOnKeyboard()
    }

    @IBAction private func buttonSearchPressed(_ sender: UIButton) {
        let realm = try! Realm()
        let filter = "id CONTAINS '\(textFieldSearch.text ?? "")' OR ANY originalsList.id CONTAINS '\(textFieldSearch.text ?? "")' OR ANY vehiclesList.name CONTAINS '\(textFieldSearch.text ?? "")'"
        print(filter)
        stackViewResult.arrangedSubviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
        let result = realm.objects(Product.self).filter(filter)
        
        var iteration = 0
        result.forEach { (prod) in
            let product = Product(value: prod.detached())
            let buttonProduct = UIButton(type: .system)
            buttonProduct.contentHorizontalAlignment = .left
            buttonProduct.setTitle("\(product.id ?? "") -- \(product.name ?? "")", for: .normal)
            buttonProduct.tag = iteration
            iteration += 1
            buttonProduct.addTarget(self, action: #selector(productPressed(_:)), for: .touchUpInside)
            stackViewResult.addArrangedSubview(buttonProduct)
            data.append(product)
        }
    }
    
    @objc func productPressed(_ sender: UIButton) {
        let controller = ProductDetailViewController.instance(product: data[sender.tag])
        present(controller, animated: true, completion: nil)
    }
    
}
