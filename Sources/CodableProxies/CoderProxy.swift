import Foundation

public struct CoderProxy<SourceTarget>: ValueDecoder, ValueEncoder {
    
    public typealias Source = SourceTarget
    public typealias Target = SourceTarget
    
    public let encoder: EncoderProxy<SourceTarget>
    public let decoder: DecoderProxy<SourceTarget>
    
    public init(
        decoder: DecoderProxy<SourceTarget>,
        encoder: EncoderProxy<SourceTarget>
    ) {
        self.decoder = decoder
        self.encoder = encoder
    }
    
    public func decode<T>(_ type: T.Type, from source: SourceTarget) throws -> T where T : Decodable {
        try decode(from: source)
    }
    
    public func decode<T>(from source: SourceTarget) throws -> T where T : Decodable {
        try decoder.decode(from: source)
    }
    
    @_disfavoredOverload
    public func encode<T: Encodable>(_ value: T) throws -> SourceTarget {
        try encode(value)
    }
    
    public func encode(_ value: any Encodable) throws -> SourceTarget {
        try encoder.encode(value)
    }
}

public typealias ValueCoder<SourceTarget> = ValueDecoder<SourceTarget> & ValueEncoder<SourceTarget>
