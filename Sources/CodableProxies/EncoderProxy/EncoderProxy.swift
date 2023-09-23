import Foundation

public struct EncoderProxy<Target>: ValueEncoder {
    
    private let _encode: (_ value: EncoderIntrospect) throws -> Target
    public var strategy: EncodingStrategy
    
    public init(
        strategy: EncodingStrategy = .default,
        encode: @escaping (EncoderIntrospect) throws -> Target
    ) {
        self.strategy = strategy
        _encode = encode
    }
    
    public init(_ encoder: any ValueEncoder<Target>, strategy: EncodingStrategy = .default) {
        self.init(strategy: strategy) {
            try encoder.encode($0)
        }
    }
    
    @_disfavoredOverload
    public func encode<T: Encodable>(_ value: T) throws -> Target {
        try encode(value)
    }
    
    public func encode(_ value: any Encodable) throws -> Target {
        try _encode(EncoderIntrospect(value: value, strategy: strategy))
    }
}
