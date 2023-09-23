import XCTest
@testable import CodableProxies

final class EncoderProxyTests: XCTestCase {
    
    func testEncoderProxy() throws {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let encoder = EncoderProxy(
            jsonEncoder,
            strategy: [.Decimal.string, .Key.convertToSnakeCase(separator: "-")]
        )
        let testStruct = TestStruct(
            int: 1,
            string: "2",
            decimal: 3.0,
            date: Date(),
            optionalInt: nil,
            url: URL(string: "https://www.google.com"),
            keyWithCustomEncoding: "keyWithCustomEncoding"
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
    var keyWithCustomEncoding: String
}

