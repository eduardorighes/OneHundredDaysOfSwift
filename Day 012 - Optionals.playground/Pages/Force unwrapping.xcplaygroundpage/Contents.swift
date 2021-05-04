//: [Previous](@previous)

var str = "5"

// This creates a Int? as we could have any string
// in str. Just use ! if you are certain the value is
// valid.
var num = Int(str)!

if let n = Int(str) {
    print("str = \(n)")
}

//: [Next](@next)
