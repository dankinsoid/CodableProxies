import Foundation

struct DecoderIntrospect<Value: Decodable>: Decodable {
    
    let decoder: Decoder
    private var value: Value?
    
    init(from decoder: Decoder) throws {
        self.decoder = decoder
    }
    
    func decode(strategy: DecodingStrategy) throws -> Value {
        if let value { return value }
        let decoderWrapper = DecoderWrapper(decoder, strategy: strategy)
        return try decoderWrapper.decode(Value.self) {
            let value = try Value(from: decoderWrapper)
            var result = self
            result.value = value
            return result
        }
    }
}
