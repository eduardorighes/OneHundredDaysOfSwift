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

// MARK: Additional Examples

protocol Purchasable {
    var name: String { get set }
}

struct Book: Purchasable {
    var name: String
    var author: String
}

struct Movie: Purchasable {
    var name: String
    var actors: [String]
}

struct Car: Purchasable {
    var name: String
    var manufacturer: String
}

struct Coffee: Purchasable {
    var name: String
    var strength: Int
}

func buy(_ item: Purchasable) {
    print("I am buying \(item.name)")
}

let book = Book(name: "Ready Player One", author: "Ernest Cline")
let movie = Movie(name: "The Matrix", actors: ["Keanu Reeves", "Laurence Fishburne"])
let car = Car(name: "HR-V", manufacturer: "Honda")
let coffee = Coffee(name: "Lavazza", strength: 5)

buy(book)
buy(movie)
buy(car)
buy(coffee)

//: [Next](@next)
