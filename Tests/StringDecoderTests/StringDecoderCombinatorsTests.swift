import XCTest
@testable import StringDecoder

final class StringDecoderCombinatorsTests: XCTestCase {

    
    func testDecoderTypeCharacter() {
        switch match(Character("c")).decode(["c"]) {
        case .success((let element, let state)):
            XCTAssertEqual(element, "c")
            XCTAssertEqual(state, State(string: "c", offset: 1, line: 1, column: 2))
        case .failure(_):
            XCTFail()
        }
    }
    
    func testManyCombinator() {
        let letter: StringDecoder<Character, StringDecoderFailure> = satisfy({ $0.isLetter })
        let number: StringDecoder<Character, StringDecoderFailure> = satisfy({ $0.isNumber })
        let alphanumeric: StringDecoder<String, StringDecoderFailure> = letter.or(number).many.map { String($0) }
        
        switch alphanumeric.decode(State(string: "ccc11!", offset: 0, line: 1, column: 2)) {
        case .success((let element, let state)):
            XCTAssertEqual(element, "ccc11")
            XCTAssertEqual(state, State(string: "ccc11!", offset: 5, line: 1, column: 7))
        case .failure(_):
            XCTFail()
        }
        
        switch satisfy({ $0.isLetter }).many.map({ String($0) }).decode(State(string: "ccc11", offset: 0, line: 1, column: 2)) {
        case .success((let element, let state)):
            XCTAssertEqual(element, "ccc")
            XCTAssertEqual(state, State(string: "ccc11", offset: 3, line: 1, column: 5))
        case .failure(_):
            XCTFail()
        }
        
        switch satisfy({ $0.isLetter }).many.map({ String($0) }).decode(State(string: "1", offset: 0, line: 1, column: 2)) {
        case .success((let element, let state)):
            XCTAssertEqual(element, "")
            XCTAssertEqual(state, State(string: "1", offset: 0, line: 1, column: 2))
        case .failure(_):
            XCTFail()
        }
        
        switch satisfy({ $0.isLetter }).many.map({ String($0) }).decode(State(string: "", offset: 0, line: 1, column: 2)) {
        case .success((let element, let state)):
            XCTAssertEqual(element, "")
            XCTAssertEqual(state, State(string: "", offset: 0, line: 1, column: 2))
        case .failure(_):
            XCTFail()
        }
    }
    
    func testSomeCombinator() {
        switch satisfy({ $0.isLetter }).some.decode(State(string: "ccc11", offset: 0, line: 1, column: 2)) {
        case .success((let element, let state)):
            XCTAssertEqual(element, ["c", "c", "c"])
            XCTAssertEqual(state, State(string: "ccc11", offset: 3, line: 1, column: 5))
        case .failure(_):
            XCTFail()
        }
        
        switch satisfy({ $0.isLetter }).some.decode(State(string: "1", offset: 0, line: 1, column: 2)) {
        case .success:
            XCTFail()
        case .failure(let failure):
            XCTAssertEqual(failure, .mismatchedPrimitive(0))
        }
        
        switch satisfy({ $0.isLetter }).some.decode(State(string: "", offset: 0, line: 1, column: 2)) {
        case .success:
            XCTFail()
        case .failure(let failure):
            XCTAssertEqual(failure, .outOfBounds(0))
        }
    }
    
    func testSomeSeparatedByCombinator() {
        let letter: StringDecoder<Character, StringDecoderFailure> = satisfy({ $0.isLetter })
        let number: StringDecoder<Character, StringDecoderFailure> = satisfy({ $0.isNumber })
        
        switch letter.some(separatedBy: number).decode(State(string: "a1b2c3!!", offset: 0, line: 1, column: 2)) {
        case .success((let element, let state)):
            XCTAssertEqual(element, ["a", "b", "c"])
            XCTAssertEqual(state, State(string: "a1b2c3!!", offset: 5, line: 1, column: 7))
        case .failure(_):
            XCTFail()
        }
        
        switch letter.some(separatedBy: number).decode(State(string: "1", offset: 0, line: 1, column: 2)) {
        case .success:
            XCTFail()
        case .failure(let failure):
            XCTAssertEqual(failure, .mismatchedPrimitive(0))
        }
    }
    
    func testManySeparatedByCombinator() {
        let letter: StringDecoder<Character, StringDecoderFailure> = satisfy({ $0.isLetter })
        let number: StringDecoder<Character, StringDecoderFailure> = satisfy({ $0.isNumber })
        let space: StringDecoder<Character, StringDecoderFailure> = match(" ")
        
        switch letter.many(separatedBy: number).decode(State(string: "a1b2c3!!", offset: 0, line: 1, column: 2)) {
        case .success((let element, let state)):
            XCTAssertEqual(element, ["a", "b", "c"])
            XCTAssertEqual(state, State(string: "a1b2c3!!", offset: 5, line: 1, column: 7))
        case .failure:
            XCTFail()
        }
        
        struct This: Equatable {
            let name: String
            let argumants: Array<String>
        }
        
        let thisDecoder:StringDecoder<This, StringDecoderFailure> = match("(")
            .discardThen(letter.many.map { String($0) }.many(separatedBy: space))
            .discard(match(")"))
            .reverseApply(
                takeWhile({ $0 != "(" }).map { String($0) }
                    .map(curry(This.init))
            )
        
        switch thisDecoder("call(AA BB CC)") {
        case .success((let element, let state)):
            XCTAssertEqual(element, This(name: "call", argumants: ["AA", "BB", "CC"]))
            XCTAssertEqual(state, State(string: "call(AA BB CC)", offset: 14, line: 1, column: 15))
        case .failure:
            XCTFail()
        }
        
        switch letter.many(separatedBy: number).decode(State(string: "1", offset: 0, line: 1, column: 2)) {
        case .success((let element, let state)):
            XCTAssertEqual(element, [])
            XCTAssertEqual(state, State(string: "1", offset: 0, line: 1, column: 2))
        case .failure:
            XCTFail()
        }
    }
    
    func testTryAheadCombinator() {
        switch satisfy({ $0.isLetter })
            .tryAhead(match("nn"))
            .many
            .decode(State(string: "cadnntest", offset: 0, line: 1, column: 2))
        {
        case .success((let element, let state)):
            XCTAssertEqual(element, ["c", "a", "d"])
            XCTAssertEqual(state, State(string: "cadnntest", offset: 3, line: 1, column: 5))
        case .failure(_):
            XCTFail()
        }
    }
    
    func testLookAheadCombinator() {
        switch satisfy({ $0.isLetter })
            .lookAhead(match(Character("c")))
            .decode(State(string: "cca", offset: 0, line: 1, column: 2))
        {
        case .success((let element, let state)):
            XCTAssertEqual(element, Character("c"))
            XCTAssertEqual(state, State(string: "cca", offset: 1, line: 1, column: 3))
        case .failure(_):
            XCTFail()
        }
        
        switch satisfy({ $0.isLetter })
            .lookAhead(match(Character("c")))
            .decode(State(string: "j1a", offset: 0, line: 1, column: 2))
        {
        case .success:
            XCTFail()
            
        case .failure(let error):
            XCTAssertEqual(error, .outOfBounds(0))
        }
    }
    
    func testArraySequenceA() {
        let arrayOfDecoders: Array<StringDecoder<Character, StringDecoderFailure>> = [match("A"), primitive(), match("C")]
        let sequenceAResult: StringDecoder<Array<Character>, StringDecoderFailure> = arrayOfDecoders.sequenceA()
        
        switch sequenceAResult("ABC") {
        case .success((let element, _)):
            XCTAssertEqual(element, ["A", "B", "C"])
        case .failure(_):
            XCTFail()
        }
    }
    
    func testNonEmptyArraySequenceA() {
        let listOfDecoders: Array<StringDecoder<Character, StringDecoderFailure>> = .init([match("A"), primitive(), match("C")])
        let sequenceAResult: StringDecoder<Array<Character>, StringDecoderFailure> = listOfDecoders.sequenceA()

        switch sequenceAResult("ABC") {
        case .success((let element, _)):
            XCTAssertEqual(element, .init(["A", "B", "C"]))
        case .failure(_):
            XCTFail()
        }
    }
    
    func testApplyCombinator() {
        struct Options: Equatable {
            let this: Character
            let that: Character
            let other: Character
        }
    
        let coder: StringDecoder<Options, StringDecoderFailure> =
            pure(curry(Options.init))
                .apply(match("A"))
                .apply(match("B"))
                .apply(match("C").discard(primitive()))
        
        switch coder("ABCD") {
        case .success((let options, _)):
            XCTAssertEqual(options, Options(this: "A", that: "B", other: "C"))
        case .failure(_):
            XCTFail()
        }
        
    }
    
    func testExpressions() {
        
        func expression() -> StringDecoder<Int, StringDecoderFailure> {
            wrap {
                term().chainLeft(match("+").between(space()).discardThen(pure(+)).or(match(" - ").discardThen(pure(-))))
            }
        }
        
        func term() -> StringDecoder<Int, StringDecoderFailure> {
            factor().chainLeft(match("*").between(space()).discardThen(pure(*)).or(match(" / ").discardThen(pure(/))))
        }
        
        func factor() -> StringDecoder<Int, StringDecoderFailure> {
            expression()
                .between(open: match("("), close: match(")")).or(integer())
        }
        
        func integer() -> StringDecoder<Int, StringDecoderFailure> {
            digit().some.map { Array($0) }.map { Int(String($0))! }
        }
        
        switch expression().many("(2 * 3 + 1 - 1 + (1 - 1)) / 2") {
        case .success((let eval, _)):
            XCTAssertEqual(eval, [3])
        case .failure(_):
            XCTFail()
        }
        
        switch expression().many("3") {
        case .success((let eval, _)):
            XCTAssertEqual(eval, [3])
        case .failure(_):
            XCTFail()
        }
    }
    
    func testNestedApplyCombinator() {
        enum LiteralExpression: Equatable {
            case integer(UInt8)
        }

        struct BinaryExpression: Equatable {
            let left: Expression
            let right: Expression
        }

        indirect enum Expression: Equatable {
            case literal(LiteralExpression)
            case binary(BinaryExpression)
        }

        func literalExpression() -> StringDecoder<LiteralExpression, StringDecoderFailure> {
            satisfy(isDigit).some.map { Array($0) }.map { .integer(UInt8(String($0))!) }
        }

        func binaryExpression() -> StringDecoder<BinaryExpression, StringDecoderFailure> {

            match("+ ").discardThen(
                pure(curry(BinaryExpression.init))
                    .apply(wrap { expression() }).discard(match(" + "))
                    .apply(wrap {expression() })
            )

        }


        func expression() -> StringDecoder<Expression, StringDecoderFailure> {
            binaryExpression()
                .map { .binary($0) }
                .or(literalExpression()
                    .map { .literal($0) })
        }
        
        switch literalExpression()("55") {
        case .success((let options, _)):
            XCTAssertEqual(options, .integer(55))
        case .failure(_):
            XCTFail()
        }

        switch binaryExpression()("+ 5 + 6") {
        case .success((let options, _)):
            XCTAssertEqual(options, BinaryExpression(left: .literal(.integer(5)), right: .literal(.integer(6))))
        case .failure(_):
            XCTFail()
        }

    }
    
    func testBuilder() {
        struct Options: Equatable {
            let this: Array<Character>
            let that: Character
            let other: Character
        }
    
        let coder =
            StringDecoder(Options.init) {
                match(Character("A")).many
                match(Character("B"))
                match(Character("C"))
            }
        
        switch coder("AAABC") {
        case .success((let options, _)):
            XCTAssertEqual(options, Options(this: ["A", "A", "A"], that: "B", other: "C"))
        case .failure(_):
            XCTFail()
        }
        
    }
}
