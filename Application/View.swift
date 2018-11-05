import UIKit

class View:UIViewController {
    private let presenter = Presenter()
    private weak var indicator:UIActivityIndicatorView!
    private weak var message:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeOutlets()
        presenter.refresh()
    }
    
    private func makeOutlets() {
        let indicator = UIActivityIndicatorView(style:.gray)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        self.indicator = indicator
        view.addSubview(indicator)
        
        let message = UILabel()
        message.translatesAutoresizingMaskIntoConstraints = false
        message.isUserInteractionEnabled = false
        message.numberOfLines = 0
        self.message = message
        view.addSubview(message)
        
        indicator.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo:view.centerYAnchor).isActive = true
        
        message.bottomAnchor.constraint(equalTo:indicator.topAnchor, constant:-20).isActive = true
        message.leftAnchor.constraint(equalTo:view.leftAnchor, constant:20).isActive = true
        message.rightAnchor.constraint(equalTo:view.rightAnchor, constant:20).isActive = true
    }
}
