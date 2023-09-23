import Foundation

public protocol ValueEncoder<Target> {
    
    associatedtype Target
    func encode<T: Encodable>(_ value: T) throws -> Target
}

extension JSONEncoder: ValueEncoder {}
extension PropertyListEncoder: ValueEncoder {}
