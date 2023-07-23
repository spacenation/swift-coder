import XCTest
import StringDecoder

final class StringDecoderTests: XCTestCase {
    func testCharacterParser() {
        let coder: StringDecoder<Character, StringDecoderFailure> = match("1")
        
        switch coder.map({ Int(String($0))! })("1ice") {
        case .success(let (element, next)):
            XCTAssertTrue(element == 1)
            XCTAssertTrue(next.string == "1ice")
        case .failure(_):
            XCTFail()
        }
    }
    
    func testCharacterParserFail() {
        let coder: StringDecoder<Character, StringDecoderFailure> = match("C")
        
        switch coder("c") {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssertTrue(error == .mismatchedPrimitive(0))
        }
    }
    
    func testStringMatchDecoder() {
        let coder: StringDecoder<String, StringDecoderFailure> = match("this")
        switch coder("this1") {
        case .success(let (element, next)):
            XCTAssertTrue(element == "this")
            XCTAssertTrue(next.string == "this1")
        case .failure(_):
            XCTFail()
        }
    }
    
    func testAlphanumericDecoder() {
        switch string(isAlphanumeric)("this!") {
        case .success(let (element, next)):
            XCTAssertTrue(element == "this")
            XCTAssertTrue(next.string == "this!")
        case .failure(_):
            XCTFail()
        }
    }
    
    func testStringDecoderFail() {
        let coder: StringDecoder<String, StringDecoderFailure> = match("this2")
        switch coder("this1") {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssertEqual(error, .mismatchedPrimitive(4))
        }
    }

    func testCombineParsers() {
        let coder: StringDecoder<String, StringDecoderFailure> = match("this")
        let spaceCoder: StringDecoder<String, StringDecoderFailure> = match(" ")
        switch coder.discard(spaceCoder)("this ") {
        case .success(let (element, next)):
            XCTAssertTrue(element == "this")
            XCTAssertTrue(next.string == "this ")
        case .failure(_):
            XCTFail()
        }
    }

    func testChoiceOperation() {
        let boolTrue: StringDecoder<Character, StringDecoderFailure> = match("t")
        let boolFalse: StringDecoder<Character, StringDecoderFailure> = match("f")
        
        switch boolTrue.or(boolFalse)("t") {
        case .success(let (element, next)):
            XCTAssertTrue(element == "t")
            XCTAssertTrue(next.string == "t")
        case .failure(_):
            XCTFail()
        }
    }

    func testTakeWhile() {
        let decoder: StringDecoder<String, StringDecoderFailure> = takeWhile(isDigit)

        switch decoder("1122one") {
        case .success(let (element, next)):
            XCTAssertTrue(element == "1122")
            XCTAssertTrue(next.string == "1122one")
            XCTAssertTrue(next.offset == 4)
        case .failure(_):
            XCTFail()
        }
    }
    
    func testStringDecoder() {
        let decoder: StringDecoder<String, StringDecoderFailure> = string("this")
        switch decoder("thisthat") {
        case .success(let (element, next)):
            XCTAssertTrue(element == "this")
            XCTAssertTrue(next.string == "thisthat")
        case .failure(_):
            XCTFail()
        }
    }
    
    func testLinesParser() {
        let fileString = "First line\nSecond line\n"
        
        switch lines()(fileString) {
        case .success(let (element, next)):
            print(element)
            XCTAssertEqual(element.count, 2)
            XCTAssertEqual(next.string, fileString)
        case .failure(_):
            XCTFail()
        }
    }

    func testDecodingManyChars() {
        let coder: StringDecoder<Character, StringDecoderFailure> = match("c")
        
        switch coder.many("ccc123") {
        case .success(let (element, next)):
            XCTAssertTrue(element == ["c", "c", "c"])
            XCTAssertTrue(next.string == "ccc123")
        case .failure(_):
            XCTFail()
        }
        
        switch coder.many("123") {
        case .success(let (element, next)):
            XCTAssertTrue(element == [])
            XCTAssertTrue(next.string == "123")
        case .failure(_):
            XCTFail()
        }
    }

    func testDecodingManyStrings() {
        let coder: StringDecoder<String, StringDecoderFailure> = match("c1")
        
        switch coder.many("c1c1c1123") {
        case .success(let (element, next)):
            XCTAssertTrue(element == ["c1", "c1", "c1"])
            XCTAssertTrue(next.string == "c1c1c1123")
        case .failure(_):
            XCTFail()
        }
        
        switch coder.many("123") {
        case .success(let (element, next)):
            XCTAssertTrue(element == [])
            XCTAssertTrue(next.string == "123")
        case .failure(_):
            XCTFail()
        }
    }

    func testDecodingSome() {
        let coder: StringDecoder<Character, StringDecoderFailure> = match("c")
        
        switch coder.some("ccc123") {
        case .success(let (element, next)):
            XCTAssertTrue(element == ["c", "c", "c"])
            XCTAssertTrue(next.string == "ccc123")
        case .failure(_):
            XCTFail()
        }
        
        switch coder.some("") {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssertTrue(error == .outOfBounds(0))
        }
    }
    
    func testCombinators() {
        struct SystemCall: Equatable {
            let name: String
            let argument: Array<String>
        }

        let systemCallDecoder = match("(")
            .discardThen(satisfy { $0.isNumber }.many.map { String($0) }.many(separatedBy: match(" ")))
            .discard(match(")"))
            .reverseApply(
                takeWhile({ $0 != "(" }).map { String($0) }
                    .map(curry(SystemCall.init))
            )

        let output = systemCallDecoder("call(12 132 1)")
        
        switch output {
        case .success(let (element, next)):
            XCTAssertTrue(element == SystemCall(name: "call", argument: ["12", "132", "1"]))
            XCTAssertTrue(next.string == "call(12 132 1)")
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }
    
//    func testPerformance() {
//        let decoder = satisfy { $0.isNumber }.count(5000)
//        var input = String(Array(repeating: Character("1"), count: 100000))
//        
//        measure {
//            switch decoder(input) {
//            case .success(let output):
//                print(output)
//            case .failure:
//                XCTFail()
//            }
//            
//        }
//    }

    static var allTests = [
        ("testCharacterParser", testCharacterParser),
    ]
}
