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
            tableView.register(nibWithCellClass: TicketsCell.self)
        }
    }
    @IBOutlet weak var scrollViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var navigationBar: UINavigationBar!
    private var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height
    }
    private var tableViewContentOffsetY: CGFloat {
        return tableView.contentOffset.y + statusBarHeight
    }
    private var isScrollOverImageViewCell: Bool {
        let imageViewCellHeight = UIScreen.main.bounds.width * 3 / 4
        return tableViewContentOffsetY > imageViewCellHeight - (statusBarHeight + navigationBar.frame.height)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 上には statusbar 分しか余白がないはずなのに * 2 しないとうまくいかない。
        scrollViewTopConstraint.constant = -statusBarHeight * 2
        
        navigationClear()
    }
    
    private func navigationClear() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.clear]
        navigationBar.tintColor = UIColor.white
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    enum SectionType: Int {
        case image = 0
        case tickets
        
        var numberOfRowsInSection: Int {
            switch self {
            case .image:
                return 1
            case .tickets:
                return 2
            }
        }
        
        static func get(section: Int) -> SectionType {
            guard let type = SectionType(rawValue: section) else {
                fatalError("指定されていないセクション")
            }
            
            return type
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SectionType.get(section: section).numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch SectionType.get(section: indexPath.section) {
        case .image:
            let cell = tableView.dequeueReusableCell(withClass: ImageViewCell.self, for: indexPath)
            return cell
        case .tickets:
            let cell = tableView.dequeueReusableCell(withClass: TicketsCell.self, for: indexPath)
            return cell
        }
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switchNavigation()
    }
    
    private func switchNavigation() {
        if isScrollOverImageViewCell {
            let boldFont = UIFont.boldSystemFont(ofSize: 16)
            navigationBar.titleTextAttributes = [ .font: boldFont, .foregroundColor: UIColor.white]
            navigationBar.setBackgroundImage(imageWithColor(.green), for: .default)
        } else {
            navigationClear()
        }
    }
    
    private func imageWithColor(_ color: UIColor) -> UIImage? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        view.backgroundColor = color
        UIGraphicsBeginImageContext(view.frame.size)
        guard let context: CGContext = UIGraphicsGetCurrentContext() else {
            return nil
        }
        view.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
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
