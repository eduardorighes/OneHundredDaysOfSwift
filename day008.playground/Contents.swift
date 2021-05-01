// MARK: Structs, part one - https://www.hackingwithswift.com/100/8

// MARK: Creating structs

struct Sport1 {
    var name: String = "Football"
}

var tennis = Sport1(name: "Tennis")
print(tennis.name)

tennis.name = "Lawn Tennis"
print(tennis.name)

var football = Sport1()
print(football.name)

// MARK: Computed properties

struct Sport2 {
    var name: String
    var isOlympicSport: Bool
    
    var olympicSport: String {
        if isOlympicSport {
            return "\(name) is an olympic sport"
        } else {
            return "\(name) is not an olympic sport"
        }
    }
}

let chessBoxing = Sport2(name: "Chess Boxing", isOlympicSport: false)
print(chessBoxing.olympicSport)

// MARK: Property observers

struct Progress {
    var task: String
    var amount: Int {
        didSet {
            print("\(task) is now \(amount)% complete")
        }
    }
}

var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 50
progress.amount = 100

// MARK: Methods

struct City {
    var population: Int
    
    func collectTaxes() -> Int {
        return population * 1000
    }
}

let london = City(population: 9_000_000)
london.collectTaxes()

// MARK: Mutating Methods

struct Person {
    var name: String
    
    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}

var person = Person(name: "Ed")
person.makeAnonymous()
print(person.name)

// MARK: Properties and methods of strings

let string = "Do or do not, there is no try."
print(string.count)
print(string.hasPrefix("Do"))
print(string.uppercased())
print(string.sorted())
print(string.split(separator: " "))

// MARK: Properties and methods of arrays

var toys = ["Woody"]
print(toys)

toys.append("Buzz")
toys.firstIndex(of: "Buzz")
print(toys.sorted())

toys.remove(at: 0)
print(toys)
