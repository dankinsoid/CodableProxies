import XCTest
@testable import CodableProxies

final class DecoderProxyTests: XCTestCase {
    
    private let decoder = JSONDecoder()
    
    // MARK: - Bool
    
    func testDecodingBoolAsStringTrueFalseDefault() throws {
        let proxyDecoder = DecoderProxy(decoder, strategy: .Bool.tryDecodeFromString)
        
        let testValue = "\"true\""
        let decodedBool = try proxyDecoder.decode(Bool.self, from: testValue.data(using: .utf8)!)
        
        XCTAssertTrue(decodedBool)
        
        let testValueFalse = "\"false\""
        let decodedBoolFalse = try proxyDecoder.decode(Bool.self, from: testValueFalse.data(using: .utf8)!)
        
        XCTAssertFalse(decodedBoolFalse)
    }
    
    func testDecodingBoolAsStringCustom() throws {
        let proxyDecoder = DecoderProxy(decoder, strategy: .Bool.tryDecodeFromString)
        
        let testValue = "\"YES\""
        let decodedBool = try proxyDecoder.decode(Bool.self, from: testValue.data(using: .utf8)!)
        
        XCTAssertTrue(decodedBool)
        
        let testValueFalse = "\"NO\""
        let decodedBoolFalse = try proxyDecoder.decode(Bool.self, from: testValueFalse.data(using: .utf8)!)
        
        XCTAssertFalse(decodedBoolFalse)
    }
    
    // MARK: - Data
    
    func testDecodingDataBase64() throws {
        let proxyDecoder = DecoderProxy(decoder, strategy: .Data.base64)
        
        let testString = "Hello, CodableProxies!"
        let base64String = testString.data(using: .utf8)!.base64EncodedString()
        let decodedData = try proxyDecoder.decode(Data.self, from: "\"\(base64String)\"".data(using: .utf8)!)
        
        XCTAssertEqual(decodedData, testString.data(using: .utf8)!)
    }
    
    // MARK: - Date
    
    // Testing decoding a date as a default Date type
    func testDecodingDateAsDate() throws {
        let proxyDecoder = DecoderProxy(decoder, strategy: .Date.date)
        
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withFullDate, .withDashSeparatorInDate]
        let testDate = Date(timeIntervalSince1970: 1695772800)
        let encodedString = isoFormatter.string(from: testDate)
        let decodedDate = try proxyDecoder.decode(Date.self, from: "\"\(encodedString)\"".data(using: .utf8)!)
        
        XCTAssertEqual(decodedDate, testDate)
    }
    
    // Testing decoding date using default ISO8601 format
    func testDecodingDateAsISO8601WithDefaultOptions() throws {
        let proxyDecoder = DecoderProxy(decoder, strategy: .Date.iso8601)
        
        let isoFormatter = ISO8601DateFormatter()
        let testDate = Date(timeIntervalSince1970: 1695772800)
        let encodedString = isoFormatter.string(from: testDate)
        let decodedDate = try proxyDecoder.decode(Date.self, from: "\"\(encodedString)\"".data(using: .utf8)!)
        
        XCTAssertEqual(decodedDate, testDate)
    }
    
    // Testing decoding date using custom ISO8601 options
    func testDecodingDateAsISO8601WithCustomOptions() throws {
        let customOptions: ISO8601DateFormatter.Options = [.withInternetDateTime, .withDashSeparatorInDate]
        let proxyDecoder = DecoderProxy(decoder, strategy: .Date.iso8601(customOptions))
        
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = customOptions
        let testDate = Date(timeIntervalSince1970: 1695772800)
        let encodedString = isoFormatter.string(from: testDate)
        let decodedDate = try proxyDecoder.decode(Date.self, from: "\"\(encodedString)\"".data(using: .utf8)!)
        
        XCTAssertEqual(decodedDate, testDate)
    }
    
    // Testing decoding date using a custom formatter
    func testDecodingDateWithCustomFormatter() throws {
        let customFormatter = DateFormatter()
        customFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let proxyDecoder = DecoderProxy(decoder, strategy: .Date.formatted(customFormatter))
        
        let testDate = Date(timeIntervalSince1970: 1695772800)
        let encodedString = customFormatter.string(from: testDate)
        let decodedDate = try proxyDecoder.decode(Date.self, from: "\"\(encodedString)\"".data(using: .utf8)!)
        
        XCTAssertEqual(decodedDate, testDate)
    }
    
    // Testing decoding date using a custom string format
    func testDecodingDateWithCustomStringFormat() throws {
        let customFormat = "yyyy-MM-dd"
        let customFormatter = DateFormatter()
        customFormatter.dateFormat = customFormat
        let proxyDecoder = DecoderProxy(decoder, strategy: .Date.formatted(customFormat))
        
        let testDate = Date(timeIntervalSince1970: 1695772800)
        let encodedString = customFormatter.string(from: testDate)
        let decodedDate = try proxyDecoder.decode(Date.self, from: "\"\(encodedString)\"".data(using: .utf8)!)
        
        XCTAssertEqual(decodedDate, testDate)
    }
    
    // Testing decoding date as a timestamp (assuming Unix timestamp)
    func testDecodingDateAsTimestamp() throws {
        let proxyDecoder = DecoderProxy(decoder, strategy: .Date.timestamp)
        
        let testDate = Date(timeIntervalSince1970: 1695772800)
        let timestamp = testDate.timeIntervalSince1970
        let decodedDate = try proxyDecoder.decode(Date.self, from: "\(timestamp)".data(using: .utf8)!)
        
        XCTAssertEqual(decodedDate, testDate)
    }
    
    // MARK: - Decimal
    
    // Testing decoding a Decimal from a String
    func testDecodingDecimalFromString() throws {
        let proxyDecoder = DecoderProxy(decoder, strategy: .Decimal.tryDecodeFromString)
        
        let originalDecimalString = "\"123.456\""  // The Decimal represented as a quoted string in JSON.
        let decodedDecimal = try proxyDecoder.decode(Decimal.self, from: originalDecimalString.data(using: .utf8)!)
        
        XCTAssertEqual(decodedDecimal, Decimal(string: "123.456")!)
    }
    
    // Testing decoding a Decimal from a Number
    func testDecodingDecimalFromNumber() throws {
        let proxyDecoder = DecoderProxy(decoder, strategy: .Decimal.number)
        
        let originalDecimalValue = (Decimal(string: "123.456")! as NSDecimalNumber).doubleValue
        let decodedDecimal = try proxyDecoder.decode(Decimal.self, from: "\(originalDecimalValue)".data(using: .utf8)!)
        
        XCTAssertEqual(decodedDecimal, Decimal(string: "123.456")!, accuracy: Decimal(string: "0.001")!)
    }
    
    // MARK: - Key
    
    // Testing decoding keys using default keys
    func testDecodingKeyUseDefaultKeys() throws {
        let proxyDecoder = DecoderProxy(decoder, strategy: .Key.useDefaultKeys)
        
        let jsonString = "{\"firstName\":\"John\",\"lastName\":\"Doe\"}"
        let decodedModel = try proxyDecoder.decode(TestKeysModel.self, from: jsonString.data(using: .utf8)!)
        
        XCTAssertEqual(decodedModel.firstName, "John")
        XCTAssertEqual(decodedModel.lastName, "Doe")
    }
    
    // Testing decoding keys from snake case using default separator
    func testDecodingKeyFromSnakeCaseWithDefaultSeparator() throws {
        let proxyDecoder = DecoderProxy(decoder, strategy: .Key.fromSnakeCase(separator: "_"))
        
        let jsonString = "{\"first_name\":\"John\",\"last_name\":\"Doe\"}"
        let decodedModel = try proxyDecoder.decode(TestKeysModel.self, from: jsonString.data(using: .utf8)!)
        
        XCTAssertEqual(decodedModel.firstName, "John")
        XCTAssertEqual(decodedModel.lastName, "Doe")
    }
    
    // Testing decoding keys from snake case using a custom separator
    func testDecodingKeyFromSnakeCaseWithCustomSeparator() throws {
        let proxyDecoder = DecoderProxy(decoder, strategy: .Key.fromSnakeCase(separator: "-"))
        
        let jsonString = "{\"first-name\":\"John\",\"last-name\":\"Doe\"}"
        let decodedModel = try proxyDecoder.decode(TestKeysModel.self, from: jsonString.data(using: .utf8)!)
        
        XCTAssertEqual(decodedModel.firstName, "John")
        XCTAssertEqual(decodedModel.lastName, "Doe")
    }
    
    // Testing decoding keys from camel case using default separator (assuming default separator is "_")
    func testDecodingKeyFromCamelCaseWithDefaultSeparator() throws {
        let proxyDecoder = DecoderProxy(decoder, strategy: .Key.fromCamelCase)
        
        let jsonString = "{\"firstName\":\"John\",\"lastName\":\"Doe\"}"
        let decodedModel = try proxyDecoder.decode(TestKeysModel1.self, from: jsonString.data(using: .utf8)!)
        
        XCTAssertEqual(decodedModel.first_name, "John")
        XCTAssertEqual(decodedModel.last_name, "Doe")
    }
    
    // MARK: - Numeric
    
    // Testing decoding numeric values from a String
    func testDecodingNumericFromString() throws {
        let proxyDecoder = DecoderProxy(decoder, strategy: .Numeric.tryDecodeFromString)
        
        let jsonString1 = "{\"number\":\"123\"}"
        let decodedModel1 = try proxyDecoder.decode(TestModel1.self, from: jsonString1.data(using: .utf8)!)
        
        XCTAssertEqual(decodedModel1.number, 123)
//
//        let jsonString2 = "{\"number\":123}"
//        let decodedModel2 = try proxyDecoder.decode(TestModel1.self, from: jsonString2.data(using: .utf8)!)
//
//        XCTAssertEqual(decodedModel2.number, 123)
    }
    
    // MARK: - URL
    
    // Testing decoding URL values from a URI
    func testDecodingURLFromUri() throws {
        let proxyDecoder = DecoderProxy(decoder, strategy: .URL.uri)
        
        let jsonString = "\"https:\\/\\/example.com\""
        let decodedModel = try proxyDecoder.decode(URL.self, from: jsonString.data(using: .utf8)!)
        
        XCTAssertEqual(decodedModel, URL(string: "https://example.com"))
    }
    
    // Testing decoding URL values from a URI without escaped slashes
    func testDecodingURLFromUriWithoutEscapingSlashes() throws {
        let jsonString = "\"https://example.com\""
        let decodedModel = try decoder.decode(URL.self, from: jsonString.data(using: .utf8)!)
        
        XCTAssertEqual(decodedModel, URL(string: "https://example.com"))
    }

    // MARK: - common tests
    
    // Testing decoding of a single value
    func testDecodingSingleValue() throws {
        let jsonString = "\"42\""
        let proxyDecoder = DecoderProxy(decoder, strategy: .Numeric.tryDecodeFromString)
        let decodedValue = try proxyDecoder.decode(Int.self, from: jsonString.data(using: .utf8)!)
        
        XCTAssertEqual(decodedValue, 42)
    }
    
    // Testing decoding of a single object
    func testDecodingObject() throws {
        let jsonString = "{\"name\":\"John\",\"age\":\"30\"}"
        let proxyDecoder = DecoderProxy(decoder, strategy: .Numeric.tryDecodeFromString)
        let decodedPerson = try proxyDecoder.decode(Person.self, from: jsonString.data(using: .utf8)!)
        
        XCTAssertEqual(decodedPerson.name, "John")
        XCTAssertEqual(decodedPerson.age, 30)
    }
    
    // Testing decoding of an array of objects
    func testDecodingArray() throws {
        let jsonString = "[{\"name\":\"John\",\"age\":\"30\"},{\"name\":\"Doe\",\"age\":\"25\"}]"
        let proxyDecoder = DecoderProxy(decoder, strategy: .Numeric.tryDecodeFromString)
        let decodedGroup = try proxyDecoder.decode([Person].self, from: jsonString.data(using: .utf8)!)
        
        XCTAssertEqual(decodedGroup[0].name, "John")
        XCTAssertEqual(decodedGroup[0].age, 30)
        XCTAssertEqual(decodedGroup[1].name, "Doe")
        XCTAssertEqual(decodedGroup[1].age, 25)
    }
    
    // Testing decoding of nested data structures
    func testDecodingNestedDataStructures() throws {
        let jsonString = "{\"groupName\":\"Test Group\",\"members\":[{\"name\":\"John\",\"age\":\"30\"},{\"name\":\"Doe\",\"age\":\"25\"}]}"
        let proxyDecoder = DecoderProxy(decoder, strategy: .Numeric.tryDecodeFromString)
        let decodedGroup = try proxyDecoder.decode(Group.self, from: jsonString.data(using: .utf8)!)
        
        XCTAssertEqual(decodedGroup.groupName, "Test Group")
        XCTAssertEqual(decodedGroup.members[0].name, "John")
        XCTAssertEqual(decodedGroup.members[0].age, 30)
        XCTAssertEqual(decodedGroup.members[1].name, "Doe")
        XCTAssertEqual(decodedGroup.members[1].age, 25)
    }
}
