import Foundation

public protocol Delegate:AnyObject {
    func refreshed(list:List)
    func donations(error:Error)
}
