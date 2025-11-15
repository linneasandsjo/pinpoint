import Foundation

enum APIKeys {
    static var googlePlaces: String {
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path) as? [String: Any],
           let key = dict["GOOGLE_PLACES_API_KEY"] as? String {
            return key
        }
        return ""
    }
}