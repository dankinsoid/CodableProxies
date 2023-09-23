import Foundation

public protocol ValueDecoder<Source> {
    
    associatedtype Source
    func decode<T: Decodable>(_ type: T.Type, from source: Source) throws -> T
}

extension JSONDecoder: ValueDecoder {}
extension PropertyListDecoder: ValueDecoder {}
