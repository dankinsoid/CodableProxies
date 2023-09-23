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

public protocol ValueDecoder<Source> {
    
    associatedtype Source
    func decode<T: Decodable>(_ type: T.Type, from source: Source) throws -> T
}

extension JSONDecoder: ValueDecoder {}
extension PropertyListDecoder: ValueDecoder {}

private struct DecoderWrapper: Decoder {
    
    let wrapped: Decoder
    var codingPath: [CodingKey] { wrapped.codingPath }
    var userInfo: [CodingUserInfoKey : Any] { wrapped.userInfo }
    
    
    init(_ wrapped: Decoder) {
        self.wrapped = wrapped
    }
    
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        try wrapped.container(keyedBy: type)
    }
    
    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        try wrapped.unkeyedContainer()
    }
    
    func singleValueContainer() throws -> SingleValueDecodingContainer {
        try wrapped.singleValueContainer()
    }
}

private struct DecoderIntrospect<Value: Decodable>: Decodable {
    
    let value: Value
    
    public init(from decoder: Decoder) throws {
        value = try Value(from: DecoderWrapper(decoder))
    }
}
