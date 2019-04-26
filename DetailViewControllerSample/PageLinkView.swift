import UIKit

protocol PageLinkActionable : class {
    func jump(sectionType: ViewController.SectionType)
}

class PageLinkView: UIView {
    private weak var delegate: PageLinkActionable?

    @IBOutlet weak var experienceButton: UIButton!
    @IBOutlet weak var experienceButtonBottomLineView: UIView!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var detailButtonBottomLineView: UIView!
    @IBOutlet weak var ticketView: UIView!
    @IBOutlet weak var ticketButton: UIButton!
    @IBOutlet weak var ticketButtonBottomLineView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initFromNib()
    }
    
    func setup(delegate: PageLinkActionable?) {
        self.delegate = delegate
        changeDisplay(type: .basicInformation)
    }
    
    @IBAction func experienceClicked() {
        delegate?.jump(sectionType: .experiences)
        changeDisplay(type: .experiences)
    }
    
    @IBAction func basicInformationClicked() {
        delegate?.jump(sectionType: .basicInformation)
        changeDisplay(type: .basicInformation)
    }
    
    @IBAction func ticketClicked() {
        delegate?.jump(sectionType: .tickets)
        changeDisplay(type: .tickets)
    }
    
    func changeDisplay(type: ViewController.SectionType) {
        resetDisplay()
        let selectedColor = UIColor.red
        switch type {
        case .basicInformation:
            detailButton.isSelected = true
            detailButtonBottomLineView.backgroundColor = selectedColor
        case .experiences:
            experienceButton.isSelected = true
            experienceButtonBottomLineView.backgroundColor = selectedColor
        case .tickets:
            ticketButton.isSelected = true
            ticketButtonBottomLineView.backgroundColor = selectedColor
        default:
            break
        }
    }
    
    private func resetDisplay() {
        experienceButton.isSelected = false
        experienceButtonBottomLineView.backgroundColor = UIColor.white
        detailButton.isSelected = false
        detailButtonBottomLineView.backgroundColor = UIColor.white
        ticketButton.isSelected = false
        ticketButtonBottomLineView.backgroundColor = UIColor.white
    }
}

extension UIView {
    func initFromNib() {
        let bundle = Bundle(for: type(of: self))
        let className = String(describing: type(of: self))
        let nib = UINib(nibName: className, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                      options:NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                      metrics:nil,
                                                      views: bindings))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                      options:NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                      metrics:nil,
                                                      views: bindings))
    }
}
