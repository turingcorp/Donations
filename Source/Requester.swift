import Foundation

class Requester:RequesterProtocol {
    private weak var task:URLSessionDataTask?
    private let session = URLSession(configuration:.ephemeral)
    private let request:URLRequest
    private static let timeout = 15.0
    private static let json = "https://media.sharethemeal.org/42/stmtask.json"
    
    init() {
        var request = URLRequest(url:URL(string:Requester.json)!, cachePolicy:
            .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval:Requester.timeout)
        request.allowsCellularAccess = true
        self.request = request
    }
    
    func refresh(success:@escaping((List) -> Void)) {
        task?.cancel()
        task = session.dataTask(with:request) { data, response, error in
            guard
                let data = data,
                let list = try? JSONDecoder().decode(List.self, from:data)
            else { return }
            success(list)
        }
        task?.resume()
    }
}
