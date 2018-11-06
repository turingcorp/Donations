import UIKit

class Item {
    var image:UIImage?
    var donateHidden = true
    var facebookHidden = true
    var refreshHidden = true
    var text = String()
    var donateMessage = String()
    var facebookMessage = String()
    var refreshMessage = String()
    let url:URL
    
    init(url:URL) {
        self.url = url
    }
}
