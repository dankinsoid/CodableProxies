import XCTest
@testable import CodableProxies

final class DecoderProxyTests: XCTestCase {
    
    func test_DecoderProxy() throws {
        let jsonDecoder = JSONDecoder()
        let decoder = DecoderProxy(
            jsonDecoder,
            strategy: [
                .default,
                .Decimal.tryDecodeFromString,
                .Numeric.tryDecodeFromString,
                .Bool.tryDecodeFromString,
                .Key.fromSnakeCase,
                DecodingStrategy(ifNil: EmbeddedStruct.self) { decoder in
                    EmbeddedStruct(int: 0, string: "", decimal: 1, date: Date(), keyWithCustomEncoding: "")
                },
                DecodingStrategy(decodeIfNil: { type, decoder -> Decodable? in
                    guard let type = type as? any (RangeReplaceableCollection & Decodable).Type else {
                        return nil
                    }
                    return type.init()
                })
            ]
        )
        let string = """
        {
          "bool" : "true",
          "date" : "2023-09-24T19:01:32.525Z",
          "decimal" : "3.0",
          "embedded" : {
            "bool" : "true",
            "date" : "2023-09-24T19:01:32.525Z",
            "decimal" : "3.0",
            "int" : "1",
            "key_with_custom_encoding" : "keyWithCustomEncoding",
            "optional_int" : null,
            "string" : "2",
            "url" : "https:\\/\\/www.google.com"
          },
          "int" : "1",
          "key_with_custom_encoding" : "keyWithCustomEncoding",
          "optional_int" : null,
          "string" : "2",
          "url" : "https:\\/\\/www.google.com"
        }
        """
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
        let decoded: TestStruct = try decoder.decode(from: Data(string.utf8))
        print(decoded)
//        XCTAssertEqual(testStruct, decoded)
    }
}

struct Hm: Decodable {
    
    var int: Int
    var string: String
    var decimal: Decimal
    var date: Date
    var optionalInt: Int?
    var url: URL?
    var bool: Bool?
    var keyWithCustomEncoding: String
    var embedded: EmbeddedStruct?
    
    enum CodingKeys: CodingKey {
        case int
        case string
        case decimal
        case date
        case optionalInt
        case url
        case bool
        case keyWithCustomEncoding
        case embedded
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.int = try container.decode(Int.self, forKey: .int)
        self.string = try container.decode(String.self, forKey: .string)
        self.decimal = try container.decode(Decimal.self, forKey: .decimal)
        self.date = try container.decode(Date.self, forKey: .date)
        self.optionalInt = try container.decodeIfPresent(Int.self, forKey: .optionalInt)
        self.url = try container.decodeIfPresent(URL.self, forKey: .url)
        self.bool = try container.decodeIfPresent(Bool.self, forKey: .bool)
        self.keyWithCustomEncoding = try container.decode(String.self, forKey: .keyWithCustomEncoding)
//        self.embedded = try container.decodeIfPresent(EmbeddedStruct.self, forKey: .embedded)
    }
}

func decode(decoder: DecoderWrapper) throws {
}
