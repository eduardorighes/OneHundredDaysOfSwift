// MARK: Structs, part two - https://www.hackingwithswift.com/100/9

// MARK: Initializers

struct User {
    var username: String
    
    // all properties must be initialized before init() ends
    init() {
        username = "Anonymous"
        print("Creating a new user!")
    }
}

var user = User()
print(user.username)
user.username = "root"
print(user.username)

// MARK: Referring to the current instance

struct Person {
    var name: String
    
    init(name: String) {
        print("\(name) was born!")
        self.name = name
    }
}

// MARK: Lazy properties

struct FamilyTree {
    init() {
        print("Creating a family tree")
    }
}

struct Person2 {
    var name: String
    lazy var familyTree = FamilyTree()
    
    init(name: String) {
        self.name = name
    }
}

var ed = Person2(name: "Ed")
// The FamilyTree object is only created on the first access
ed.familyTree

// MARK: Static properties and methods

struct Student {
    static var classSize = 0
    var name: String
    
    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}

let barney = Student(name: "Barney")
let fred = Student(name: "Fred")
print(Student.classSize)

// MARK: Access control

struct Person3 {
    private var id: String
    
    init(id: String) {
        self.id = id
    }
    
    func identify() -> String {
        return "My social security number is \(id)"
    }
}

let hommer = Person3(id: "12345")
print(hommer.identify())

// Note: if a property is private, you need to define init()
// Note: all properties must be initialized by the time init() ends
// (initialized when declaring the property or in init())

// Refer to https://docs.swift.org/swift-book/LanguageGuide/AccessControl.html
// as it is a bit complex...
