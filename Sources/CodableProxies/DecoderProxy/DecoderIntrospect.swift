import Foundation

extension DecodingStrategy {
    
    static var current: DecodingStrategy = .default
}

struct DecoderIntrospect<Value: Decodable>: Decodable {
    
    let value: Value
    
    init(_ value: Value) {
        self.value = value
    }
    
    init(from decoder: Decoder) throws {
        let decoder = DecoderWrapper(decoder, strategy: .current)
        value = try decoder.decode(Value.self) {
            try DecoderIntrospect(Value(from: decoder))
        }
    }
}
