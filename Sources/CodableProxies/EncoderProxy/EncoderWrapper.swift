import Foundation

struct EncoderWrapper: Encoder {
    
    let wrapped: Encoder
    let strategy: EncodingStrategy
    var codingPath: [CodingKey] { wrapped.codingPath }
    var userInfo: [CodingUserInfoKey : Any] { wrapped.userInfo }
    private var ignoreStrategy: PartialKeyPath<EncodingStrategy>?
    
    init(
        _ wrapped: Encoder,
        strategy: EncodingStrategy
    ) {
        self.wrapped = wrapped
        self.strategy = strategy
    }
    
    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        KeyedEncodingContainer(
            KeyedEncodingContainerWrapper(
                wrapped: wrapped.container(keyedBy: AnyCodingKey.self),
                encoder: self
            )
        )
    }
    
    func unkeyedContainer() -> UnkeyedEncodingContainer {
        UnkeyedEncodingContainerWrapper(
            wrapped: wrapped.unkeyedContainer(),
            encoder: self
        )
    }
    
    func singleValueContainer() -> SingleValueEncodingContainer {
        SingleValueEncodingContainerWrapper(
            wrapped: wrapped.singleValueContainer(),
            encoder: self
        )
    }
    
    @inline(__always)
    func encode<T>(
        _ value: T,
        _ keyPath: KeyPath<EncodingStrategy, ((T, Encoder) throws -> Void)?>,
        encode: () throws -> Void
    ) throws {
        if ignoreStrategy != keyPath, let encode = strategy[keyPath: keyPath] {
            try encode(value, ignoring(keyPath))
        } else {
            try encode()
        }
    }
    
    @inline(__always)
    func encode(_ value: Encodable, encode: () throws -> Void) throws {
        if ignoreStrategy != \.encodeEncodable, try strategy.encodeEncodable?(value, ignoring(\.encodeEncodable)) == true {
            return
        }
        try encode()
    }
    
    @inline(__always)
    func encodeIfPresent<T>(
        _ value: T?,
        _ keyPathIfNil: KeyPath<EncodingStrategy, ((Encoder) throws -> Void)?>,
        _ keyPath: KeyPath<EncodingStrategy, ((T, Encoder) throws -> Void)?>,
        encode: () throws -> Void
    ) throws {
        if let value, ignoreStrategy != keyPath {
            try self.encode(value, keyPath, encode: encode)
            return
        }
        if ignoreStrategy != keyPathIfNil, let encode = strategy[keyPath: keyPathIfNil] {
            try encode(ignoring(keyPathIfNil))
        } else {
            try encode()
        }
    }
    
    @inline(__always)
    func encodeIfPresent<T: Encodable>(_ value: T?, encode: () throws -> Void) throws {
        if let value, ignoreStrategy != \.encodeEncodable {
            try self.encode(value, encode: encode)
            return
        }
        if ignoreStrategy != \.encodeEncodableIfNil, try strategy.encodeEncodableIfNil?(T.self, ignoring(\.encodeEncodableIfNil)) == true {
            return
        }
        try encode()
    }
    
    @inline(__always)
    private func ignoring(_ keyPath: PartialKeyPath<EncodingStrategy>) -> EncoderWrapper {
        var copy = self
        copy.ignoreStrategy = keyPath
        return copy
    }
}

private final class KeyedEncodingContainerWrapper<Key: CodingKey>: KeyedEncodingContainerProtocol {
    
    var wrapped: KeyedEncodingContainer<AnyCodingKey>
    let _encoder: EncoderWrapper
    var codingPath: [CodingKey] { wrapped.codingPath }
    
    init(wrapped: KeyedEncodingContainer<AnyCodingKey>, encoder: EncoderWrapper) {
        self.wrapped = wrapped
        self._encoder = encoder
    }
    
    func encodeNil(forKey key: Key) throws {
        let key = map(key)
        try encoder(key).encode((), \.encodeNil) { try wrapped.encodeNil(forKey: key) }
    }
    
    func encode(_ value: Bool, forKey key: Key) throws {
        let key = map(key)
        try encoder(key).encode(value, \.encodeBool) { try wrapped.encode(value, forKey: key) }
    }
    
    func encode(_ value: String, forKey key: Key) throws {
        let key = map(key)
        try encoder(key).encode(value, \.encodeString) { try wrapped.encode(value, forKey: key) }
    }
    
    func encode(_ value: Double, forKey key: Key) throws {
        let key = map(key)
        try encoder(key).encode(value, \.encodeDouble) { try wrapped.encode(value, forKey: key) }
    }
    
    func encode(_ value: Float, forKey key: Key) throws {
        let key = map(key)
        try encoder(key).encode(value, \.encodeFloat) { try wrapped.encode(value, forKey: key) }
    }
    
    func encode(_ value: Int, forKey key: Key) throws {
        let key = map(key)
        try encoder(key).encode(value, \.encodeInt) { try wrapped.encode(value, forKey: key) }
    }
    
    func encode(_ value: Int8, forKey key: Key) throws {
        let key = map(key)
        try encoder(key).encode(value, \.encodeInt8) { try wrapped.encode(value, forKey: key) }
    }
    
    func encode(_ value: Int16, forKey key: Key) throws {
        let key = map(key)
        try encoder(key).encode(value, \.encodeInt16) { try wrapped.encode(value, forKey: key) }
    }
    
    func encode(_ value: Int32, forKey key: Key) throws {
        let key = map(key)
        try encoder(key).encode(value, \.encodeInt32) { try wrapped.encode(value, forKey: key) }
    }
    
    func encode(_ value: Int64, forKey key: Key) throws {
        let key = map(key)
        try encoder(key).encode(value, \.encodeInt64) { try wrapped.encode(value, forKey: key) }
    }
    
    func encode(_ value: UInt, forKey key: Key) throws {
        let key = map(key)
        try encoder(key).encode(value, \.encodeUInt) { try wrapped.encode(value, forKey: key) }
    }
    
    func encode(_ value: UInt8, forKey key: Key) throws {
        let key = map(key)
        try encoder(key).encode(value, \.encodeUInt8) { try wrapped.encode(value, forKey: key) }
    }
    
    func encode(_ value: UInt16, forKey key: Key) throws {
        let key = map(key)
        try encoder(key).encode(value, \.encodeUInt16) { try wrapped.encode(value, forKey: key) }
    }
    
    func encode(_ value: UInt32, forKey key: Key) throws {
        let key = map(key)
        try encoder(key).encode(value, \.encodeUInt32) { try wrapped.encode(value, forKey: key) }
    }
    
    func encode(_ value: UInt64, forKey key: Key) throws {
        let key = map(key)
        try encoder(key).encode(value, \.encodeUInt64) { try wrapped.encode(value, forKey: key) }
    }
    
    func encode<T>(_ value: T, forKey key: Key) throws where T : Encodable {
        let key = map(key)
        try encoder(key).encode(value) { try wrapped.encode(value, forKey: key) }
    }

    // TODO: customize new methods
//    func encodeConditional<T>(_ object: T, forKey key: Key) throws where T : AnyObject, T : Encodable {
//
//    }
    
    func encodeIfPresent(_ value: Bool?, forKey key: Key) throws {
        let key = map(key)
        try encoder(key).encodeIfPresent(value, \.encodeBoolIfNil, \.encodeBool) { try wrapped.encodeIfPresent(value, forKey: key) }
    }
    
    func encodeIfPresent(_ value: String?, forKey key: Key) throws {
        let key = map(key)
        try encoder(key).encodeIfPresent(value, \.encodeStringIfNil, \.encodeString) { try wrapped.encodeIfPresent(value, forKey: key) }
    }
    
    func encodeIfPresent(_ value: Double?, forKey key: Key) throws {
        let key = map(key)
        try encoder(key).encodeIfPresent(value, \.encodeDoubleIfNil, \.encodeDouble) { try wrapped.encodeIfPresent(value, forKey: key) }
    }
    
    func encodeIfPresent(_ value: Float?, forKey key: Key) throws {
        let key = map(key)
        try encoder(key).encodeIfPresent(value, \.encodeFloatIfNil, \.encodeFloat) { try wrapped.encodeIfPresent(value, forKey: key) }
    }
    
    func encodeIfPresent(_ value: Int?, forKey key: Key) throws {
        let key = map(key)
        try encoder(key).encodeIfPresent(value, \.encodeIntIfNil, \.encodeInt) { try wrapped.encodeIfPresent(value, forKey: key) }
    }
    
    func encodeIfPresent(_ value: Int8?, forKey key: Key) throws {
        let key = map(key)
        try encoder(key).encodeIfPresent(value, \.encodeInt8IfNil, \.encodeInt8) { try wrapped.encodeIfPresent(value, forKey: key) }
    }
    
    func encodeIfPresent(_ value: Int16?, forKey key: Key) throws {
        let key = map(key)
        try encoder(key).encodeIfPresent(value, \.encodeInt16IfNil, \.encodeInt16) { try wrapped.encodeIfPresent(value, forKey: key) }
    }
    
    func encodeIfPresent(_ value: Int32?, forKey key: Key) throws {
        let key = map(key)
        try encoder(key).encodeIfPresent(value, \.encodeInt32IfNil, \.encodeInt32) { try wrapped.encodeIfPresent(value, forKey: key) }
    }
    
    func encodeIfPresent(_ value: Int64?, forKey key: Key) throws {
        let key = map(key)
        try encoder(key).encodeIfPresent(value, \.encodeInt64IfNil, \.encodeInt64) { try wrapped.encodeIfPresent(value, forKey: key) }
    }
    
    func encodeIfPresent(_ value: UInt?, forKey key: Key) throws {
        let key = map(key)
        try encoder(key).encodeIfPresent(value, \.encodeUIntIfNil, \.encodeUInt) { try wrapped.encodeIfPresent(value, forKey: key) }
    }
    
    func encodeIfPresent(_ value: UInt8?, forKey key: Key) throws {
        let key = map(key)
        try encoder(key).encodeIfPresent(value, \.encodeUInt8IfNil, \.encodeUInt8) { try wrapped.encodeIfPresent(value, forKey: key) }
    }
    
    func encodeIfPresent(_ value: UInt16?, forKey key: Key) throws {
        let key = map(key)
        try encoder(key).encodeIfPresent(value, \.encodeUInt16IfNil, \.encodeUInt16) { try wrapped.encodeIfPresent(value, forKey: key) }
    }
    
    func encodeIfPresent(_ value: UInt32?, forKey key: Key) throws {
        let key = map(key)
        try encoder(key).encodeIfPresent(value, \.encodeUInt32IfNil, \.encodeUInt32) { try wrapped.encodeIfPresent(value, forKey: key) }
    }
    
    func encodeIfPresent(_ value: UInt64?, forKey key: Key) throws {
        let key = map(key)
        try encoder(key).encodeIfPresent(value, \.encodeUInt64IfNil, \.encodeUInt64) { try wrapped.encodeIfPresent(value, forKey: key) }
    }
    
    func encodeIfPresent<T>(_ value: T?, forKey key: Key) throws where T : Encodable {
        let key = map(key)
        try encoder(key).encodeIfPresent(value) { try wrapped.encodeIfPresent(value, forKey: key) }
    }

    func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        let key = map(key)
        return KeyedEncodingContainer<NestedKey>(
            KeyedEncodingContainerWrapper<NestedKey>(
                wrapped: wrapped.nestedContainer(keyedBy: AnyCodingKey.self, forKey: key),
                encoder: encoder(key)
            )
        )
    }
    
    func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
        let key = map(key)
        return UnkeyedEncodingContainerWrapper(
            wrapped: wrapped.nestedUnkeyedContainer(forKey: key),
            encoder: encoder(key)
        )
    }
    
    func superEncoder() -> Encoder {
        EncoderWrapper(wrapped.superEncoder(), strategy: _encoder.strategy)
    }
    
    func superEncoder(forKey key: Key) -> Encoder {
        EncoderWrapper(wrapped.superEncoder(forKey: map(key)), strategy: _encoder.strategy)
    }
    
    @inline(__always)
    private func map(_ key: any CodingKey) -> AnyCodingKey {
        AnyCodingKey(
            _encoder.strategy.encodeKey?(key.stringValue) ?? key.stringValue
        )
    }
    
    @inline(__always)
    private func encoder(_ key: AnyCodingKey) -> EncoderWrapper {
        EncoderWrapper(
            KeyedContainerEncoder(
                key: key,
                base: Ref(self, \.wrapped),
                userInfo: _encoder.userInfo
            ),
            strategy: _encoder.strategy
        )
    }
}

private final class UnkeyedEncodingContainerWrapper: UnkeyedEncodingContainer {
    
    var wrapped: UnkeyedEncodingContainer
    let _encoder: EncoderWrapper
    @inline(__always)
    var encoder: EncoderWrapper {
        EncoderWrapper(
            UnkeyedContainerEncoder(
                base: Ref(self, \.wrapped),
                userInfo: _encoder.userInfo
            ),
            strategy: _encoder.strategy
        )
    }
    var codingPath: [CodingKey] { wrapped.codingPath }
    var count: Int { wrapped.count }
    
    init(wrapped: UnkeyedEncodingContainer, encoder: EncoderWrapper) {
        self.wrapped = wrapped
        self._encoder = encoder
    }
    
    func encodeNil() throws {
        try encoder.encode((), \.encodeNil) { try wrapped.encodeNil() }
    }
    
    func encode(_ value: Bool) throws {
        try encoder.encode(value, \.encodeBool) { try wrapped.encode(value) }
    }
    
    func encode(_ value: String) throws {
        try encoder.encode(value, \.encodeString) { try wrapped.encode(value) }
    }
    
    func encode(_ value: Double) throws {
        try encoder.encode(value, \.encodeDouble) { try wrapped.encode(value) }
    }
    
    func encode(_ value: Float) throws {
        try encoder.encode(value, \.encodeFloat) { try wrapped.encode(value) }
    }
    
    func encode(_ value: Int) throws {
        try encoder.encode(value, \.encodeInt) { try wrapped.encode(value) }
    }
    
    func encode(_ value: Int8) throws {
        try encoder.encode(value, \.encodeInt8) { try wrapped.encode(value) }
    }
    
    func encode(_ value: Int16) throws {
        try encoder.encode(value, \.encodeInt16) { try wrapped.encode(value) }
    }
    
    func encode(_ value: Int32) throws {
        try encoder.encode(value, \.encodeInt32) { try wrapped.encode(value) }
    }
    
    func encode(_ value: Int64) throws {
        try encoder.encode(value, \.encodeInt64) { try wrapped.encode(value) }
    }
    
    func encode(_ value: UInt) throws {
        try encoder.encode(value, \.encodeUInt) { try wrapped.encode(value) }
    }
    
    func encode(_ value: UInt8) throws {
        try encoder.encode(value, \.encodeUInt8) { try wrapped.encode(value) }
    }
    
    func encode(_ value: UInt16) throws {
        try encoder.encode(value, \.encodeUInt16) { try wrapped.encode(value) }
    }
    
    func encode(_ value: UInt32) throws {
        try encoder.encode(value, \.encodeUInt32) { try wrapped.encode(value) }
    }
    
    func encode(_ value: UInt64) throws {
        try encoder.encode(value, \.encodeUInt64) { try wrapped.encode(value) }
    }
    
    func encode<T>(_ value: T) throws where T : Encodable {
        try encoder.encode(value) { try wrapped.encode(value) }
    }
    
    // TODO: customize new methods
//    func encodeConditional<T>(_ object: T) throws where T : AnyObject, T : Encodable {
//        try wrapped.encodeConditional(object)
//    }
//
//    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Bool {
//        try wrapped.encode(contentsOf: sequence)
//    }
//
//    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == String {
//
//    }
//
//    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Double {
//
//    }
//
//    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Float {
//
//    }
//
//    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Int {
//
//    }
//
//    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Int8 {
//
//    }
//
//    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Int16 {
//
//    }
//
//    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Int32 {
//
//    }
//
//    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Int64 {
//
//    }
//
//    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == UInt {
//
//    }
//
//    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == UInt8 {
//
//    }
//
//    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == UInt16 {
//
//    }
//
//    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == UInt32 {
//
//    }
//
//    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == UInt64 {
//
//    }
//
//    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element : Encodable {
//
//    }
    
    func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        KeyedEncodingContainer(
            KeyedEncodingContainerWrapper(
                wrapped: wrapped.nestedContainer(keyedBy: AnyCodingKey.self),
                encoder: encoder
            )
        )
    }
    
    func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        UnkeyedEncodingContainerWrapper(
            wrapped: wrapped.nestedUnkeyedContainer(),
            encoder: encoder
        )
    }
    
    func superEncoder() -> Encoder {
        EncoderWrapper(wrapped.superEncoder(), strategy: _encoder.strategy)
    }
}

private struct SingleValueEncodingContainerWrapper: SingleValueEncodingContainer {
    
    var wrapped: SingleValueEncodingContainer
    let encoder: EncoderWrapper
    var codingPath: [CodingKey] { wrapped.codingPath }
    
    mutating func encodeNil() throws {
        try encoder.encode((), \.encodeNil) { try wrapped.encodeNil() }
    }
    
    mutating func encode(_ value: Bool) throws {
        try encoder.encode(value, \.encodeBool) { try wrapped.encode(value) }
    }
    
    mutating func encode(_ value: String) throws {
        try encoder.encode(value, \.encodeString) { try wrapped.encode(value) }
    }
    
    mutating func encode(_ value: Double) throws {
        try encoder.encode(value, \.encodeDouble) { try wrapped.encode(value) }
    }
    
    mutating func encode(_ value: Float) throws {
        try encoder.encode(value, \.encodeFloat) { try wrapped.encode(value) }
    }
    
    mutating func encode(_ value: Int) throws {
        try encoder.encode(value, \.encodeInt) { try wrapped.encode(value) }
    }
    
    mutating func encode(_ value: Int8) throws {
        try encoder.encode(value, \.encodeInt8) { try wrapped.encode(value) }
    }
    
    mutating func encode(_ value: Int16) throws {
        try encoder.encode(value, \.encodeInt16) { try wrapped.encode(value) }
    }
    
    mutating func encode(_ value: Int32) throws {
        try encoder.encode(value, \.encodeInt32) { try wrapped.encode(value) }
    }
    
    mutating func encode(_ value: Int64) throws {
        try encoder.encode(value, \.encodeInt64) { try wrapped.encode(value) }
    }
    
    mutating func encode(_ value: UInt) throws {
        try encoder.encode(value, \.encodeUInt) { try wrapped.encode(value) }
    }
    
    mutating func encode(_ value: UInt8) throws {
        try encoder.encode(value, \.encodeUInt8) { try wrapped.encode(value) }
    }
    
    mutating func encode(_ value: UInt16) throws {
        try encoder.encode(value, \.encodeUInt16) { try wrapped.encode(value) }
    }
    
    mutating func encode(_ value: UInt32) throws {
        try encoder.encode(value, \.encodeUInt32) { try wrapped.encode(value) }
    }
    
    mutating func encode(_ value: UInt64) throws {
        try encoder.encode(value, \.encodeUInt64) { try wrapped.encode(value) }
    }
    
    mutating func encode<T: Encodable>(_ value: T) throws {
        try encoder.encode(value) {
            try wrapped.encode(value)
        }
    }
}

private struct KeyedContainerEncoder: Encoder, SingleValueEncodingContainer {
    
    let key: AnyCodingKey
    @Ref var base: KeyedEncodingContainer<AnyCodingKey>
    let userInfo: [CodingUserInfoKey: Any]
    var codingPath: [CodingKey] { base.codingPath + [key] }
    
    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        base.nestedContainer(keyedBy: type, forKey: key)
    }
    
    func unkeyedContainer() -> UnkeyedEncodingContainer {
        base.nestedUnkeyedContainer(forKey: key)
    }
    
    func singleValueContainer() -> SingleValueEncodingContainer {
        self
    }
    
    mutating func encodeNil() throws { try base.encodeNil(forKey: key) }
    mutating func encode(_ value: Bool) throws { try base.encode(value, forKey: key) }
    mutating func encode(_ value: String) throws { try base.encode(value, forKey: key) }
    mutating func encode(_ value: Double) throws { try base.encode(value, forKey: key) }
    mutating func encode(_ value: Float) throws { try base.encode(value, forKey: key) }
    mutating func encode(_ value: Int) throws { try base.encode(value, forKey: key) }
    mutating func encode(_ value: Int8) throws { try base.encode(value, forKey: key) }
    mutating func encode(_ value: Int16) throws { try base.encode(value, forKey: key) }
    mutating func encode(_ value: Int32) throws { try base.encode(value, forKey: key) }
    mutating func encode(_ value: Int64) throws { try base.encode(value, forKey: key) }
    mutating func encode(_ value: UInt) throws { try base.encode(value, forKey: key) }
    mutating func encode(_ value: UInt8) throws { try base.encode(value, forKey: key) }
    mutating func encode(_ value: UInt16) throws { try base.encode(value, forKey: key) }
    mutating func encode(_ value: UInt32) throws { try base.encode(value, forKey: key) }
    mutating func encode(_ value: UInt64) throws { try base.encode(value, forKey: key) }
    mutating func encode<T: Encodable>(_ value: T) throws { try base.encode(value, forKey: key) }
}

private struct UnkeyedContainerEncoder: Encoder, SingleValueEncodingContainer {
    
    @Ref var base: UnkeyedEncodingContainer
    let userInfo: [CodingUserInfoKey: Any]
    var codingPath: [CodingKey] { base.codingPath + [AnyCodingKey(intValue: base.count)] }
    
    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        base.nestedContainer(keyedBy: type)
    }
    
    func unkeyedContainer() -> UnkeyedEncodingContainer {
        base.nestedUnkeyedContainer()
    }
    
    func singleValueContainer() -> SingleValueEncodingContainer {
        self
    }
    
    mutating func encodeNil() throws { try base.encodeNil() }
    mutating func encode(_ value: Bool) throws { try base.encode(value) }
    mutating func encode(_ value: String) throws { try base.encode(value) }
    mutating func encode(_ value: Double) throws { try base.encode(value) }
    mutating func encode(_ value: Float) throws { try base.encode(value) }
    mutating func encode(_ value: Int) throws { try base.encode(value) }
    mutating func encode(_ value: Int8) throws { try base.encode(value) }
    mutating func encode(_ value: Int16) throws { try base.encode(value) }
    mutating func encode(_ value: Int32) throws { try base.encode(value) }
    mutating func encode(_ value: Int64) throws { try base.encode(value) }
    mutating func encode(_ value: UInt) throws { try base.encode(value) }
    mutating func encode(_ value: UInt8) throws { try base.encode(value) }
    mutating func encode(_ value: UInt16) throws { try base.encode(value) }
    mutating func encode(_ value: UInt32) throws { try base.encode(value) }
    mutating func encode(_ value: UInt64) throws { try base.encode(value) }
    mutating func encode<T: Encodable>(_ value: T) throws { try base.encode(value) }
}
