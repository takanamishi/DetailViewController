import UIKit
import RxCocoa
import RxSwift

protocol PageLinkActionable : class {
    func jump(sectionType: ViewController.SectionType)
}

class PageLinkView: UIView {
    private(set) var buttonTypeRelay = BehaviorRelay<ViewController.SectionType>(value: .image)
    private weak var delegate: PageLinkActionable?
    private let disposeBag = DisposeBag()
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        buttonTypeRelay.subscribe(onNext: { [weak self] type in
            self?.changeDisplay(type: type)
        }).disposed(by: disposeBag)
    }
    
    func setup(delegate: PageLinkActionable?) {
        self.delegate = delegate
//        buttonTypeRelay.accept(.detail)
    }
    
    @IBAction func experienceClicked() {
//        delegate?.jump(sectionType: .experiences)
//        buttonTypeRelay.accept(.experiences)
    }
    
    @IBAction func detailClicked() {
//        delegate?.jump(sectionType: .detail)
//        buttonTypeRelay.accept(.detail)
    }
    
    @IBAction func ticketClicked() {
        delegate?.jump(sectionType: .tickets)
        buttonTypeRelay.accept(.tickets)
    }
    
    // FacilityViewController では、 PageLinkView を複数個で運用している為
    // 選択中のデザインを同期する為に、 FacilityViewController から操作できる
    // 公開メソッドにする
    func changeDisplay(type: ViewController.SectionType) {
        resetDisplay()
        let selectedColor = UIColor.red
        switch type {
        /*
        case .detail:
            detailButton.isSelected = true
            detailButtonBottomLineView.backgroundColor = selectedColor
        case .experiences:
            experienceButton.isSelected = true
            experienceButtonBottomLineView.backgroundColor = selectedColor
        */
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
    
    private func initFromNib() {
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
