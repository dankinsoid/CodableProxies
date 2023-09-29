# Encoding Strategies

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
  - `.Data.base64`: Encode data as Base64.
  - `.Data.base64(options: Data.Base64EncodingOptions)`: Encode data as Base64 with custom options.
  
- **Decimal** 
  - `.Decimal.string`: Encode decimal as a quoted string.
  - `.Decimal.number`: Encode decimal as a number.
  
- **Key**
  - `.Key.useDefaultKeys`: Doesn't change the keys.
  - `.Key.toSnakeCase`: Convert keys to snake_case.
  - `.Key.toSnakeCase(separator: String)`: Convert keys to snake_case with a custom separator.
  - `.Key.toCamelCase`: Convert keys to camelCase.
  - `.Key.toCamelCase(separator: String)`: Convert keys to camelCase with a custom separator.
    
- **Numbers**
  - `.Numeric.string`: Encode numbers as quoted strings.
    
- **Optional**
  - `.Optional.null`: Encode null for nil values.

- **URL**
  - `.URL.uri`: Encode URL as a string representation.

# Decoding Strategies

- **Bool**
  - `.Bool.string`: Attempt to decode booleans from a string representation.
  - `.Bool.string(_ condition: (String) -> Bool)`: Attempt to decode booleans from a string representation.

- **Data**  
  - `.Data.base64`: Attempt to decode Base64 data.
  - `.Data.base64(options: Foundation.Data.Base64DecodingOptions)`: Attempt to decode Base64 data with custom options.

- **Date** 
  - `.Date.date`: Attempt to decode a full-date notation as defined by RFC 3339, section 5.6, for example, 2017-07-21.
  - `.Date.iso8601`: Attempt to decode ISO8601 formatted dates.
  - `.Date.iso8601(_ options: ISO8601DateFormatter.Options)`: Attempt to decode ISO8601 formatted dates with custom options.
  - `.Date.iso8601(formats options: [ISO8601DateFormatter.Options])`: Attempt to decode ISO8601 formatted dates with custom options, tries several formats.
  - `.Date.formatted(_ formatter: DateFormatter)`: Attempt to decode formatted dates with a custom formatter.
  - `.Date.formatted(_ format: String, locale: Locale, timeZone: TimeZone)`: Attempt to decode formatted dates with a custom format, locale and timezone.
  - `.Date.formatted(formats: Set<String>, locale: Locale, timeZone: TimeZone)`: Attempt to decode formatted dates with a custom format, locale and timezone, tries several formats.
  - `.Date.timestamp`: Attempt to decode Unix timestamps.

- **Decimal** 
  - `.Decimal.string`: Attempt to decode decimals from a string representation if value is quoted.
  - `.Decimal.number`: Attempt to decode decimals from a number representation.

- **Keys**
  - `.Key.fromSnakeCase`: Convert snake_case keys to camelCase.
  - `.Key.fromSnakeCase(separator: String)`: Convert snake_case keys to camelCase with a custom separator.
  - `.Key.fromCamelCase`: Convert camelCase keys to snake_case.
  - `.Key.fromCamelCase(separator: String)`: Convert snake_case keys to camelCase with a custom separator.

- **Numbers**
  - `.Numeric.string`: Attempt to decode numbers from a string representation if value is quoted.

- **URL**
  - `.URL.uri`: Attempt to decode URLs from a string representation.

# Coding Strategies

- **Bool**
  - `.Bool.decodeFromString`: Decodes booleans from strings if the value is quoted.from a string representation.
  - `.Bool.string`: Encodes booleans as strings and decodes booleans from strings if the value is quoted.

- **Data**  
  - `.Data.base64`: Encodes data as Base64 and decodes Base64 data.
  - `.Data.base64(options: Foundation.Data.Base64DecodingOptions)`: Encodes data as Base64 and decodes Base64 data with custom options.

- **Date** 
  - `.Date.date`: ISO 8601 full-date notation as defined by RFC 3339, section 5.6, for example, 2017-07-21.
  - `.Date.iso8601`: ISO 8601 date-time notation as defined by RFC 3339, for example, 2016-06-13T16:00:00+00:00.
  - `.Date.iso8601(encodeTo format: ISO8601DateFormatter.Options, decodeFrom formats: [ISO8601DateFormatter.Options])`: ISO 8601 date-time notation with custom format options for encoding and several format options for decoding.
  - `.Date.formatted(_ formatter: DateFormatter)`: Decodes/encodes dates with custom DateFormatter.
  - `.Date.formatted(encodeTo format: String, decodeFrom formats: Set<String>, locale: Locale, timeZone: TimeZone)`: Decodes/encodes dates with custom format for encoding and a set of formats for decoding.
  - `.Date.timestamp`: Decodes/encodes Unix timestamps.

- **Decimal** 
  - `.Decimal.string`: Decodes/encodes decimal as a quoted value.
  - `.Decimal.number`: Decodes/encodes decimal as a number.
  - `.Decimal.decodeFromString`: Encode decimal as a number, decodes from a number or string if necessary.

- **Keys**
  - `.Key.useDefaultKeys`: Whether to use default keys.
  - `.Key.encodeToSnakeCaseDecodeFromCamelCase`: Whether to encode to snake_case and decode from camelCase.
  - `.Key.encodeToSnakeCaseDecodeFromCamelCase(separator: String)`: Encode to snake_case and decode from camelCase with a custom separator.
  - `.Key.encodeToCamelCaseDecodeFromSnakeCase`: Whether to encode to camelCase and decode from snake_case.
  - `.Key.encodeToCamelCaseDecodeFromSnakeCase(separator: String)`: Encode to snake_case and decode from camelCase with a custom separator.
  - `.Key.custom(...)`: Custom key encoding/decoding strategy.

- **Numbers**
  - `.Numeric.string`: Decodes/encodes numbers as quoted values.
  - `.Numeric.decodeFromString`: Encodes numbers as quoted values, decodes from a number or string if necessary.

- **Optional**
  - `.Optional.encodeNull`: Encodes null for nil values.

- **URL**
  - `.URL.uri`: Decodes/encodes URLs as string representations.