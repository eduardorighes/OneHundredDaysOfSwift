//: [Previous](@previous)

extension Collection {
    func summarize() {
        print("There are \(count) of us:")
        for name in self {
            print(name)
        }
    }
}

// Array
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]

// Set
let beatles = Set(["John", "Paul", "George", "Ringo"])

// Array and Set conform to Collection protocol, so we extend
// the protocol to provide new functionality

pythons.summarize()
beatles.summarize()

//: [Next](@next)
