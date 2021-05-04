//: [Previous](@previous)

func greet(_ name: String?) {
    
    guard let unwrapped = name else {
        print("Missing name.")
        return
    }
    
    print("Hello, \(unwrapped)!")
}

var person1: String? = nil
var person2: String? = "Homer Simpson"

greet(person1)
greet(person2)

//: [Next](@next)
