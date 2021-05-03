//: [Previous](@previous)

protocol Identifiable {
    var id: String { get set }
}

struct User: Identifiable {
    var id: String
}

func displayId(thing: Identifiable) {
    print("My id is \(thing.id)")
}

let user = User(id: "my_id")
displayId(thing: user)

//: [Next](@next)
