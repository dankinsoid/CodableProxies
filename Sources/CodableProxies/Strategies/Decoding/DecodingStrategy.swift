import Foundation

public struct DecodingStrategy {
    
    let decodeNil: ((Decoder) throws -> Void)?
    let decodeBool: ((Decoder) throws -> Bool)?
    let decodeString: ((Decoder) throws -> String)?
    let decodeDouble: ((Decoder) throws -> Double)?
    let decodeFloat: ((Decoder) throws -> Float)?
    let decodeInt: ((Decoder) throws -> Int)?
    let decodeInt8: ((Decoder) throws -> Int8)?
    let decodeInt16: ((Decoder) throws -> Int16)?
    let decodeInt32: ((Decoder) throws -> Int32)?
    let decodeInt64: ((Decoder) throws -> Int64)?
    let decodeUInt: ((Decoder) throws -> UInt)?
    let decodeUInt8: ((Decoder) throws -> UInt8)?
    let decodeUInt16: ((Decoder) throws -> UInt16)?
    let decodeUInt32: ((Decoder) throws -> UInt32)?
    let decodeUInt64: ((Decoder) throws -> UInt64)?
    let decodeDecodable: ((Decodable.Type, Decoder) throws -> Decodable?)?
    
    let decodeBoolIfNil: ((Decoder) throws -> Bool)?
    let decodeStringIfNil: ((Decoder) throws -> String)?
    let decodeDoubleIfNil: ((Decoder) throws -> Double)?
    let decodeFloatIfNil: ((Decoder) throws -> Float)?
    let decodeIntIfNil: ((Decoder) throws -> Int)?
    let decodeInt8IfNil: ((Decoder) throws -> Int8)?
    let decodeInt16IfNil: ((Decoder) throws -> Int16)?
    let decodeInt32IfNil: ((Decoder) throws -> Int32)?
    let decodeInt64IfNil: ((Decoder) throws -> Int64)?
    let decodeUIntIfNil: ((Decoder) throws -> UInt)?
    let decodeUInt8IfNil: ((Decoder) throws -> UInt8)?
    let decodeUInt16IfNil: ((Decoder) throws -> UInt16)?
    let decodeUInt32IfNil: ((Decoder) throws -> UInt32)?
    let decodeUInt64IfNil: ((Decoder) throws -> UInt64)?
    let decodeDecodableIfNil: ((Decodable.Type, Decoder) throws -> Decodable?)?
    
    let decodeKey: ((String) -> String)?
    
    init(
        decodeNil: ((Decoder) throws -> Void)? = nil,
        decodeBool: ((Decoder) throws -> Bool)? = nil,
        decodeString: ((Decoder) throws -> String)? = nil,
        decodeDouble: ((Decoder) throws -> Double)? = nil,
        decodeFloat: ((Decoder) throws -> Float)? = nil,
        decodeInt: ((Decoder) throws -> Int)? = nil,
        decodeInt8: ((Decoder) throws -> Int8)? = nil,
        decodeInt16: ((Decoder) throws -> Int16)? = nil,
        decodeInt32: ((Decoder) throws -> Int32)? = nil,
        decodeInt64: ((Decoder) throws -> Int64)? = nil,
        decodeUInt: ((Decoder) throws -> UInt)? = nil,
        decodeUInt8: ((Decoder) throws -> UInt8)? = nil,
        decodeUInt16: ((Decoder) throws -> UInt16)? = nil,
        decodeUInt32: ((Decoder) throws -> UInt32)? = nil,
        decodeUInt64: ((Decoder) throws -> UInt64)? = nil,
        decodeDecodable: ((Decodable.Type, Decoder) throws -> Decodable?)? = nil,
        decodeBoolIfNil: ((Decoder) throws -> Bool)? = nil,
        decodeStringIfNil: ((Decoder) throws -> String)? = nil,
        decodeDoubleIfNil: ((Decoder) throws -> Double)? = nil,
        decodeFloatIfNil: ((Decoder) throws -> Float)? = nil,
        decodeIntIfNil: ((Decoder) throws -> Int)? = nil,
        decodeInt8IfNil: ((Decoder) throws -> Int8)? = nil,
        decodeInt16IfNil: ((Decoder) throws -> Int16)? = nil,
        decodeInt32IfNil: ((Decoder) throws -> Int32)? = nil,
        decodeInt64IfNil: ((Decoder) throws -> Int64)? = nil,
        decodeUIntIfNil: ((Decoder) throws -> UInt)? = nil,
        decodeUInt8IfNil: ((Decoder) throws -> UInt8)? = nil,
        decodeUInt16IfNil: ((Decoder) throws -> UInt16)? = nil,
        decodeUInt32IfNil: ((Decoder) throws -> UInt32)? = nil,
        decodeUInt64IfNil: ((Decoder) throws -> UInt64)? = nil,
        decodeDecodableIfNil: ((Decodable.Type, Decoder) throws -> Decodable?)? = nil,
        decodeKey: ((String) -> String)? = nil
    ) {
        self.decodeNil = decodeNil
        self.decodeBool = decodeBool
        self.decodeString = decodeString
        self.decodeDouble = decodeDouble
        self.decodeFloat = decodeFloat
        self.decodeInt = decodeInt
        self.decodeInt8 = decodeInt8
        self.decodeInt16 = decodeInt16
        self.decodeInt32 = decodeInt32
        self.decodeInt64 = decodeInt64
        self.decodeUInt = decodeUInt
        self.decodeUInt8 = decodeUInt8
        self.decodeUInt16 = decodeUInt16
        self.decodeUInt32 = decodeUInt32
        self.decodeUInt64 = decodeUInt64
        self.decodeDecodable = decodeDecodable
        self.decodeBoolIfNil = decodeBoolIfNil
        self.decodeStringIfNil = decodeStringIfNil
        self.decodeDoubleIfNil = decodeDoubleIfNil
        self.decodeFloatIfNil = decodeFloatIfNil
        self.decodeIntIfNil = decodeIntIfNil
        self.decodeInt8IfNil = decodeInt8IfNil
        self.decodeInt16IfNil = decodeInt16IfNil
        self.decodeInt32IfNil = decodeInt32IfNil
        self.decodeInt64IfNil = decodeInt64IfNil
        self.decodeUIntIfNil = decodeUIntIfNil
        self.decodeUInt8IfNil = decodeUInt8IfNil
        self.decodeUInt16IfNil = decodeUInt16IfNil
        self.decodeUInt32IfNil = decodeUInt32IfNil
        self.decodeUInt64IfNil = decodeUInt64IfNil
        self.decodeDecodableIfNil = decodeDecodableIfNil
        self.decodeKey = decodeKey
    }
}

public extension DecodingStrategy {
    
    init(nil decode: @escaping (Decoder) throws -> Void) { self.init(decodeNil: decode) }
    init(_ type: Bool.Type, decode: @escaping (Decoder) throws -> Bool) { self.init(decodeBool: decode) }
    init(_ type: String.Type, decode: @escaping (Decoder) throws -> String) { self.init(decodeString: decode) }
    init(_ type: Double.Type, decode: @escaping (Decoder) throws -> Double) { self.init(decodeDouble: decode) }
    init(_ type: Float.Type, decode: @escaping (Decoder) throws -> Float) { self.init(decodeFloat: decode) }
    init(_ type: Int.Type, decode: @escaping (Decoder) throws -> Int) { self.init(decodeInt: decode) }
    init(_ type: Int8.Type, decode: @escaping (Decoder) throws -> Int8) { self.init(decodeInt8: decode) }
    init(_ type: Int16.Type, decode: @escaping (Decoder) throws -> Int16) { self.init(decodeInt16: decode) }
    init(_ type: Int32.Type, decode: @escaping (Decoder) throws -> Int32) { self.init(decodeInt32: decode) }
    init(_ type: Int64.Type, decode: @escaping (Decoder) throws -> Int64) { self.init(decodeInt64: decode) }
    init(_ type: UInt.Type, decode: @escaping (Decoder) throws -> UInt) { self.init(decodeUInt: decode) }
    init(_ type: UInt8.Type, decode: @escaping (Decoder) throws -> UInt8) { self.init(decodeUInt8: decode) }
    init(_ type: UInt16.Type, decode: @escaping (Decoder) throws -> UInt16) { self.init(decodeUInt16: decode) }
    init(_ type: UInt32.Type, decode: @escaping (Decoder) throws -> UInt32) { self.init(decodeUInt32: decode) }
    init(_ type: UInt64.Type, decode: @escaping (Decoder) throws -> UInt64) { self.init(decodeUInt64: decode) }
    init(decode: @escaping (Decodable.Type, Decoder) throws -> Decodable?) { self.init(decodeDecodable: decode) }
    
    init<T: Decodable>(
        _ type: T.Type,
        decode: @escaping (Decoder) throws -> T
    ) {
        self.init(
            decodeDecodable: {
                guard $0 is T.Type else {
                    return nil
                }
                return try decode($1)
            }
        )
    }
    
    init(ifNil type: Bool.Type, decode: @escaping (Decoder) throws -> Bool) { self.init(decodeBoolIfNil: decode) }
    init(ifNil type: String.Type, decode: @escaping (Decoder) throws -> String) { self.init(decodeStringIfNil: decode) }
    init(ifNil type: Double.Type, decode: @escaping (Decoder) throws -> Double) { self.init(decodeDoubleIfNil: decode) }
    init(ifNil type: Float.Type, decode: @escaping (Decoder) throws -> Float) { self.init(decodeFloatIfNil: decode) }
    init(ifNil type: Int.Type, decode: @escaping (Decoder) throws -> Int) { self.init(decodeIntIfNil: decode) }
    init(ifNil type: Int8.Type, decode: @escaping (Decoder) throws -> Int8) { self.init(decodeInt8IfNil: decode) }
    init(ifNil type: Int16.Type, decode: @escaping (Decoder) throws -> Int16) { self.init(decodeInt16IfNil: decode) }
    init(ifNil type: Int32.Type, decode: @escaping (Decoder) throws -> Int32) { self.init(decodeInt32IfNil: decode) }
    init(ifNil type: Int64.Type, decode: @escaping (Decoder) throws -> Int64) { self.init(decodeInt64IfNil: decode) }
    init(ifNil type: UInt.Type, decode: @escaping (Decoder) throws -> UInt) { self.init(decodeUIntIfNil: decode) }
    init(ifNil type: UInt8.Type, decode: @escaping (Decoder) throws -> UInt8) { self.init(decodeUInt8IfNil: decode) }
    init(ifNil type: UInt16.Type, decode: @escaping (Decoder) throws -> UInt16) { self.init(decodeUInt16IfNil: decode) }
    init(ifNil type: UInt32.Type, decode: @escaping (Decoder) throws -> UInt32) { self.init(decodeUInt32IfNil: decode) }
    init(ifNil type: UInt64.Type, decode: @escaping (Decoder) throws -> UInt64) { self.init(decodeUInt64IfNil: decode) }
    init(decodeIfNil: @escaping (Decodable.Type, Decoder) throws -> Decodable?) { self.init(decodeDecodableIfNil: decodeIfNil) }
    
    init<T: Decodable>(
        ifNil type: T.Type,
        decode: @escaping (Decoder) throws -> T
    ) {
        self.init(
            decodeDecodableIfNil: {
                guard $0 is T.Type else {
                    return nil
                }
                return try decode($1)
            }
        )
    }
    
    func merging(with other: DecodingStrategy) -> DecodingStrategy {
        DecodingStrategy(
            decodeNil: self.decodeNil ?? other.decodeNil,
            decodeBool: self.decodeBool ?? other.decodeBool,
            decodeString: self.decodeString ?? other.decodeString,
            decodeDouble: self.decodeDouble ?? other.decodeDouble,
            decodeFloat: self.decodeFloat ?? other.decodeFloat,
            decodeInt: self.decodeInt ?? other.decodeInt,
            decodeInt8: self.decodeInt8 ?? other.decodeInt8,
            decodeInt16: self.decodeInt16 ?? other.decodeInt16,
            decodeInt32: self.decodeInt32 ?? other.decodeInt32,
            decodeInt64: self.decodeInt64 ?? other.decodeInt64,
            decodeUInt: self.decodeUInt ?? other.decodeUInt,
            decodeUInt8: self.decodeUInt8 ?? other.decodeUInt8,
            decodeUInt16: self.decodeUInt16 ?? other.decodeUInt16,
            decodeUInt32: self.decodeUInt32 ?? other.decodeUInt32,
            decodeUInt64: self.decodeUInt64 ?? other.decodeUInt64,
            decodeDecodable: self.decodeDecodable.map { decodeDecodable in
                {
                    try decodeDecodable($0, $1) ?? other.decodeDecodable?($0, $1)
                }
            } ?? other.decodeDecodable,
            decodeBoolIfNil: self.decodeBoolIfNil ?? other.decodeBoolIfNil,
            decodeStringIfNil: self.decodeStringIfNil ?? other.decodeStringIfNil,
            decodeDoubleIfNil: self.decodeDoubleIfNil ?? other.decodeDoubleIfNil,
            decodeFloatIfNil: self.decodeFloatIfNil ?? other.decodeFloatIfNil,
            decodeIntIfNil: self.decodeIntIfNil ?? other.decodeIntIfNil,
            decodeInt8IfNil: self.decodeInt8IfNil ?? other.decodeInt8IfNil,
            decodeInt16IfNil: self.decodeInt16IfNil ?? other.decodeInt16IfNil,
            decodeInt32IfNil: self.decodeInt32IfNil ?? other.decodeInt32IfNil,
            decodeInt64IfNil: self.decodeInt64IfNil ?? other.decodeInt64IfNil,
            decodeUIntIfNil: self.decodeUIntIfNil ?? other.decodeUIntIfNil,
            decodeUInt8IfNil: self.decodeUInt8IfNil ?? other.decodeUInt8IfNil,
            decodeUInt16IfNil: self.decodeUInt16IfNil ?? other.decodeUInt16IfNil,
            decodeUInt32IfNil: self.decodeUInt32IfNil ?? other.decodeUInt32IfNil,
            decodeUInt64IfNil: self.decodeUInt64IfNil ?? other.decodeUInt64IfNil,
            decodeDecodableIfNil: self.decodeDecodableIfNil.map { decodeDecodableIfNil in
                {
                    try decodeDecodableIfNil($0, $1) ?? other.decodeDecodableIfNil?($0, $1)
                }
            } ?? other.decodeDecodableIfNil,
            decodeKey: self.decodeKey ?? other.decodeKey
        )
    }
}

extension DecodingStrategy: ExpressibleByArrayLiteral {
    
    @_disfavoredOverload
    public init(arrayLiteral elements: DecodingStrategy...) {
        self = elements.reduce(DecodingStrategy(), { $0.merging(with: $1) })
    }
}

extension DecodingStrategy {
    
    public static var `default`: DecodingStrategy = [.Date.default, .URL.default, .Decimal.default]
}
