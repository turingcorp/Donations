import Foundation
@testable import Donations

class MockRequester:RequesterProtocol {
    var onRefresh:(() -> Void)?
    var list = List(items:[])
    var error:Error?
    
    func refresh(success:@escaping((List) -> Void), fail:@escaping((Error) -> Void)) {
        onRefresh?()
        if let error = error {
            fail(error)
        } else {
            success(list)
        }
    }
}
