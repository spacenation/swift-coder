import XCTest
@testable import BinaryDecoder

final class DecoderTests: XCTestCase {
    func testDecoderTypeCharacter() {
        switch match(false).decode([false]) {
        case .success((let element, let state)):
            XCTAssertEqual(element, false)
            XCTAssertEqual(state, BinaryDecoderState(list: [false], offset: 1))
        case .failure(_):
            XCTFail()
        }
    }
    
    func testManyCombinator() {
        let zero: BinaryDecoder<Bool> = satisfy({ $0 == false })
        let bits: BinaryDecoder<Array<Bool>> = zero.many
        
        switch bits.decode(BinaryDecoderState(list: [false, false, true], offset: 0)) {
        case .success((let element, let state)):
            XCTAssertEqual(element, [false, false])
            XCTAssertEqual(state, BinaryDecoderState(list: [false, false, true], offset: 2))
        case .failure(_):
            XCTFail()
        }
        
        switch satisfy({ $0 == false }).many.decode(BinaryDecoderState(list: [false, false, false, true], offset: 0)) {
        case .success((let element, let state)):
            XCTAssertEqual(element, [false, false, false])
            XCTAssertEqual(state, BinaryDecoderState(list: [false, false, false, true], offset: 3))
        case .failure(_):
            XCTFail()
        }
    }
    
    
    func testSequenceA() {
        let listOfDecoders: Array<BinaryDecoder<Bool>> = [match(false), primitive(), match(true)]
        let sequenceAResult: BinaryDecoder<Array<Bool>> = listOfDecoders.sequenceA()
        
        switch sequenceAResult([false, true, true]) {
        case .success((let element, _)):
            XCTAssertEqual(element, [false, true, true])
        case .failure(_):
            XCTFail()
        }
    }
    
    func testApplyCombinator() {
        struct Options: Equatable {
            let this: Bool
            let that: Bool
            let other: Bool
        }
    
        let coder: BinaryDecoder<Options> =
            pure(curry(Options.init))
                .apply(match(false))
                .apply(match(true))
                .apply(match(false).discardThen(primitive()))
        
        switch coder([false, true, false, true]) {
        case .success((let options, _)):
            XCTAssertEqual(options, Options(this: false, that: true, other: true))
        case .failure(_):
            XCTFail()
        }
        
    }
    
    func testBuilder() {
        struct Options: Equatable {
            let this: Array<Bool>
            let that: Bool
            let other: Bool
        }
    
        let coder =
            BinaryDecoder(Options.init) {
                match(true).many
                match(false)
                match(false)
            }
        
        switch coder([true, true, false, false]) {
        case .success((let options, _)):
            XCTAssertEqual(options, Options(this: [true, true], that: false, other: false))
        case .failure(_):
            XCTFail()
        }
        
    }
}
