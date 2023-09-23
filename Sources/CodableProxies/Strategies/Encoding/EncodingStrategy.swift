import Foundation

public struct EncodingStrategy {
    
    let encodeNil: ((_ value: Void, Encoder) throws -> Void)?
    let encodeBool: ((_ value: Bool, Encoder) throws -> Void)?
    let encodeString: ((_ value: String, Encoder) throws -> Void)?
    let encodeDouble: ((_ value: Double, Encoder) throws -> Void)?
    let encodeFloat: ((_ value: Float, Encoder) throws -> Void)?
    let encodeInt: ((_ value: Int, Encoder) throws -> Void)?
    let encodeInt8: ((_ value: Int8, Encoder) throws -> Void)?
    let encodeInt16: ((_ value: Int16, Encoder) throws -> Void)?
    let encodeInt32: ((_ value: Int32, Encoder) throws -> Void)?
    let encodeInt64: ((_ value: Int64, Encoder) throws -> Void)?
    let encodeUInt: ((_ value: UInt, Encoder) throws -> Void)?
    let encodeUInt8: ((_ value: UInt8, Encoder) throws -> Void)?
    let encodeUInt16: ((_ value: UInt16, Encoder) throws -> Void)?
    let encodeUInt32: ((_ value: UInt32, Encoder) throws -> Void)?
    let encodeUInt64: ((_ value: UInt64, Encoder) throws -> Void)?
    let encodeEncodable: ((_ value: Encodable, Encoder) throws -> Bool)?
    
    let encodeBoolIfNil: ((Encoder) throws -> Void)?
    let encodeStringIfNil: ((Encoder) throws -> Void)?
    let encodeDoubleIfNil: ((Encoder) throws -> Void)?
    let encodeFloatIfNil: ((Encoder) throws -> Void)?
    let encodeIntIfNil: ((Encoder) throws -> Void)?
    let encodeInt8IfNil: ((Encoder) throws -> Void)?
    let encodeInt16IfNil: ((Encoder) throws -> Void)?
    let encodeInt32IfNil: ((Encoder) throws -> Void)?
    let encodeInt64IfNil: ((Encoder) throws -> Void)?
    let encodeUIntIfNil: ((Encoder) throws -> Void)?
    let encodeUInt8IfNil: ((Encoder) throws -> Void)?
    let encodeUInt16IfNil: ((Encoder) throws -> Void)?
    let encodeUInt32IfNil: ((Encoder) throws -> Void)?
    let encodeUInt64IfNil: ((Encoder) throws -> Void)?
    let encodeEncodableIfNil: ((Any.Type, Encoder) throws -> Bool)?
    
    let encodeKey: ((String) -> String)?
    
    init(
        encodeNil: ((Void, Encoder) throws -> Void)? = nil,
        encodeBool: ((Bool, Encoder) throws -> Void)? = nil,
        encodeString: ((String, Encoder) throws -> Void)? = nil,
        encodeDouble: ((Double, Encoder) throws -> Void)? = nil,
        encodeFloat: ((Float, Encoder) throws -> Void)? = nil,
        encodeInt: ((Int, Encoder) throws -> Void)? = nil,
        encodeInt8: ((Int8, Encoder) throws -> Void)? = nil,
        encodeInt16: ((Int16, Encoder) throws -> Void)? = nil,
        encodeInt32: ((Int32, Encoder) throws -> Void)? = nil,
        encodeInt64: ((Int64, Encoder) throws -> Void)? = nil,
        encodeUInt: ((UInt, Encoder) throws -> Void)? = nil,
        encodeUInt8: ((UInt8, Encoder) throws -> Void)? = nil,
        encodeUInt16: ((UInt16, Encoder) throws -> Void)? = nil,
        encodeUInt32: ((UInt32, Encoder) throws -> Void)? = nil,
        encodeUInt64: ((UInt64, Encoder) throws -> Void)? = nil,
        encodeEncodable: ((Encodable, Encoder) throws -> Bool)? = nil,
        encodeBoolIfNil: ((Encoder) throws -> Void)? = nil,
        encodeStringIfNil: ((Encoder) throws -> Void)? = nil,
        encodeDoubleIfNil: ((Encoder) throws -> Void)? = nil,
        encodeFloatIfNil: ((Encoder) throws -> Void)? = nil,
        encodeIntIfNil: ((Encoder) throws -> Void)? = nil,
        encodeInt8IfNil: ((Encoder) throws -> Void)? = nil,
        encodeInt16IfNil: ((Encoder) throws -> Void)? = nil,
        encodeInt32IfNil: ((Encoder) throws -> Void)? = nil,
        encodeInt64IfNil: ((Encoder) throws -> Void)? = nil,
        encodeUIntIfNil: ((Encoder) throws -> Void)? = nil,
        encodeUInt8IfNil: ((Encoder) throws -> Void)? = nil,
        encodeUInt16IfNil: ((Encoder) throws -> Void)? = nil,
        encodeUInt32IfNil: ((Encoder) throws -> Void)? = nil,
        encodeUInt64IfNil: ((Encoder) throws -> Void)? = nil,
        encodeEncodableIfNil: ((Any.Type, Encoder) throws -> Bool)? = nil,
        encodeKey: ((String) -> String)? = nil
    ) {
        self.encodeNil = encodeNil
        self.encodeBool = encodeBool
        self.encodeString = encodeString
        self.encodeDouble = encodeDouble
        self.encodeFloat = encodeFloat
        self.encodeInt = encodeInt
        self.encodeInt8 = encodeInt8
        self.encodeInt16 = encodeInt16
        self.encodeInt32 = encodeInt32
        self.encodeInt64 = encodeInt64
        self.encodeUInt = encodeUInt
        self.encodeUInt8 = encodeUInt8
        self.encodeUInt16 = encodeUInt16
        self.encodeUInt32 = encodeUInt32
        self.encodeUInt64 = encodeUInt64
        self.encodeEncodable = encodeEncodable
        self.encodeBoolIfNil = encodeBoolIfNil
        self.encodeStringIfNil = encodeStringIfNil
        self.encodeDoubleIfNil = encodeDoubleIfNil
        self.encodeFloatIfNil = encodeFloatIfNil
        self.encodeIntIfNil = encodeIntIfNil
        self.encodeInt8IfNil = encodeInt8IfNil
        self.encodeInt16IfNil = encodeInt16IfNil
        self.encodeInt32IfNil = encodeInt32IfNil
        self.encodeInt64IfNil = encodeInt64IfNil
        self.encodeUIntIfNil = encodeUIntIfNil
        self.encodeUInt8IfNil = encodeUInt8IfNil
        self.encodeUInt16IfNil = encodeUInt16IfNil
        self.encodeUInt32IfNil = encodeUInt32IfNil
        self.encodeUInt64IfNil = encodeUInt64IfNil
        self.encodeEncodableIfNil = encodeEncodableIfNil
        self.encodeKey = encodeKey
    }
}

public extension EncodingStrategy {
    
    init(nil encode: @escaping (Encoder) throws -> Void) { self.init(encodeNil: { _, encoder in try encode(encoder) }) }
    init(_ type: Bool.Type, encode: @escaping (_ value: Bool, Encoder) throws -> Void) { self.init(encodeBool: encode) }
    init(_ type: String.Type, encode: @escaping (_ value: String, Encoder) throws -> Void) { self.init(encodeString: encode) }
    init(_ type: Double.Type, encode: @escaping (_ value: Double, Encoder) throws -> Void) { self.init(encodeDouble: encode) }
    init(_ type: Float.Type, encode: @escaping (_ value: Float, Encoder) throws -> Void) { self.init(encodeFloat: encode) }
    init(_ type: Int.Type, encode: @escaping (_ value: Int, Encoder) throws -> Void) { self.init(encodeInt: encode) }
    init(_ type: Int8.Type, encode: @escaping (_ value: Int8, Encoder) throws -> Void) { self.init(encodeInt8: encode) }
    init(_ type: Int16.Type, encode: @escaping (_ value: Int16, Encoder) throws -> Void) { self.init(encodeInt16: encode) }
    init(_ type: Int32.Type, encode: @escaping (_ value: Int32, Encoder) throws -> Void) { self.init(encodeInt32: encode) }
    init(_ type: Int64.Type, encode: @escaping (_ value: Int64, Encoder) throws -> Void) { self.init(encodeInt64: encode) }
    init(_ type: UInt.Type, encode: @escaping (_ value: UInt, Encoder) throws -> Void) { self.init(encodeUInt: encode) }
    init(_ type: UInt8.Type, encode: @escaping (_ value: UInt8, Encoder) throws -> Void) { self.init(encodeUInt8: encode) }
    init(_ type: UInt16.Type, encode: @escaping (_ value: UInt16, Encoder) throws -> Void) { self.init(encodeUInt16: encode) }
    init(_ type: UInt32.Type, encode: @escaping (_ value: UInt32, Encoder) throws -> Void) { self.init(encodeUInt32: encode) }
    init(_ type: UInt64.Type, encode: @escaping (_ value: UInt64, Encoder) throws -> Void) { self.init(encodeUInt64: encode) }
    init(encode: @escaping (_ value: Encodable, Encoder) throws -> Bool) { self.init(encodeEncodable: encode) }
    
    init<T: Encodable>(
        _ type: T.Type,
        encode: @escaping (_ value: T, Encoder) throws -> Void
    ) {
        self.init(
            encodeEncodable: {
                guard let value = $0 as? T else {
                    return false
                }
                try encode(value, $1)
                return true
            }
        )
    }
    
    init(ifPresent type: Bool.Type, encode: @escaping (Encoder) throws -> Void) { self.init(encodeBoolIfNil: encode) }
    init(ifPresent type: String.Type, encode: @escaping (Encoder) throws -> Void) { self.init(encodeStringIfNil: encode) }
    init(ifPresent type: Double.Type, encode: @escaping (Encoder) throws -> Void) { self.init(encodeDoubleIfNil: encode) }
    init(ifPresent type: Float.Type, encode: @escaping (Encoder) throws -> Void) { self.init(encodeFloatIfNil: encode) }
    init(ifPresent type: Int.Type, encode: @escaping (Encoder) throws -> Void) { self.init(encodeIntIfNil: encode) }
    init(ifPresent type: Int8.Type, encode: @escaping (Encoder) throws -> Void) { self.init(encodeInt8IfNil: encode) }
    init(ifPresent type: Int16.Type, encode: @escaping (Encoder) throws -> Void) { self.init(encodeInt16IfNil: encode) }
    init(ifPresent type: Int32.Type, encode: @escaping (Encoder) throws -> Void) { self.init(encodeInt32IfNil: encode) }
    init(ifPresent type: Int64.Type, encode: @escaping (Encoder) throws -> Void) { self.init(encodeInt64IfNil: encode) }
    init(ifPresent type: UInt.Type, encode: @escaping (Encoder) throws -> Void) { self.init(encodeUIntIfNil: encode) }
    init(ifPresent type: UInt8.Type, encode: @escaping (Encoder) throws -> Void) { self.init(encodeUInt8IfNil: encode) }
    init(ifPresent type: UInt16.Type, encode: @escaping (Encoder) throws -> Void) { self.init(encodeUInt16IfNil: encode) }
    init(ifPresent type: UInt32.Type, encode: @escaping (Encoder) throws -> Void) { self.init(encodeUInt32IfNil: encode) }
    init(ifPresent type: UInt64.Type, encode: @escaping (Encoder) throws -> Void) { self.init(encodeUInt64IfNil: encode) }
    init(encodeIfNil: @escaping (Any.Type, Encoder) throws -> Bool) { self.init(encodeEncodableIfNil: encodeIfNil) }
    
    init<T: Encodable>(
        ifNil type: T.Type,
        encode: @escaping (Encoder) throws -> Void
    ) {
        self.init(
            encodeEncodableIfNil: {
                guard $0 is T.Type else {
                    return false
                }
                try encode($1)
                return true
            }
        )
    }
    
    func merging(with other: EncodingStrategy) -> EncodingStrategy {
        EncodingStrategy(
            encodeNil: self.encodeNil ?? other.encodeNil,
            encodeBool: self.encodeBool ?? other.encodeBool,
            encodeString: self.encodeString ?? other.encodeString,
            encodeDouble: self.encodeDouble ?? other.encodeDouble,
            encodeFloat: self.encodeFloat ?? other.encodeFloat,
            encodeInt: self.encodeInt ?? other.encodeInt,
            encodeInt8: self.encodeInt8 ?? other.encodeInt8,
            encodeInt16: self.encodeInt16 ?? other.encodeInt16,
            encodeInt32: self.encodeInt32 ?? other.encodeInt32,
            encodeInt64: self.encodeInt64 ?? other.encodeInt64,
            encodeUInt: self.encodeUInt ?? other.encodeUInt,
            encodeUInt8: self.encodeUInt8 ?? other.encodeUInt8,
            encodeUInt16: self.encodeUInt16 ?? other.encodeUInt16,
            encodeUInt32: self.encodeUInt32 ?? other.encodeUInt32,
            encodeUInt64: self.encodeUInt64 ?? other.encodeUInt64,
            encodeEncodable: self.encodeEncodable.map { encodeEncodable in
                {
                    if try encodeEncodable($0, $1) {
                        return true
                    }
                    if let encode = other.encodeEncodable {
                        return try encode($0, $1)
                    }
                    return false
                }
            } ?? other.encodeEncodable,
            encodeBoolIfNil: self.encodeBoolIfNil ?? other.encodeBoolIfNil,
            encodeStringIfNil: self.encodeStringIfNil ?? other.encodeStringIfNil,
            encodeDoubleIfNil: self.encodeDoubleIfNil ?? other.encodeDoubleIfNil,
            encodeFloatIfNil: self.encodeFloatIfNil ?? other.encodeFloatIfNil,
            encodeIntIfNil: self.encodeIntIfNil ?? other.encodeIntIfNil,
            encodeInt8IfNil: self.encodeInt8IfNil ?? other.encodeInt8IfNil,
            encodeInt16IfNil: self.encodeInt16IfNil ?? other.encodeInt16IfNil,
            encodeInt32IfNil: self.encodeInt32IfNil ?? other.encodeInt32IfNil,
            encodeInt64IfNil: self.encodeInt64IfNil ?? other.encodeInt64IfNil,
            encodeUIntIfNil: self.encodeUIntIfNil ?? other.encodeUIntIfNil,
            encodeUInt8IfNil: self.encodeUInt8IfNil ?? other.encodeUInt8IfNil,
            encodeUInt16IfNil: self.encodeUInt16IfNil ?? other.encodeUInt16IfNil,
            encodeUInt32IfNil: self.encodeUInt32IfNil ?? other.encodeUInt32IfNil,
            encodeUInt64IfNil: self.encodeUInt64IfNil ?? other.encodeUInt64IfNil,
            encodeEncodableIfNil: self.encodeEncodableIfNil.map { encodeEncodableIfNil in
                {
                    if try encodeEncodableIfNil($0, $1) {
                        return true
                    }
                    if let encode = other.encodeEncodableIfNil {
                        return try encode($0, $1)
                    }
                    return false
                }
            } ?? other.encodeEncodableIfNil,
            encodeKey: self.encodeKey ?? other.encodeKey
        )
    }
}

extension EncodingStrategy: ExpressibleByArrayLiteral {
    
    @_disfavoredOverload
    public init(arrayLiteral elements: EncodingStrategy...) {
        self = elements.reduce(EncodingStrategy(), { $0.merging(with: $1) })
    }
}

extension EncodingStrategy {
    
    public static var `default`: EncodingStrategy = [.Date.default, .URL.default, .Decimal.default]
}
