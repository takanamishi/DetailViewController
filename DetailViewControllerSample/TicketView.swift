import UIKit

class TicketView: UIView {
    @IBOutlet weak var nameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initFromNib()
    }
    
    func setup(name: String) {
        nameLabel.text = name
    }
}
