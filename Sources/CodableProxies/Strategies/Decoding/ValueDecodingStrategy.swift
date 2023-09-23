import Foundation

public struct ValueDecodingStrategy {
    
    let decode: (Any.Type, Decoder) throws -> Decodable?
    
    public init(
        decode: @escaping (Any.Type, Decoder) throws -> Decodable?
    ) {
        self.decode = decode
    }
    
    public init<T: Decodable>(
        _ type: T.Type,
        decode: @escaping (Decoder) throws -> T
    ) {
        self.init {
            guard $0 is T.Type else {
                return nil
            }
            return try decode($1)
        }
    }
}
