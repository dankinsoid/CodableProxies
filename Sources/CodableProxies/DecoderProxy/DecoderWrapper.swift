import Foundation

struct DecoderWrapper: Decoder {
    
    let wrapped: Decoder
    let strategy: DecodingStrategy
    var codingPath: [CodingKey] { wrapped.codingPath }
    var userInfo: [CodingUserInfoKey : Any] { wrapped.userInfo }
    private var ignoreStrategy: PartialKeyPath<DecodingStrategy>?
    
    init(
        _ wrapped: Decoder,
        strategy: DecodingStrategy
    ) {
        self.wrapped = wrapped
        self.strategy = strategy
    }
    
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        try KeyedDecodingContainer(
            KeyedDecodingContainerWrapper(
                wrapped: wrapped.container(keyedBy: AnyCodingKey.self),
                decoder: self
            )
        )
    }
    
    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        try UnkeyedDecodingContainerWrapper(
            wrapped: wrapped.unkeyedContainer(),
            decoder: self
        )
    }
    
    func singleValueContainer() throws -> SingleValueDecodingContainer {
        try SingleValueDecodingContainerWrapper(
            wrapped: wrapped.singleValueContainer(),
            decoder: self
        )
    }
    
    @inline(__always)
    func decode<T>(
        _ type: T.Type,
        _ keyPath: KeyPath<DecodingStrategy, ((Decoder) throws -> T)?>,
        decode: () throws -> T
    ) throws -> T {
        if ignoreStrategy != keyPath, let decode = strategy[keyPath: keyPath] {
            return try decode(ignoring(keyPath))
        } else {
            return try decode()
        }
    }
    
    @inline(__always)
    func decode<T: Decodable>(_ type: T.Type, decode: () throws -> T) throws -> T {
        if ignoreStrategy != \.decodeDecodable, let result = try strategy.decodeDecodable?(type, ignoring(\.decodeDecodable)) as? T {
            return result
        }
        return try decode()
    }
    
    @inline(__always)
    func decodeIfPresent<T>(
        present: Bool,
        _ keyPathIfNil: KeyPath<DecodingStrategy, ((Decoder) throws -> T?)?>,
        _ keyPath: KeyPath<DecodingStrategy, ((Decoder) throws -> T)?>,
        decode: () throws -> T?
    ) throws -> T? {
        if present {
            if ignoreStrategy != keyPath, let decode = strategy[keyPath: keyPath] {
                return try decode(ignoring(keyPath))
            } else {
                return try decode()
            }
        } else if ignoreStrategy != keyPathIfNil, let decode = strategy[keyPath: keyPathIfNil] {
            return try decode(ignoring(keyPathIfNil))
        } else {
            return try decode()
        }
    }

    @inline(__always)
    func decodeIfPresent<T: Decodable>(present: Bool, decode: () throws -> T?) throws -> T? {
        if present {
            if ignoreStrategy != \.decodeDecodable, let decode = strategy.decodeDecodable {
                return try decode(T.self, ignoring(\.decodeDecodable)) as? T
            } else {
                return try decode()
            }
        } else if ignoreStrategy != \.decodeDecodableIfNil, let decode = strategy.decodeDecodableIfNil {
            return try decode(T.self, ignoring(\.decodeDecodableIfNil)) as? T
        } else {
            return try decode()
        }
    }
    
    @inline(__always)
    private func ignoring(_ keyPath: PartialKeyPath<DecodingStrategy>) -> DecoderWrapper {
        var copy = self
        copy.ignoreStrategy = keyPath
        return copy
    }
}

private final class KeyedDecodingContainerWrapper<Key: CodingKey>: KeyedDecodingContainerProtocol {
    
    var wrapped: KeyedDecodingContainer<AnyCodingKey>
    let _decoder: DecoderWrapper
    var codingPath: [CodingKey] { wrapped.codingPath }
    var allKeys: [Key] {
        wrapped.allKeys.compactMap {
            Key(stringValue: $0.stringValue)
        }
    }
    
    init(wrapped: KeyedDecodingContainer<AnyCodingKey>, decoder: DecoderWrapper) {
        self.wrapped = wrapped
        self._decoder = decoder
    }
    
    func contains(_ key: Key) -> Bool {
        wrapped.contains(map(key))
    }
    
    func decodeNil(forKey key: Key) throws -> Bool {
        let key = map(key)
        return try decoder(key).decode(Bool.self, \.decodeNil) { try wrapped.decodeNil(forKey: key) }
    }
    
    func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        let key = map(key)
        return try decoder(key).decode(type, \.decodeBool) { try wrapped.decode(type, forKey: key) }
    }
    
    func decode(_ type: String.Type, forKey key: Key) throws -> String {
        let key = map(key)
        return try decoder(key).decode(type, \.decodeString) { try wrapped.decode(type, forKey: key) }
    }
    
    func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        let key = map(key)
        return try decoder(key).decode(type, \.decodeDouble) { try wrapped.decode(type, forKey: key) }
    }
    
    func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        let key = map(key)
        return try decoder(key).decode(type, \.decodeFloat) { try wrapped.decode(type, forKey: key) }
    }
    
    func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        let key = map(key)
        return try decoder(key).decode(type, \.decodeInt) { try wrapped.decode(type, forKey: key) }
    }
    
    func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        let key = map(key)
        return try decoder(key).decode(type, \.decodeInt8) { try wrapped.decode(type, forKey: key) }
    }
    
    func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        let key = map(key)
        return try decoder(key).decode(type, \.decodeInt16) { try wrapped.decode(type, forKey: key) }
    }
    
    func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        let key = map(key)
        return try decoder(key).decode(type, \.decodeInt32) { try wrapped.decode(type, forKey: key) }
    }
    
    func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        let key = map(key)
        return try decoder(key).decode(type, \.decodeInt64) { try wrapped.decode(type, forKey: key) }
    }
    
    func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        let key = map(key)
        return try decoder(key).decode(type, \.decodeUInt) { try wrapped.decode(type, forKey: key) }
    }
    
    func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        let key = map(key)
        return try decoder(key).decode(type, \.decodeUInt8) { try wrapped.decode(type, forKey: key) }
    }
    
    func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        let key = map(key)
        return try decoder(key).decode(type, \.decodeUInt16) { try wrapped.decode(type, forKey: key) }
    }
    
    func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        let key = map(key)
        return try decoder(key).decode(type, \.decodeUInt32) { try wrapped.decode(type, forKey: key) }
    }
    
    func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        let key = map(key)
        return try decoder(key).decode(type, \.decodeUInt64) { try wrapped.decode(type, forKey: key) }
    }
    
    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T : Decodable {
        let key = map(key)
        return try decoder(key).decode(type) { try wrapped.decode(type, forKey: key) }
    }
    
    func decodeIfPresent(_ type: Bool.Type, forKey key: Key) throws -> Bool? {
        let key = map(key)
        return try decoder(key).decodeIfPresent(present: wrapped.contains(key), \.decodeBoolIfNil, \.decodeBool) {
            try wrapped.decodeIfPresent(type, forKey: key)
        }
    }
    
    func decodeIfPresent(_ type: String.Type, forKey key: Key) throws -> String? {
        let key = map(key)
        return try decoder(key).decodeIfPresent(present: wrapped.contains(key), \.decodeStringIfNil, \.decodeString) {
            try wrapped.decodeIfPresent(type, forKey: key)
        }
    }
    
    func decodeIfPresent(_ type: Double.Type, forKey key: Key) throws -> Double? {
        let key = map(key)
        return try decoder(key).decodeIfPresent(present: wrapped.contains(key), \.decodeDoubleIfNil, \.decodeDouble) {
            try wrapped.decodeIfPresent(type, forKey: key)
        }
    }
    
    func decodeIfPresent(_ type: Float.Type, forKey key: Key) throws -> Float? {
        let key = map(key)
        return try decoder(key).decodeIfPresent(present: wrapped.contains(key), \.decodeFloatIfNil, \.decodeFloat) {
            try wrapped.decodeIfPresent(type, forKey: key)
        }
    }
    
    func decodeIfPresent(_ type: Int.Type, forKey key: Key) throws -> Int? {
        let key = map(key)
        return try decoder(key).decodeIfPresent(present: wrapped.contains(key), \.decodeIntIfNil, \.decodeInt) {
            try wrapped.decodeIfPresent(type, forKey: key)
        }
    }
    
    func decodeIfPresent(_ type: Int8.Type, forKey key: Key) throws -> Int8? {
        let key = map(key)
        return try decoder(key).decodeIfPresent(present: wrapped.contains(key), \.decodeInt8IfNil, \.decodeInt8) {
            try wrapped.decodeIfPresent(type, forKey: key)
        }
    }
    
    func decodeIfPresent(_ type: Int16.Type, forKey key: Key) throws -> Int16? {
        let key = map(key)
        return try decoder(key).decodeIfPresent(present: wrapped.contains(key), \.decodeInt16IfNil, \.decodeInt16) {
            try wrapped.decodeIfPresent(type, forKey: key)
        }
    }
    
    func decodeIfPresent(_ type: Int32.Type, forKey key: Key) throws -> Int32? {
        let key = map(key)
        return try decoder(key).decodeIfPresent(present: wrapped.contains(key), \.decodeInt32IfNil, \.decodeInt32) {
            try wrapped.decodeIfPresent(type, forKey: key)
        }
    }
    
    func decodeIfPresent(_ type: Int64.Type, forKey key: Key) throws -> Int64? {
        let key = map(key)
        return try decoder(key).decodeIfPresent(present: wrapped.contains(key), \.decodeInt64IfNil, \.decodeInt64) {
            try wrapped.decodeIfPresent(type, forKey: key)
        }
    }
    
    func decodeIfPresent(_ type: UInt.Type, forKey key: Key) throws -> UInt? {
        let key = map(key)
        return try decoder(key).decodeIfPresent(present: wrapped.contains(key), \.decodeUIntIfNil, \.decodeUInt) {
            try wrapped.decodeIfPresent(type, forKey: key)
        }
    }
    
    func decodeIfPresent(_ type: UInt8.Type, forKey key: Key) throws -> UInt8? {
        let key = map(key)
        return try decoder(key).decodeIfPresent(present: wrapped.contains(key), \.decodeUInt8IfNil, \.decodeUInt8) {
            try wrapped.decodeIfPresent(type, forKey: key)
        }
    }
    
    func decodeIfPresent(_ type: UInt16.Type, forKey key: Key) throws -> UInt16? {
        let key = map(key)
        return try decoder(key).decodeIfPresent(present: wrapped.contains(key), \.decodeUInt16IfNil, \.decodeUInt16) {
            try wrapped.decodeIfPresent(type, forKey: key)
        }
    }
    
    func decodeIfPresent(_ type: UInt32.Type, forKey key: Key) throws -> UInt32? {
        let key = map(key)
        return try decoder(key).decodeIfPresent(present: wrapped.contains(key), \.decodeUInt32IfNil, \.decodeUInt32) {
            try wrapped.decodeIfPresent(type, forKey: key)
        }
    }
    
    func decodeIfPresent(_ type: UInt64.Type, forKey key: Key) throws -> UInt64? {
        let key = map(key)
        return try decoder(key).decodeIfPresent(present: wrapped.contains(key), \.decodeUInt64IfNil, \.decodeUInt64) {
            try wrapped.decodeIfPresent(type, forKey: key)
        }
    }
    
    func decodeIfPresent<T>(_ type: T.Type, forKey key: Key) throws -> T? where T : Decodable {
        let key = map(key)
        return try decoder(key).decodeIfPresent(present: wrapped.contains(key)) {
            try wrapped.decodeIfPresent(type, forKey: key)
        }
    }
    
    func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        let key = map(key)
        return try KeyedDecodingContainer<NestedKey>(
            KeyedDecodingContainerWrapper<NestedKey>(
                wrapped: wrapped.nestedContainer(keyedBy: AnyCodingKey.self, forKey: key),
                decoder: decoder(key)
            )
        )
    }
    
    func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
        let key = map(key)
        return try UnkeyedDecodingContainerWrapper(
            wrapped: wrapped.nestedUnkeyedContainer(forKey: key),
            decoder: decoder(key)
        )
    }
    
    func superDecoder() throws -> Decoder {
        try DecoderWrapper(wrapped.superDecoder(), strategy: _decoder.strategy)
    }
    
    func superDecoder(forKey key: Key) throws -> Decoder {
        try DecoderWrapper(wrapped.superDecoder(forKey: map(key)), strategy: _decoder.strategy)
    }
    
    @inline(__always)
    private func map(_ key: any CodingKey) -> AnyCodingKey {
        AnyCodingKey(
            _decoder.strategy.decodeKey?(key.stringValue) ?? key.stringValue
        )
    }
    
    @inline(__always)
    private func decoder(_ key: AnyCodingKey) -> DecoderWrapper {
        DecoderWrapper(
            KeyedContainerDecoder(
                key: key,
                base: Ref(self, \.wrapped),
                userInfo: _decoder.userInfo
            ),
            strategy: _decoder.strategy
        )
    }
}

private final class UnkeyedDecodingContainerWrapper: UnkeyedDecodingContainer {
    
    var wrapped: UnkeyedDecodingContainer
    let _decoder: DecoderWrapper
    @inline(__always)
    var decoder: DecoderWrapper {
        DecoderWrapper(
            UnkeyedContainerDecoder(
                base: Ref(self, \.wrapped),
                userInfo: _decoder.userInfo
            ),
            strategy: _decoder.strategy
        )
    }
    var codingPath: [CodingKey] { wrapped.codingPath }
    var isAtEnd: Bool { wrapped.isAtEnd }
    var currentIndex: Int { wrapped.currentIndex }
    var count: Int? { wrapped.count }
    
    init(wrapped: UnkeyedDecodingContainer, decoder: DecoderWrapper) {
        self.wrapped = wrapped
        self._decoder = decoder
    }
    
    func decodeNil() -> Bool {
        (try? decoder.decode(Bool.self, \.decodeNil) { try wrapped.decodeNil() }) ?? false
    }
    
    func decode(_ type: Bool.Type) throws -> Bool {
        try decoder.decode(type, \.decodeBool) { try wrapped.decode(type) }
    }
    
    func decode(_ type: String.Type) throws -> String {
        try decoder.decode(type, \.decodeString) { try wrapped.decode(type) }
    }
    
    func decode(_ type: Double.Type) throws -> Double {
        try decoder.decode(type, \.decodeDouble) { try wrapped.decode(type) }
    }
    
    func decode(_ type: Float.Type) throws -> Float {
        try decoder.decode(type, \.decodeFloat) { try wrapped.decode(type) }
    }
    
    func decode(_ type: Int.Type) throws -> Int {
        try decoder.decode(type, \.decodeInt) { try wrapped.decode(type) }
    }
    
    func decode(_ type: Int8.Type) throws -> Int8 {
        try decoder.decode(type, \.decodeInt8) { try wrapped.decode(type) }
    }
    
    func decode(_ type: Int16.Type) throws -> Int16 {
        try decoder.decode(type, \.decodeInt16) { try wrapped.decode(type) }
    }
    
    func decode(_ type: Int32.Type) throws -> Int32 {
        try decoder.decode(type, \.decodeInt32) { try wrapped.decode(type) }
    }
    
    func decode(_ type: Int64.Type) throws -> Int64 {
        try decoder.decode(type, \.decodeInt64) { try wrapped.decode(type) }
    }
    
    func decode(_ type: UInt.Type) throws -> UInt {
        try decoder.decode(type, \.decodeUInt) { try wrapped.decode(type) }
    }
    
    func decode(_ type: UInt8.Type) throws -> UInt8 {
        try decoder.decode(type, \.decodeUInt8) { try wrapped.decode(type) }
    }
    
    func decode(_ type: UInt16.Type) throws -> UInt16 {
        try decoder.decode(type, \.decodeUInt16) { try wrapped.decode(type) }
    }
    
    func decode(_ type: UInt32.Type) throws -> UInt32 {
        try decoder.decode(type, \.decodeUInt32) { try wrapped.decode(type) }
    }
    
    func decode(_ type: UInt64.Type) throws -> UInt64 {
        try decoder.decode(type, \.decodeUInt64) { try wrapped.decode(type) }
    }
    
    func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        try decoder.decode(type) { try wrapped.decode(type) }
    }
    
    func decodeIfPresent(_ type: Bool.Type) throws -> Bool? {
        try decoder.decodeIfPresent(present: !isAtEnd, \.decodeBoolIfNil, \.decodeBool) { try wrapped.decodeIfPresent(type) }
    }
    
    func decodeIfPresent(_ type: String.Type) throws -> String? {
        try decoder.decodeIfPresent(present: !isAtEnd, \.decodeStringIfNil, \.decodeString) { try wrapped.decodeIfPresent(type) }
    }
    
    func decodeIfPresent(_ type: Double.Type) throws -> Double? {
        try decoder.decodeIfPresent(present: !isAtEnd, \.decodeDoubleIfNil, \.decodeDouble) { try wrapped.decodeIfPresent(type) }
    }
    
    func decodeIfPresent(_ type: Float.Type) throws -> Float? {
        try decoder.decodeIfPresent(present: !isAtEnd, \.decodeFloatIfNil, \.decodeFloat) { try wrapped.decodeIfPresent(type) }
    }
    
    func decodeIfPresent(_ type: Int.Type) throws -> Int? {
        try decoder.decodeIfPresent(present: !isAtEnd, \.decodeIntIfNil, \.decodeInt) { try wrapped.decodeIfPresent(type) }
    }
    
    func decodeIfPresent(_ type: Int8.Type) throws -> Int8? {
        try decoder.decodeIfPresent(present: !isAtEnd, \.decodeInt8IfNil, \.decodeInt8) { try wrapped.decodeIfPresent(type) }
    }
    
    func decodeIfPresent(_ type: Int16.Type) throws -> Int16? {
        try decoder.decodeIfPresent(present: !isAtEnd, \.decodeInt16IfNil, \.decodeInt16) { try wrapped.decodeIfPresent(type) }
    }
    
    func decodeIfPresent(_ type: Int32.Type) throws -> Int32? {
        try decoder.decodeIfPresent(present: !isAtEnd, \.decodeInt32IfNil, \.decodeInt32) { try wrapped.decodeIfPresent(type) }
    }
    
    func decodeIfPresent(_ type: Int64.Type) throws -> Int64? {
        try decoder.decodeIfPresent(present: !isAtEnd, \.decodeInt64IfNil, \.decodeInt64) { try wrapped.decodeIfPresent(type) }
    }
    
    func decodeIfPresent(_ type: UInt.Type) throws -> UInt? {
        try decoder.decodeIfPresent(present: !isAtEnd, \.decodeUIntIfNil, \.decodeUInt) { try wrapped.decodeIfPresent(type) }
    }
    
    func decodeIfPresent(_ type: UInt8.Type) throws -> UInt8? {
        try decoder.decodeIfPresent(present: !isAtEnd, \.decodeUInt8IfNil, \.decodeUInt8) { try wrapped.decodeIfPresent(type) }
    }
    
    func decodeIfPresent(_ type: UInt16.Type) throws -> UInt16? {
        try decoder.decodeIfPresent(present: !isAtEnd, \.decodeUInt16IfNil, \.decodeUInt16) { try wrapped.decodeIfPresent(type) }
    }
    
    func decodeIfPresent(_ type: UInt32.Type) throws -> UInt32? {
        try decoder.decodeIfPresent(present: !isAtEnd, \.decodeUInt32IfNil, \.decodeUInt32) { try wrapped.decodeIfPresent(type) }
    }
    
    func decodeIfPresent(_ type: UInt64.Type) throws -> UInt64? {
        try decoder.decodeIfPresent(present: !isAtEnd, \.decodeUInt64IfNil, \.decodeUInt64) { try wrapped.decodeIfPresent(type) }
    }
    
    func decodeIfPresent<T>(_ type: T.Type) throws -> T? where T : Decodable {
        try decoder.decodeIfPresent(present: !isAtEnd) { try wrapped.decodeIfPresent(type) }
    }
    
    func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        try KeyedDecodingContainer(
            KeyedDecodingContainerWrapper(
                wrapped: wrapped.nestedContainer(keyedBy: AnyCodingKey.self),
                decoder: decoder
            )
        )
    }
    
    func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        try UnkeyedDecodingContainerWrapper(
            wrapped: wrapped.nestedUnkeyedContainer(),
            decoder: decoder
        )
    }
    
    func superDecoder() throws -> Decoder {
        try DecoderWrapper(wrapped.superDecoder(), strategy: _decoder.strategy)
    }
}

private struct SingleValueDecodingContainerWrapper: SingleValueDecodingContainer {
    
    var wrapped: SingleValueDecodingContainer
    let decoder: DecoderWrapper
    var codingPath: [CodingKey] { wrapped.codingPath }
    
    func decodeNil() -> Bool {
        (try? decoder.decode(Bool.self, \.decodeNil) { wrapped.decodeNil() }) ?? false
    }
    
    func decode(_ type: Bool.Type) throws -> Bool {
        try decoder.decode(type, \.decodeBool) { try wrapped.decode(type) }
    }
    
    func decode(_ type: String.Type) throws -> String {
        try decoder.decode(type, \.decodeString) { try wrapped.decode(type) }
    }
    
    func decode(_ type: Double.Type) throws -> Double {
        try decoder.decode(type, \.decodeDouble) { try wrapped.decode(type) }
    }
    
    func decode(_ type: Float.Type) throws -> Float {
        try decoder.decode(type, \.decodeFloat) { try wrapped.decode(type) }
    }
    
    func decode(_ type: Int.Type) throws -> Int {
        try decoder.decode(type, \.decodeInt) { try wrapped.decode(type) }
    }
    
    func decode(_ type: Int8.Type) throws -> Int8 {
        try decoder.decode(type, \.decodeInt8) { try wrapped.decode(type) }
    }
    
    func decode(_ type: Int16.Type) throws -> Int16 {
        try decoder.decode(type, \.decodeInt16) { try wrapped.decode(type) }
    }
    
    func decode(_ type: Int32.Type) throws -> Int32 {
        try decoder.decode(type, \.decodeInt32) { try wrapped.decode(type) }
    }
    
    func decode(_ type: Int64.Type) throws -> Int64 {
        try decoder.decode(type, \.decodeInt64) { try wrapped.decode(type) }
    }
    
    func decode(_ type: UInt.Type) throws -> UInt {
        try decoder.decode(type, \.decodeUInt) { try wrapped.decode(type) }
    }
    
    func decode(_ type: UInt8.Type) throws -> UInt8 {
        try decoder.decode(type, \.decodeUInt8) { try wrapped.decode(type) }
    }
    
    func decode(_ type: UInt16.Type) throws -> UInt16 {
        try decoder.decode(type, \.decodeUInt16) { try wrapped.decode(type) }
    }
    
    func decode(_ type: UInt32.Type) throws -> UInt32 {
        try decoder.decode(type, \.decodeUInt32) { try wrapped.decode(type) }
    }
    
    func decode(_ type: UInt64.Type) throws -> UInt64 {
        try decoder.decode(type, \.decodeUInt64) { try wrapped.decode(type) }
    }
    
    func decode<T: Decodable>(_ type: T.Type) throws -> T {
        try decoder.decode(type) {
            try wrapped.decode(type)
        }
    }
}

private struct KeyedContainerDecoder: Decoder, SingleValueDecodingContainer {
    
    let key: AnyCodingKey
    @Ref var base: KeyedDecodingContainer<AnyCodingKey>
    let userInfo: [CodingUserInfoKey: Any]
    var codingPath: [CodingKey] { base.codingPath + [key] }
    
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        try base.nestedContainer(keyedBy: type, forKey: key)
    }
    
    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        try base.nestedUnkeyedContainer(forKey: key)
    }
    
    func singleValueContainer() throws -> SingleValueDecodingContainer {
        self
    }
    
    func decodeNil() -> Bool { (try? base.decodeNil(forKey: key)) ?? false }
    func decode(_ type: Bool.Type) throws -> Bool { try base.decode(type, forKey: key) }
    func decode(_ type: String.Type) throws -> String { try base.decode(type, forKey: key) }
    func decode(_ type: Double.Type) throws -> Double { try base.decode(type, forKey: key) }
    func decode(_ type: Float.Type) throws -> Float { try base.decode(type, forKey: key) }
    func decode(_ type: Int.Type) throws -> Int { try base.decode(type, forKey: key) }
    func decode(_ type: Int8.Type) throws -> Int8 { try base.decode(type, forKey: key) }
    func decode(_ type: Int16.Type) throws -> Int16 { try base.decode(type, forKey: key) }
    func decode(_ type: Int32.Type) throws -> Int32 { try base.decode(type, forKey: key) }
    func decode(_ type: Int64.Type) throws -> Int64 { try base.decode(type, forKey: key) }
    func decode(_ type: UInt.Type) throws -> UInt { try base.decode(type, forKey: key) }
    func decode(_ type: UInt8.Type) throws -> UInt8 { try base.decode(type, forKey: key) }
    func decode(_ type: UInt16.Type) throws -> UInt16 { try base.decode(type, forKey: key) }
    func decode(_ type: UInt32.Type) throws -> UInt32 { try base.decode(type, forKey: key) }
    func decode(_ type: UInt64.Type) throws -> UInt64 { try base.decode(type, forKey: key) }
    func decode<T: Decodable>(_ type: T.Type) throws -> T { try base.decode(type, forKey: key) }
}

private struct UnkeyedContainerDecoder: Decoder, SingleValueDecodingContainer {
    
    @Ref var base: UnkeyedDecodingContainer
    let userInfo: [CodingUserInfoKey: Any]
    var codingPath: [CodingKey] { base.codingPath + [AnyCodingKey(intValue: base.currentIndex)] }
    
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        try base.nestedContainer(keyedBy: type)
    }
    
    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        try base.nestedUnkeyedContainer()
    }
    
    func singleValueContainer() throws -> SingleValueDecodingContainer {
        self
    }
    
    func decodeNil() -> Bool { (try? base.decodeNil()) ?? false }
    func decode(_ type: Bool.Type) throws -> Bool { try base.decode(type) }
    func decode(_ type: String.Type) throws -> String { try base.decode(type) }
    func decode(_ type: Double.Type) throws -> Double { try base.decode(type) }
    func decode(_ type: Float.Type) throws -> Float { try base.decode(type) }
    func decode(_ type: Int.Type) throws -> Int { try base.decode(type) }
    func decode(_ type: Int8.Type) throws -> Int8 { try base.decode(type) }
    func decode(_ type: Int16.Type) throws -> Int16 { try base.decode(type) }
    func decode(_ type: Int32.Type) throws -> Int32 { try base.decode(type) }
    func decode(_ type: Int64.Type) throws -> Int64 { try base.decode(type) }
    func decode(_ type: UInt.Type) throws -> UInt { try base.decode(type) }
    func decode(_ type: UInt8.Type) throws -> UInt8 { try base.decode(type) }
    func decode(_ type: UInt16.Type) throws -> UInt16 { try base.decode(type) }
    func decode(_ type: UInt32.Type) throws -> UInt32 { try base.decode(type) }
    func decode(_ type: UInt64.Type) throws -> UInt64 { try base.decode(type) }
    func decode<T: Decodable>(_ type: T.Type) throws -> T { try base.decode(type) }
}
