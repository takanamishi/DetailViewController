//
//  ViewController.swift
//  DetailViewControllerSample
//
//  Created by takanamishi on 2019/04/26.
//  Copyright © 2019 template. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(nibWithCellClass: ImageViewCell.self)
        }
    }
    @IBOutlet weak var scrollViewTopConstraint: NSLayoutConstraint!
    private var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 上には statusbar 分しか余白がないはずなのに * 2 しないとうまくいかない。
        scrollViewTopConstraint.constant = -statusBarHeight * 2
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ImageViewCell.self, for: indexPath)
        return cell
    }
}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: name))")
        }
        return cell
    }
    
    func register<T: UITableViewCell>(nibWithCellClass name: T.Type, at bundleClass: AnyClass? = nil) {
        let identifier = String(describing: name)
        var bundle: Bundle?
    
        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }
    
        register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
    }
}
