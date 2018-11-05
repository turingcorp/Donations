import XCTest
@testable import Donations

class TestParsing:XCTestCase {
    private let json = "{\"items\": [{\"imageUrl\": \"https://wikipedia.com\", \"htmlText\": \"<h2>Lorem ipsum</h2>\",\"buttons\": [{\"action\": \"donate\",\"text\": \"Donate\"}, {\"action\": \"refresh\", \"text\": \"Refresh\" }, {\"action\": \"facebook\",\"text\": \"Open facebook\"}]}]}"
    
    func testParseItems() {
        let list = try! JSONDecoder().decode(List.self, from:json.data(using:.utf8)!)
        XCTAssertEqual(URL(string:"https://wikipedia.com")!, list.items.first!.imageUrl)
        XCTAssertEqual("<h2>Lorem ipsum</h2>", list.items.first!.htmlText)
        XCTAssertEqual(3, list.items.first!.buttons.count)
        XCTAssertEqual(Action.donate, list.items.first!.buttons[0].action)
        XCTAssertEqual("Donate", list.items.first!.buttons[0].text)
        XCTAssertEqual(Action.refresh, list.items.first!.buttons[1].action)
        XCTAssertEqual("Refresh", list.items.first!.buttons[1].text)
        XCTAssertEqual(Action.facebook, list.items.first!.buttons[2].action)
        XCTAssertEqual("Open facebook", list.items.first!.buttons[2].text)
    }
}
