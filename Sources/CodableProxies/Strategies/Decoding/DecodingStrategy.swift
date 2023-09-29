import Foundation

public struct DecodingStrategy {
    
    let decodeNil: ((Decoder) throws -> Swift.Bool)?
    let decodeBool: ((Decoder) throws -> Swift.Bool)?
    let decodeString: ((Decoder) throws -> Swift.String)?
    let decodeDouble: ((Decoder) throws -> Swift.Double)?
    let decodeFloat: ((Decoder) throws -> Swift.Float)?
    let decodeInt: ((Decoder) throws -> Swift.Int)?
    let decodeInt8: ((Decoder) throws -> Swift.Int8)?
    let decodeInt16: ((Decoder) throws -> Swift.Int16)?
    let decodeInt32: ((Decoder) throws -> Swift.Int32)?
    let decodeInt64: ((Decoder) throws -> Swift.Int64)?
    let decodeUInt: ((Decoder) throws -> Swift.UInt)?
    let decodeUInt8: ((Decoder) throws -> Swift.UInt8)?
    let decodeUInt16: ((Decoder) throws -> Swift.UInt16)?
    let decodeUInt32: ((Decoder) throws -> Swift.UInt32)?
    let decodeUInt64: ((Decoder) throws -> Swift.UInt64)?
    let decodeDecodable: ((Decodable.Type, Decoder) throws -> Decodable?)?
    
    let decodeBoolIfNil: ((Decoder) throws -> Swift.Bool?)?
    let decodeStringIfNil: ((Decoder) throws -> Swift.String?)?
    let decodeDoubleIfNil: ((Decoder) throws -> Swift.Double?)?
    let decodeFloatIfNil: ((Decoder) throws -> Swift.Float?)?
    let decodeIntIfNil: ((Decoder) throws -> Swift.Int?)?
    let decodeInt8IfNil: ((Decoder) throws -> Swift.Int8?)?
    let decodeInt16IfNil: ((Decoder) throws -> Swift.Int16?)?
    let decodeInt32IfNil: ((Decoder) throws -> Swift.Int32?)?
    let decodeInt64IfNil: ((Decoder) throws -> Swift.Int64?)?
    let decodeUIntIfNil: ((Decoder) throws -> Swift.UInt?)?
    let decodeUInt8IfNil: ((Decoder) throws -> Swift.UInt8?)?
    let decodeUInt16IfNil: ((Decoder) throws -> Swift.UInt16?)?
    let decodeUInt32IfNil: ((Decoder) throws -> Swift.UInt32?)?
    let decodeUInt64IfNil: ((Decoder) throws -> Swift.UInt64?)?
    let decodeDecodableIfNil: ((Decodable.Type, Decoder) throws -> Decodable?)?
    
    let decodeKey: ((String) -> Swift.String)?
    
    init(
        decodeNil: ((Decoder) throws -> Swift.Bool)? = nil,
        decodeBool: ((Decoder) throws -> Swift.Bool)? = nil,
        decodeString: ((Decoder) throws -> Swift.String)? = nil,
        decodeDouble: ((Decoder) throws -> Swift.Double)? = nil,
        decodeFloat: ((Decoder) throws -> Swift.Float)? = nil,
        decodeInt: ((Decoder) throws -> Swift.Int)? = nil,
        decodeInt8: ((Decoder) throws -> Swift.Int8)? = nil,
        decodeInt16: ((Decoder) throws -> Swift.Int16)? = nil,
        decodeInt32: ((Decoder) throws -> Swift.Int32)? = nil,
        decodeInt64: ((Decoder) throws -> Swift.Int64)? = nil,
        decodeUInt: ((Decoder) throws -> Swift.UInt)? = nil,
        decodeUInt8: ((Decoder) throws -> Swift.UInt8)? = nil,
        decodeUInt16: ((Decoder) throws -> Swift.UInt16)? = nil,
        decodeUInt32: ((Decoder) throws -> Swift.UInt32)? = nil,
        decodeUInt64: ((Decoder) throws -> Swift.UInt64)? = nil,
        decodeDecodable: ((Decodable.Type, Decoder) throws -> Decodable?)? = nil,
        decodeBoolIfNil: ((Decoder) throws -> Swift.Bool?)? = nil,
        decodeStringIfNil: ((Decoder) throws -> Swift.String?)? = nil,
        decodeDoubleIfNil: ((Decoder) throws -> Swift.Double?)? = nil,
        decodeFloatIfNil: ((Decoder) throws -> Swift.Float?)? = nil,
        decodeIntIfNil: ((Decoder) throws -> Swift.Int?)? = nil,
        decodeInt8IfNil: ((Decoder) throws -> Swift.Int8?)? = nil,
        decodeInt16IfNil: ((Decoder) throws -> Swift.Int16?)? = nil,
        decodeInt32IfNil: ((Decoder) throws -> Swift.Int32?)? = nil,
        decodeInt64IfNil: ((Decoder) throws -> Swift.Int64?)? = nil,
        decodeUIntIfNil: ((Decoder) throws -> Swift.UInt?)? = nil,
        decodeUInt8IfNil: ((Decoder) throws -> Swift.UInt8?)? = nil,
        decodeUInt16IfNil: ((Decoder) throws -> Swift.UInt16?)? = nil,
        decodeUInt32IfNil: ((Decoder) throws -> Swift.UInt32?)? = nil,
        decodeUInt64IfNil: ((Decoder) throws -> Swift.UInt64?)? = nil,
        decodeDecodableIfNil: ((Decodable.Type, Decoder) throws -> Decodable?)? = nil,
        decodeKey: ((String) -> Swift.String)? = nil
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
    
    init(nil decode: @escaping (Decoder) throws -> Swift.Bool) { self.init(decodeNil: decode) }
    init(_ type: Swift.Bool.Type, decode: @escaping (Decoder) throws -> Swift.Bool) { self.init(decodeBool: decode) }
    init(_ type: Swift.String.Type, decode: @escaping (Decoder) throws -> Swift.String) { self.init(decodeString: decode) }
    init(_ type: Swift.Double.Type, decode: @escaping (Decoder) throws -> Swift.Double) { self.init(decodeDouble: decode) }
    init(_ type: Swift.Float.Type, decode: @escaping (Decoder) throws -> Swift.Float) { self.init(decodeFloat: decode) }
    init(_ type: Swift.Int.Type, decode: @escaping (Decoder) throws -> Swift.Int) { self.init(decodeInt: decode) }
    init(_ type: Swift.Int8.Type, decode: @escaping (Decoder) throws -> Swift.Int8) { self.init(decodeInt8: decode) }
    init(_ type: Swift.Int16.Type, decode: @escaping (Decoder) throws -> Swift.Int16) { self.init(decodeInt16: decode) }
    init(_ type: Swift.Int32.Type, decode: @escaping (Decoder) throws -> Swift.Int32) { self.init(decodeInt32: decode) }
    init(_ type: Swift.Int64.Type, decode: @escaping (Decoder) throws -> Swift.Int64) { self.init(decodeInt64: decode) }
    init(_ type: Swift.UInt.Type, decode: @escaping (Decoder) throws -> Swift.UInt) { self.init(decodeUInt: decode) }
    init(_ type: Swift.UInt8.Type, decode: @escaping (Decoder) throws -> Swift.UInt8) { self.init(decodeUInt8: decode) }
    init(_ type: Swift.UInt16.Type, decode: @escaping (Decoder) throws -> Swift.UInt16) { self.init(decodeUInt16: decode) }
    init(_ type: Swift.UInt32.Type, decode: @escaping (Decoder) throws -> Swift.UInt32) { self.init(decodeUInt32: decode) }
    init(_ type: Swift.UInt64.Type, decode: @escaping (Decoder) throws -> Swift.UInt64) { self.init(decodeUInt64: decode) }
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
    
    init(ifNil type: Swift.Bool.Type, decode: @escaping (Decoder) throws -> Swift.Bool?) { self.init(decodeBoolIfNil: decode) }
    init(ifNil type: Swift.String.Type, decode: @escaping (Decoder) throws -> Swift.String?) { self.init(decodeStringIfNil: decode) }
    init(ifNil type: Swift.Double.Type, decode: @escaping (Decoder) throws -> Swift.Double?) { self.init(decodeDoubleIfNil: decode) }
    init(ifNil type: Swift.Float.Type, decode: @escaping (Decoder) throws -> Swift.Float?) { self.init(decodeFloatIfNil: decode) }
    init(ifNil type: Swift.Int.Type, decode: @escaping (Decoder) throws -> Swift.Int?) { self.init(decodeIntIfNil: decode) }
    init(ifNil type: Swift.Int8.Type, decode: @escaping (Decoder) throws -> Swift.Int8?) { self.init(decodeInt8IfNil: decode) }
    init(ifNil type: Swift.Int16.Type, decode: @escaping (Decoder) throws -> Swift.Int16?) { self.init(decodeInt16IfNil: decode) }
    init(ifNil type: Swift.Int32.Type, decode: @escaping (Decoder) throws -> Swift.Int32?) { self.init(decodeInt32IfNil: decode) }
    init(ifNil type: Swift.Int64.Type, decode: @escaping (Decoder) throws -> Swift.Int64?) { self.init(decodeInt64IfNil: decode) }
    init(ifNil type: Swift.UInt.Type, decode: @escaping (Decoder) throws -> Swift.UInt?) { self.init(decodeUIntIfNil: decode) }
    init(ifNil type: Swift.UInt8.Type, decode: @escaping (Decoder) throws -> Swift.UInt8?) { self.init(decodeUInt8IfNil: decode) }
    init(ifNil type: Swift.UInt16.Type, decode: @escaping (Decoder) throws -> Swift.UInt16?) { self.init(decodeUInt16IfNil: decode) }
    init(ifNil type: Swift.UInt32.Type, decode: @escaping (Decoder) throws -> Swift.UInt32?) { self.init(decodeUInt32IfNil: decode) }
    init(ifNil type: Swift.UInt64.Type, decode: @escaping (Decoder) throws -> Swift.UInt64?) { self.init(decodeUInt64IfNil: decode) }
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
            decodeNil: tryBoth(other.decodeNil, decodeNil),
            decodeBool: tryBoth(other.decodeBool, decodeBool),
            decodeString: tryBoth(other.decodeString, decodeString),
            decodeDouble: tryBoth(other.decodeDouble, decodeDouble),
            decodeFloat: tryBoth(other.decodeFloat, decodeFloat),
            decodeInt: tryBoth(other.decodeInt, decodeInt),
            decodeInt8: tryBoth(other.decodeInt8, decodeInt8),
            decodeInt16: tryBoth(other.decodeInt16, decodeInt16),
            decodeInt32: tryBoth(other.decodeInt32, decodeInt32),
            decodeInt64: tryBoth(other.decodeInt64, decodeInt64),
            decodeUInt: tryBoth(other.decodeUInt, decodeUInt),
            decodeUInt8: tryBoth(other.decodeUInt8, decodeUInt8),
            decodeUInt16: tryBoth(other.decodeUInt16, decodeUInt16),
            decodeUInt32: tryBoth(other.decodeUInt32, decodeUInt32),
            decodeUInt64: tryBoth(other.decodeUInt64, decodeUInt64),
            decodeDecodable: other.decodeDecodable.map { decodeDecodable in
                {
                    try decodeDecodable($0, $1) ?? self.decodeDecodable?($0, $1)
                }
            } ?? decodeDecodable,
            decodeBoolIfNil: tryBoth(other.decodeBoolIfNil, decodeBoolIfNil),
            decodeStringIfNil: tryBoth(other.decodeStringIfNil, decodeStringIfNil),
            decodeDoubleIfNil: tryBoth(other.decodeDoubleIfNil, decodeDoubleIfNil),
            decodeFloatIfNil: tryBoth(other.decodeFloatIfNil, decodeFloatIfNil),
            decodeIntIfNil: tryBoth(other.decodeIntIfNil, decodeIntIfNil),
            decodeInt8IfNil: tryBoth(other.decodeInt8IfNil, decodeInt8IfNil),
            decodeInt16IfNil: tryBoth(other.decodeInt16IfNil, decodeInt16IfNil),
            decodeInt32IfNil: tryBoth(other.decodeInt32IfNil, decodeInt32IfNil),
            decodeInt64IfNil: tryBoth(other.decodeInt64IfNil, decodeInt64IfNil),
            decodeUIntIfNil: tryBoth(other.decodeUIntIfNil, decodeUIntIfNil),
            decodeUInt8IfNil: tryBoth(other.decodeUInt8IfNil, decodeUInt8IfNil),
            decodeUInt16IfNil: tryBoth(other.decodeUInt16IfNil, decodeUInt16IfNil),
            decodeUInt32IfNil: tryBoth(other.decodeUInt32IfNil, decodeUInt32IfNil),
            decodeUInt64IfNil: tryBoth(other.decodeUInt64IfNil, decodeUInt64IfNil),
            decodeDecodableIfNil: other.decodeDecodableIfNil.map { decodeDecodableIfNil in
                {
                    try decodeDecodableIfNil($0, $1) ?? self.decodeDecodableIfNil?($0, $1)
                }
            } ?? decodeDecodableIfNil,
            decodeKey: other.decodeKey ?? decodeKey
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

private func tryBoth<T>(_ first: ((Decoder) throws -> T)?, _ second: ((Decoder) throws -> T)?) -> ((Decoder) throws -> T)? {
    return first.map { first in
        { decoder in
            do {
                return try first(decoder)
            } catch {
                if let second {
                    return try second(decoder)
                }
                throw error
            }
        }
    } ?? second
}
