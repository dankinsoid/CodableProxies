# CodableProxies

`CodableProxies` provides powerful encoding and decoding strategies for Swift's `Codable` types. By wrapping your encoders and decoders in `DecoderProxy` and `EncoderProxy`, you can easily apply these strategies for a more flexible and versatile encoding/decoding experience.

## Features

- 🚀 Flexible Encoding/Decoding strategies.
- 🔄 Symmetric Encoding and Decoding support through union types.
- 🐍 Convert from/to SnakeCase, CamelCase keys.
- 🔢 Custom strategies for numbers, dates, URLs, etc.
- 📦 Easily extensible.

## Usage

### Initialization

Wrap your encoders and decoders:

```swift
let encoder = EncoderProxy(JSONEncoder(), strategy: [.Bool.string, .Date.iso8601])
let decoder = DecoderProxy(JSONDecoder(), strategy: [.Bool.tryDecodeFromString, .Date.iso8601])
```

### Encoding Strategies

- **Bool**
  - `.Bool.string`: Encode booleans as "true"/"false".
  - `.Bool.string(true: String, false: String)`: Provide custom representations for booleans.

- **Data**
  - `.Data.base64(options: Data.Base64EncodingOptions)`: Encode data as Base64.

- **Date**
  - `.Date.date`: Default representation.
  - `.Date.iso8601(_ option: ISO8601DateFormatter.Options)`: ISO8601 formatted dates.
  - `.Date.formatted(_ formatter: DateFormatter)`: Custom date formats.
  - `.Date.timestamp`: Unix timestamps.
  
- **Data**
  - `.Data.base64`
  - `.Data.base64(options: Data.Base64EncodingOptions)`
  
- **Decimal** 
  - `.Decimal.string`
  - `.Decimal.number`
  
- **Key**
  - `.Key.useDefaultKeys`
  - `.Key.toSnakeCase`
  - `.Key.toSnakeCase(separator: String)`
  - `.Key.toCamelCase`
  - `.Key.toCamelCase(separator: String)`
    
- **Numbers**
  - `.Numeric.string`
    
- **Optional**
  - `.Optional.null`

- **URL**
  - `.URL.uri`

### Decoding Strategies

- **Bool**
  - `.Bool.tryDecodeFromString`: Attempt to decode booleans from a string representation.
  - `.Bool.tryDecodeFromString(_ condition: (String) -> Bool)`: Attempt to decode booleans from a string representation.
    
- **Data**  
  - `.Data.base64`
  - `.Data.base64(options: Foundation.Data.Base64DecodingOptions)`
    
- **Date** 
  - `.Date.date`
  - `.Date.iso8601`
  - `.Date.iso8601(_ options: ISO8601DateFormatter.Options)`
  - `.Date.iso8601(formats options: [ISO8601DateFormatter.Options])`
  - `.Date.formatted(_ formatter: DateFormatter)`
  - `.Date.formatted(_ format: String, locale: Locale, timeZone: TimeZone)`
  - `.Date.formatted(formats: Set<String>, locale: Locale, timeZone: TimeZone)`
  - `.Date.timestamp`
    
- **Decimal** 
  - `.Decimal.tryDecodeFromString`
  - `.Decimal.number`
    
- **Keys**
  - `.Key.fromSnakeCase`
  - `.Key.fromSnakeCase(separator: String)`
  - `.Key.fromCamelCase`
  - `.Key.fromCamelCase(separator: String)`
    
- **Numbers**
  - `.Numeric.tryDecodeFromString`
    
- **URL**
  - `.URL.uri`

### Union Types

The library offers `CodingProxy` and `CodingStrategy` that bring together both encoding and decoding for symmetrical operations.

## ⚠️ Important Note on Custom Type Encoding/Decoding

When utilizing `CodableProxies`, it's crucial to understand that the library will **override and ignore** any custom encoding and decoding strategies set on the original encoders/decoders. This behavior particularly impacts the following types when used with `JSONEncoder`, `JSONDecoder`, `PropertyListEncoder`, and `PropertyListDecoder`:
- `Decimal`
- `URL`
- `Data`
- `Date`

To maintain consistency and avoid unexpected outcomes, always include strategies for these types in your proxy encoder/decoder. Conveniently, all these strategies are bundled within `EncoderStrategy.default` and `DecoderStrategy.default`.

### Example

```swift
struct User: Codable {
    let isActive: Bool
    let birthDate: Date
    ...
}

let userJSON = """
{
    "isActive": "yes",
    "birthDate": "1990-01-01T00:00:00Z",
    ...
}
"""

let decoder = DecoderProxy(decoder: JSONDecoder(), strategy: [.default, .Bool.tryDecodeFromString, .Date.iso8601])
let user = try decoder.decode(User.self, from: userJSON.data(using: .utf8)!)
```

## Installation

1. [Swift Package Manager](https://github.com/apple/swift-package-manager)

Create a `Package.swift` file.
```swift
// swift-tools-version:5.7
import PackageDescription

let package = Package(
  name: "SomeProject",
  dependencies: [
    .package(url: "https://github.com/dankinsoid/CodableProxies.git", from: "1.0.0")
  ],
  targets: [
    .target(name: "SomeProject", dependencies: ["CodableProxies"])
  ]
)
```
```ruby
$ swift build
```

## Author

dankinsoid, voidilov@gmail.com

## License

CodableProxies is available under the MIT license. See the LICENSE file for more info.

## Contribution

Contributions are always welcome! Please refer to our contribution guidelines.
