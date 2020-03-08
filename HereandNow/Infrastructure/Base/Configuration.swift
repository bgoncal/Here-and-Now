import Foundation

class Configuration {
    static let values: NSDictionary = {
        if let path = Bundle.main.path(forResource: "Configuration", ofType: "plist"),
            let config = NSDictionary(contentsOfFile: path) {
            return config
        }
        return NSDictionary()
    }()
}
