import Foundation

protocol Serialize {
    associatedtype model
    static func parse(data: Data) -> model?
}

final class ParseJson<T:Codable>: Serialize {
    
    typealias model = T
    static func parse(data: Data) -> T? {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode(T.self, from: data)
            return result
        } catch {
            print("JSON Error: \(error)")
            return nil
        }
    }
}
