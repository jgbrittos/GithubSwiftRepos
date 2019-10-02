import Foundation

class Util<T:Decodable> {
    func decode(from file: String? = "\(T.self)") -> T? {
        let bundle = Bundle(for: Util.self)
        guard
            let json = bundle.path(forResource: file, ofType: "json"),
            let jsonData = NSData(contentsOfFile: json) as Data? else { return nil }
        
        do {
            let decoded = try JSONDecoder().decode(T.self, from: jsonData)
            return decoded
        } catch {
            let _self = "\(T.self)"
            fatalError("\(error.localizedDescription) : \(file ?? _self)")
        }
    }
}
