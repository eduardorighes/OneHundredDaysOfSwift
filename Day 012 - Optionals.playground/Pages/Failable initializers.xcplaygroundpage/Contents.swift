//: [Previous](@previous)

struct Person {
    var id: String
    
    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}

let p1 = Person(id: "abc")
if let unwrapped = p1 {
    print("p1 = \(unwrapped.id)")
} else {
    print("p1 is nil")
}

let p2 = Person(id: "abcabcabc")
if let unwrapped = p2 {
    print("p2 = \(unwrapped.id)")
} else {
    print("p2 is nil")
}

//: [Next](@next)
