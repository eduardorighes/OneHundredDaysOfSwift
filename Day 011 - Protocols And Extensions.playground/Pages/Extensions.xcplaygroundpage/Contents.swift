//: [Previous](@previous)

extension Int {
    
    func squared() -> Int {
        return self * self
    }
    
    // only computed properties
    // must be "var"
    var isEven: Bool {
        return self % 2 == 0
    }
}

let number = 8
number.squared()
number.isEven

//: [Next](@next)
