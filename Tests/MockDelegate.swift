import Foundation
import Donations

class MockDelegate:Delegate {
    var onRefreshed:(() -> Void)?
    var onDonationsError:(() -> Void)?
    
    func refreshed(list:List) {
        onRefreshed?()
    }
    
    func donations(error:Error) {
        onDonationsError?()
    }
}
