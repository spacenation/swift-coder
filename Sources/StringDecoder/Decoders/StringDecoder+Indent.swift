import Foundation



public func indent(by count: Int = 1) -> StringDecoder<Array<String>, StringDecoderFailure> {
    StringDecoder { input in
        print("Indent:", input)
        return space().count(4 * (input.indentation + count)).decode(input.indent(by: count))
    }
}

public func dedent(by count: Int = 1) -> StringDecoder<Array<String>, StringDecoderFailure> {
    StringDecoder { input in
        print("Indent:", input)
        return space().count(4 * (input.indentation - count)).decode(input.indent(by: -count))
    }
}

public var indentation: StringDecoder<Array<String>, StringDecoderFailure> {
    StringDecoder { input in
        print("Indent:", input)
        return space().count(4 * (input.indentation)).decode(input)
    }
}
