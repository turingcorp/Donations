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
    }
    
    func refreshed(list:List) {
        
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
        return viewModel
    }
}
