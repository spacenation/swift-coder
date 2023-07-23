import XCTest
import BinaryDecoder

final class BinaryDecoderTests: XCTestCase {
    
    func testSequenceA() {
        let byte: BinaryDecoder<Array<Bool>> = bit.count(1).discardThen(bit.count(8)).discard(bit.count(7))
        
        switch byte([0b0000_1111, 0b0000_0000]) {
        case .success((let element, _)):
            XCTAssertEqual(element, [false, false, false, true, true, true, true, false])
        case .failure(_):
            XCTFail()
        }
    }
    
    func testTypeDecoding() {
        struct Options: Equatable {
            let this: UInt8
            let that: UInt8
        }
        
        let coder = type(Options.self)
        
        switch coder([0b0000_0001, 0b0000_0010]) {
        case .success((let options, _)):
            XCTAssertEqual(options, Options(this: 1, that: 2))
        case .failure(_):
            XCTFail()
        }
        
    }
    
    func testTypeBuilding() {
        struct Options: Equatable {
            let this: UInt8
            let that: UInt8
            let other: UInt16
        }
        
        let coder = BinaryDecoder(Options.init) {
            /// Comment
            uInt8
            /// Another Comment
            bit.count(8).discardThen(uInt8)
            uInt16
        }
//            pure(Options.init >>> curry)
//                .apply(uInt8)
//                .apply(bit.count(8).discardThen(uInt8))
//                .apply(uInt16)
        
        switch coder([0b0000_0001, 0b0000_0000, 0b0000_0010, 0b0000_0011, 0b0000_0000]) {
        case .success((let options, _)):
            XCTAssertEqual(options, Options(this: 1, that: 2, other: 3))
        case .failure(_):
            XCTFail()
        }
        
    }
    
    func testBitDecoder() {
        let coder = zero.or(one).discardThen(bit)
        
        switch coder([0b0101_0000]) {
        case .success(_):
            print("OK")
        case .failure(_):
            XCTFail()
        }
    }

    static var allTests = [
        ("testBitDecoder", testBitDecoder),
    ]
}
