//: [Previous](@previous)

class Animal { }
class Fish: Animal { }

class Dog: Animal {
    func makeNoise() {
        print("woof!")
    }
}

// Swift knows both are Animal, so the array is [Animal]
let pets = [Fish(), Dog(), Fish(), Dog()]

for pet in pets {
    // Dog() if conversion is successful
    // nil otherwise
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}

//: [Next](@next)
