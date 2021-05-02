// MARK: Classes

// MARK: Creating your own classes

class Dog {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

let poppy = Dog(name: "Poppy", breed: "Poodle")

// MARK: Class inheritance

class Poodle: Dog {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
}

let fido = Poodle(name: "Fido")

// MARK: Overriding methods

class Dog2 {
    func makeNoise() {
        print("woof")
    }
}

class Poodle2: Dog2 {
    override func makeNoise() {
        print("yip")
    }
}

let poppy2 = Poodle2()
poppy2.makeNoise()

// MARK: Final classes

final class Dog3 {
    var name: String
    var breed: String
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

// This is an error, cannot inherit from final classes
//class Labrador: Dog3 {
//}

// MARK: Copying objects

// structs - all properties are copied, so 2 structs are different instances
// classes - assigning one class instance to another class variable will
// point to the same instance, so changing one will change the other too.

struct Band {
    var name: String
}

let band1 = Band(name: "Rush")
print(band1.name)
var band2 = band1
band2.name = "Iron Maiden"
print(band1.name)

class FootballClub {
    var name: String
    init(name: String) {
        self.name = name
    }
}

var club1 = FootballClub(name: "Barcelona")
print(club1.name)
var club2 = club1
club2.name = "Real Madrid"
print(club1.name)

// MARK: Deinitializers

class Person {
    var name: String = "John Doe"
    
    init() {
        print("\(name) is alive!")
    }
    
    deinit {
        print("\(name) is no more!")
    }
    
    func printGreeting() {
        print("Hello, I am \(name)")
    }
}

for _ in 1...3 {
    let person = Person()
    person.printGreeting()
}

// MARK: Mutability

class Game1 {
    var name = "Street Fighter II"
}

// sf2 is constant but that does not prevent its properties to be changed
let sf2 = Game1()
sf2.name = "Final Fight"
print(sf2.name)

// use "let" when creating a class property to avoid that

class Game2 {
    let name = "Super Mario World"
}

let smw = Game2()
//smw.name = "Super Mario Bros 3" // Error: Game2.name is a constant
print(smw.name)

