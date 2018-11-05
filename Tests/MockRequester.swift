import Foundation
@testable import Donations

class MockRequester:RequesterProtocol {
    var onRefresh:(() -> Void)?
    var list = List(items:[])
    
    func refresh(success:@escaping((List) -> Void)) {
        onRefresh?()
        success(list)
    }
}
