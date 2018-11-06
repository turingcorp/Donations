import Foundation
import Donations

class Presenter:Delegate {
    var update:((ViewModel) -> Void)?
    private let donations = Donations()
    
    init() {
        donations.delegate = self
    }
    
    @objc func refresh() {
        update?(loading())
        donations.refresh()
    }
    
    func refreshed(list:List) {
        update?(donations(list:list))
    }
    
    func donations(error:Error) {
        
    }
    
    private func loading() -> ViewModel {
        var viewModel = ViewModel()
        viewModel.indicatorHidden = false
        viewModel.message = NSLocalizedString("Presenter.loading", comment:String())
        return viewModel
    }
    
    private func error() -> ViewModel {
        var viewModel = ViewModel()
        return viewModel
    }
    
    private func donations(list:List) -> ViewModel {
        var viewModel = ViewModel()
        viewModel.items = list.items.map { donation in
            let item = Item(url:donation.imageUrl)
            if let text = try? NSAttributedString(data:donation.htmlText.data(using:.utf8)!, options:
                [.documentType:NSAttributedString.DocumentType.html], documentAttributes:nil) {
                item.text = text
            }
            return item
        }
        return viewModel
    }
}
