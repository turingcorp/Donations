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
    
    func refresh(success:@escaping((List) -> Void), fail:@escaping((Error) -> Void)) {
        task?.cancel()
        task = session.dataTask(with:request) { data, response, error in
            if let error = error {
                fail(error)
            } else if (response as? HTTPURLResponse)?.statusCode != 200 {
                fail(Exception.invalidHTTPcode)
            } else if let data = data {
                if data.isEmpty {
                    fail(Exception.emptyResponse)
                } else {
                    do {
                        success(try JSONDecoder().decode(List.self, from:data))
                    } catch let jsonError {
                        fail(jsonError)
                    }
                }
            } else {
                fail(Exception.invalidResponse)
            }
        }
        task?.resume()
    }
}
