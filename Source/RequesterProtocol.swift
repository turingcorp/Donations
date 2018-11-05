import Foundation

protocol RequesterProtocol {
    func refresh(success:@escaping((List) -> Void))
}
