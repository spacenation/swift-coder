import XCTest
import StringDecoder

final class IndentTests: XCTestCase {
    func testIndent() {
        let string = """
        this
            that
            other
        
        this
            that
            other
        
        """
        
        struct Some: Equatable {
            let this: String
            let other: Other
        }
        
        struct Other: Equatable {
            let that: String
            let other: String
        }
        
        let element = StringDecoder(Some.init) {
            match("this").discard(newline())
            StringDecoder(Other.init) {
                match("that").discard(newline())
                indentation.discardThen("other").discard(newline())
            }
            .between(open: indent(), close: dedent())
            //indent().discardThen(match("that")).discard(newline()).discard(dedent())
        }//.between(open: indent(), close: dedent())
        
        let elements = element.many(separatedBy: newline())
        
        switch elements(string) {
        case .success((let element, let state)):
            //XCTAssertEqual(element, Some(this: "this", other: Other(that: "that", other: "other")))
            XCTAssertEqual(element, [
                Some(this: "this", other: Other(that: "that", other: "other")),
                Some(this: "this", other: Other(that: "that", other: "other"))
            ])
            XCTAssertEqual(state.indentation, 0)
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
        
        
    }
}
