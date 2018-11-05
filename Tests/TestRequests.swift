import XCTest
@testable import Donations

class TestRequests:XCTestCase {
    private var donations:Donations!
    private var requester:MockRequester!
    private var delegate:MockDelegate!
    
    override func setUp() {
        donations = Donations()
        requester = MockRequester()
        delegate = MockDelegate()
        donations.requester = requester
        donations.delegate = delegate
    }
    
    func testSuccessNotifiesDelegate() {
        let expectRequest = expectation(description:String())
        let expectDelegate = expectation(description:String())
        requester.onRefresh = {
            expectRequest.fulfill()
        }
        delegate.onRefreshed = {
            XCTAssertEqual(Thread.main, Thread.current)
            expectDelegate.fulfill()
        }
        DispatchQueue.global(qos:.background).async { self.donations.refresh() }
        waitForExpectations(timeout:1)
    }
}
