import Foundation

public struct Item:Decodable {
    public let imageUrl:URL
    public let htmlText:String
    public let buttons:[Button]
}
