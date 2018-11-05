import Foundation
import Donations

class MockDelegate:Delegate {
    var onRefreshed:(() -> Void)?
    
    func refreshed(list:List) {
        onRefreshed?()
    }
}
