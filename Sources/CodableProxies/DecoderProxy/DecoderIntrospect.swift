import Foundation

struct DecoderIntrospect<Value: Decodable>: Decodable {
    
    let value: Value
    
    init(from decoder: Decoder) throws {
        value = try Value(from: DecoderWrapper(decoder))
    }
}
