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
        viewModel.items = list.items.map { return itemFor(donation:$0) }
        return viewModel
    }
    
    private func itemFor(donation:Donation) -> Item {
        let item = Item(url:donation.imageUrl)
        item.text = stringFor(htmlText:donation.htmlText)
        donation.buttons.forEach { button in
            switch button.action {
            case .donate:
                item.donateHidden = false
                item.donateMessage = button.text
            case .refresh:
                item.refreshHidden = false
                item.refreshMessage = button.text
            case .facebook:
                item.facebookHidden = false
                item.facebookMessage = button.text
            }
        }
        return item
    }
    
    private func stringFor(htmlText:String) -> NSAttributedString {
        if let string = try? NSAttributedString(data:htmlText.data(using:.utf8)!, options:
            [.documentType:NSAttributedString.DocumentType.html], documentAttributes:nil) {
            return string
        }
        return NSAttributedString()
    }
}
