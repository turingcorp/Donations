import Foundation

public struct Donation:Decodable {
    public let imageUrl:URL
    public let htmlText:String
    public let buttons:[Button]
}
