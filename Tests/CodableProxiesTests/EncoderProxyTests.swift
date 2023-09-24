import XCTest
@testable import CodableProxies

final class EncoderProxyTests: XCTestCase {
    
    func test_EncoderProxy() throws {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        let encoder = EncoderProxy(
            jsonEncoder,
            strategy: [
                .default,
                .Decimal.string,
                .Numeric.string,
                .Bool.string,
                .Key.toSnakeCase,
                .Optional.null,
                EncodingStrategy(encodeIfNil: { type, encoder in
                    guard type is any Sequence.Type else {
                        return false
                    }
                    _ = encoder.unkeyedContainer()
                    return true
                })
            ]
        )
        let testStruct = TestStruct(
            int: 1,
            string: "2",
            decimal: 3.0,
            date: Date(),
            optionalInt: nil,
            url: URL(string: "https://www.google.com"),
            bool: true,
            keyWithCustomEncoding: "keyWithCustomEncoding",
            embedded: EmbeddedStruct(
                int: 1,
                string: "2",
                decimal: 3.0,
                date: Date(),
                optionalInt: nil,
                url: URL(string: "https://www.google.com"),
                bool: true,
                keyWithCustomEncoding: "keyWithCustomEncoding"
            ),
            optionalArray: nil
        )
        let encoded = try encoder.encode(testStruct)
        print(String(data: encoded, encoding: .utf8) ?? "")
    }
}

struct TestStruct: Codable, Equatable {
    
    var int: Int
    var string: String
    var decimal: Decimal
    var date: Date
    var optionalInt: Int?
    var url: URL?
    var bool: Bool?
    var keyWithCustomEncoding: String
    var embedded: EmbeddedStruct?
    var optionalArray: [Int]?
}

struct EmbeddedStruct: Codable, Equatable {
    
    var int: Int
    var string: String
    var decimal: Decimal
    var date: Date
    var optionalInt: Int?
    var url: URL?
    var bool: Bool?
    var keyWithCustomEncoding: String
}
