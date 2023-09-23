import Foundation

struct DecoderWrapper: Decoder {
    
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
