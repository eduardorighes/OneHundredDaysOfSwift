//: [Previous](@previous)

protocol Identifiable {
    var id: String { get set }
    func identify()
}

// provide a default implementation for the protocol

extension Identifiable {
    func identify() {
        print("I am \(id)")
    }
}

struct User: Identifiable {
    var id: String
}

let root = User(id: "root")
root.identify()

//: [Next](@next)
