
// MARK: Arrays

let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

let beatles = [john, paul, george, ringo]

beatles[1]

// MARK: Type annotations

let rush: [String] = [
    "Geddy",
    "Alex",
    "Neil"
]

// MARK: Sets

let colours = Set(["red", "green", "blue"])
print(colours)
let colours2 = Set(["yellow", "blue", "blue", "red", "red", "white"])
print(colours2)

let colourArray: [Set<String>] = [colours, colours2]
print(colourArray[0])

// MARK: Tuples

var name = (first: "Eduardo", last: "Righes")
name.0
name.1
name.first
name.last
name.last = "Maestri Righes"
//name.age = 42 // cannot change tuple definition

let nameArray: [(first: String, last: String)] = [name]
print(nameArray[0].last)

// MARK: Dictionaries

let ages = [
    "Eduardo": 42,
    "Marco": 6
]

let agesAnnotated: [String: Int] = [
    "Eduardo": 42,
    "Marco": 6
]

// MARK: Dictionaries -- default value

print(ages["Eduardo", default: 0]) // provide default
print(ages["Eduardo"] ?? 0)        // provide default
print(ages["Eduardo"]!)            // force unwrap
print(ages["Rafael", default: 0])

// MARK: Empty Collections

// MARK: Empty Dict

var agesEmptyDict = [String: Int]()
agesEmptyDict["Eduardo"] = 42

var emptyDict = Dictionary<String, Int>()

// MARK: Empty Array

var agesEmptyArray = [Int]()
agesEmptyArray.append(42)

var emptyArray = Array<Int>()

// MARK: Empty Set

var words = Set<String>()

// MARK: Enumerations

enum Result {
    case success
    case failure
}
let result = Result.success

// attach a value to an enum value
enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(value: Int)
}
let talking = Activity.talking(topic: "Swift")

// automatically assigns 0 to the first entry
enum Planet: Int {
    case mercury
    case venus
    case earth
    case mars
}
// create enum from raw value
let earth = Planet(rawValue: 2)

