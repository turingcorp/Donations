import UIKit

class View:UIViewController {
    private var items = [Item]()
    private let presenter = Presenter()
    private weak var indicator:UIActivityIndicatorView!
    private weak var message:UILabel!
    private weak var refresh:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeOutlets()
        presenter.update = { [weak self] viewModel in
            self?.update(viewModel:viewModel)
        }
        presenter.refresh()
    }
    
    private func makeOutlets() {
        let indicator = UIActivityIndicatorView(style:.gray)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        view.addSubview(indicator)
        self.indicator = indicator
        
        let message = UILabel()
        message.translatesAutoresizingMaskIntoConstraints = false
        message.isUserInteractionEnabled = false
        message.numberOfLines = 0
        message.textAlignment = .center
        message.font = .systemFont(ofSize:20, weight:.light)
        message.textColor = .black
        view.addSubview(message)
        self.message = message
        
        let refresh = UIButton()
        refresh.translatesAutoresizingMaskIntoConstraints = false
        refresh.backgroundColor = .black
        refresh.setTitle(NSLocalizedString("View.refresh", comment:String()), for:[])
        refresh.setTitleColor(.white, for:.normal)
        refresh.setTitleColor(UIColor(white:1, alpha:0.2), for:.highlighted)
        refresh.layer.cornerRadius = 6
        refresh.titleLabel!.font = .systemFont(ofSize:16, weight:.bold)
        refresh.isHidden = true
        view.addSubview(refresh)
        self.refresh = refresh
        
        indicator.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo:view.centerYAnchor).isActive = true
        
        message.bottomAnchor.constraint(equalTo:indicator.topAnchor, constant:-40).isActive = true
        message.leftAnchor.constraint(equalTo:view.leftAnchor, constant:40).isActive = true
        message.rightAnchor.constraint(equalTo:view.rightAnchor, constant:-40).isActive = true
        
        refresh.topAnchor.constraint(equalTo:indicator.bottomAnchor, constant:40).isActive = true
        refresh.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        refresh.widthAnchor.constraint(equalToConstant:130).isActive = true
        refresh.heightAnchor.constraint(equalToConstant:38).isActive = true
    }
    
    private func update(viewModel:ViewModel) {
        message.text = viewModel.message
        refresh.isHidden = viewModel.refreshHidden
        indicator.isHidden = viewModel.indicatorHidden
        items = viewModel.items
    }
}
