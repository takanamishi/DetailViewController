//
//  ImageViewCell.swift
//  DetailViewControllerSample
//
//  Created by takanamishi on 2019/04/26.
//  Copyright © 2019 template. All rights reserved.
//

import UIKit

class ImageViewCell: UITableViewCell {
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var pageLinkView: PageLinkView!
    
    func setup(delegate: PageLinkActionable?) {
        pageLinkView.setup(delegate: delegate)
    }
}
