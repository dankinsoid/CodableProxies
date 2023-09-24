import Foundation

public struct DecoderProxy<Source>: ValueDecoder {
    
    private let decoder: any ValueDecoder<Source>
    public var strategy: DecodingStrategy
    
    public init(_ decoder: any ValueDecoder<Source>, strategy: DecodingStrategy = .default) {
        self.decoder = decoder
        self.strategy = strategy
    }
    
    public func decode<T: Decodable>(_ type: T.Type, from source: Source) throws -> T {
        try decoder.decode(DecoderIntrospect<T>.self, from: source).decode(strategy: strategy)
    }
    
    public func decode<T: Decodable>(from source: Source) throws -> T {
        try decode(T.self, from: source)
    }
}
