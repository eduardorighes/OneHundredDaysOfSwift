//: [Previous](@previous)

var name: String? = nil

if let unwrapped = name {
    print("Name has \(unwrapped.count) chars.")
} else {
    print("Missing name.")
}

var address: String? = "123 Road"

if let unwrapped = address {
    print("Address has \(unwrapped.count) chars.")
} else {
    print("Missing address.")
}

//: [Next](@next)
