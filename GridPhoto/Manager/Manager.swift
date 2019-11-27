import Foundation

class Manager {
    
    static let shared = { Manager() }()
    
    lazy var APIURL: String = {
        return "https://api.unsplash.com/"
    }()
    
    lazy var APIKey: String = {
        return "9836d9c4041f5323b2e2921cbe653a3bbce58bdaa1346f68c27a0540c114b807"
    }()
}
