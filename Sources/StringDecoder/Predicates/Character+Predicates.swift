import Foundation

public func isSpace(_ c: Character) -> Bool {
    c == " "
}

public func isAlphanumeric(_ c: Character) -> Bool {
    c.isNumber || c.isLetter
}

public func isDigit(_ c: Character) -> Bool {
    "0"..."9" ~= c
}

public func isPositiveDigit(_ c: Character) -> Bool {
    "1"..."9" ~= c
}

public func isLetter(_ c: Character) -> Bool {
    c.isLetter
}

public func isLowercaseLetter(_ c: Character) -> Bool {
    c.isLetter && c.isLowercase
}

public func isUppercaseLetter(_ c: Character) -> Bool {
    c.isLetter && c.isUppercase
}

public func isBit(_ c: Character) -> Bool {
    switch c {
    case "0", "1":
        return true
    default:
        return false
    }
}

public func isUppercaseHex(_ c: Character) -> Bool {
    switch c {
    case let hexC where "0"..."9" ~= hexC || "A"..."F" ~= hexC:
        return true
    default:
        return false
    }
}

public func isLowercaseHex(_ c: Character) -> Bool {
    switch c {
    case let hexC where "0"..."9" ~= hexC || "a"..."f" ~= hexC:
        return true
    default:
        return false
    }
}
