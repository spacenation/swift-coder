import Foundation

public let leftParentheses: StringDecoder<Character, StringDecoderFailure> = match(Character("("))

public let rightParentheses: StringDecoder<Character, StringDecoderFailure> = match(Character(")"))


public let leftCurlyBracket: StringDecoder<Character, StringDecoderFailure> = match(Character("{"))
public let rightCurlyBracket: StringDecoder<Character, StringDecoderFailure> = match(Character("}"))

public extension StringDecoder where Failure == StringDecoderFailure {
    var insideCurlyBrackets: Self {
        self.between(
            open: leftCurlyBracket.discard(whitespace()),
            close: whitespace().discardThen(rightCurlyBracket)
        )
    }
}
