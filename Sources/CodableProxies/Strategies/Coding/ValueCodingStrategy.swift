import Foundation

public struct ValueCodingStrategy {
    
    public let encoding: EncodingStrategy
    public let decoding: ValueDecodingStrategy
    
    public init<T: Codable>(
        _ type: T.Type,
        decode: @escaping (Decoder) throws -> T,
        encode: @escaping (T, Encoder) throws -> Void
    ) {
        encoding = EncodingStrategy(type, encode: encode)
        decoding = ValueDecodingStrategy(type, decode: decode)
    }
}
