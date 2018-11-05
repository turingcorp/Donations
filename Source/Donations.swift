import Foundation

public class Donations {
    public weak var delegate:Delegate?
    var requester:RequesterProtocol = Requester()
    
    public init() { }
    
    public func refresh() {
        requester.refresh(success: { list in
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.refreshed(list:list)
            }
        }) { error in
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.donations(error:error)
            }
        }
    }
}
