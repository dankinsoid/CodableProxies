import Foundation

public struct DecoderProxy<Source>: ValueDecoder {
    
    private let decoder: any ValueDecoder<Source>
    
    public init(_ decoder: any ValueDecoder<Source>) {
        self.decoder = decoder
    }
    
    public func decode<T: Decodable>(_ type: T.Type, from source: Source) throws -> T {
        try decoder.decode(DecoderIntrospect<T>.self, from: source).value
    }
    
    public func decode<T: Decodable>(from source: Source) throws -> T {
        try decode(T.self, from: source)
    }
}
