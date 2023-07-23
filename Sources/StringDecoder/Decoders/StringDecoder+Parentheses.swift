import Foundation

public let leftParentheses: StringDecoder<Character, StringDecoderFailure> = match(Character("("))

public let rightParentheses: StringDecoder<Character, StringDecoderFailure> = match(Character(")"))
