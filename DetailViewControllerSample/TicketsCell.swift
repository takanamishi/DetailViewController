//
//  TicketCell.swift
//  DetailViewControllerSample
//
//  Created by takanamishi on 2019/04/26.
//  Copyright © 2019 template. All rights reserved.
//

import UIKit

class TicketsCell: UITableViewCell {
    @IBOutlet weak var ticketsStackView: UIStackView!
    
    func setup(tickets: [String]) {
        for view in ticketsStackView.arrangedSubviews {
            ticketsStackView.removeArrangedSubview(view)
        }

        for ticket in tickets {
            let view = TicketView()
            view.setup(name: ticket)
            ticketsStackView.addArrangedSubview(view)
        }
    }
}
