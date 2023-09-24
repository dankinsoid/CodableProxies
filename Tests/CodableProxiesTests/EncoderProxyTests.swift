import XCTest
@testable import CodableProxies

final class EncoderProxyTests: XCTestCase {
    
    func testEncoderProxy() throws {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let encoder = EncoderProxy(
            jsonEncoder,
            strategy: [.Decimal.string, .Numeric.string, .Bool.string, .Date.timestamp]
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
            )
        )
        let encoded = try encoder.encode(testStruct)
        print(String(data: encoded, encoding: .utf8) ?? "")
    }
}

struct TestStruct: Encodable {
    
    var int: Int
    var string: String
    var decimal: Decimal
    var date: Date
    var optionalInt: Int?
    var url: URL?
    var bool: Bool?
    var keyWithCustomEncoding: String
    var embedded: EmbeddedStruct?
}

struct EmbeddedStruct: Encodable {
    
    var int: Int
    var string: String
    var decimal: Decimal
    var date: Date
    var optionalInt: Int?
    var url: URL?
    var bool: Bool?
    var keyWithCustomEncoding: String
}
