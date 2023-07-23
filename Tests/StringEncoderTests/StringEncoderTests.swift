import XCTest
@testable import StringEncoder

final class StringEncoderTests: XCTestCase {
    func testStringEncodable2() {
        struct Some {
            let this: UInt8
            let that: UInt8
        }
        
        let encoder = StringEncoder<Some> { input in
            uInt8(input.this) + string(" ") + uInt8(input.that)
        }
        
        let result = encoder(Some(this: 8, that: 9))
        
        XCTAssertEqual(try? result.string(), "8 9")
    }

    func testStringEncodable() {
        struct Some: StringEncodable {
            let this: UInt8
            let that: UInt8

            static var stringEncoder: StringEncoder<Some> {
                StringEncoder { input in
                    uInt8(input.this)
                    string.count(2)(" ")
                    uInt8(input.that)
                    " :end"
                }
            }
        }
        
        XCTAssertEqual(try? Some(this: 8, that: 9).stringEncoded.string(), "8  9 :end")
    }
    
    func testStringEncoderBuilder() {
        struct Some: StringEncodable {
            let this: UInt8
            let that: UInt8

            static var stringEncoder: StringEncoder<Some> {
                StringEncoder { input in
                    uInt8(input.this)
                    "-"
                    uInt8(input.that)
                }
            }
        }
        
        XCTAssertEqual(try? Some(this: 8, that: 9).stringEncoded.string(), "8-9")
    }
}
