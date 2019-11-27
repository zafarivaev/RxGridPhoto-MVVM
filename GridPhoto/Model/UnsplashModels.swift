import Foundation
import ObjectMapper

struct UnsplashPhoto: Mappable {
    var urls: PhotoURL?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        urls <- map["urls"]
    }
}

struct PhotoURL: Mappable {
    var small: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        small <- map["small"]
    }
}
