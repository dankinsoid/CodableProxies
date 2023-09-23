import Foundation

public struct CodingStrategy {
    
    public let encoding: EncodingStrategy
    public let decoding: DecodingStrategy
    
    public init(
        decoding: DecodingStrategy,
        encoding: EncodingStrategy
    ) {
        self.encoding = encoding
        self.decoding = decoding
    }
    
    public init<T: Codable>(
        _ type: T.Type,
        decode: @escaping (Decoder) throws -> T,
        encode: @escaping (T, Encoder) throws -> Void
    ) {
        self.init(
            decoding: DecodingStrategy(type, decode: decode),
            encoding: EncodingStrategy(type, encode: encode)
        )
    }
}
