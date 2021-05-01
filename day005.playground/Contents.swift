// MARK: Functions

// MARK: Writing functions

func printHelp() {
    let message = """
Welcome to MyApp

Run this app inside a directory of images and
MyApp will resize them all into thumbnails
"""

    print(message)
}

printHelp()

// MARK: Accepting parameters

//func square(number: Int) {
//    print(number * number)
//}
//
//square(number: 8)

// MARK: Returning values

func square(number: Int) -> Int {
    return number * number
}

let result = square(number: 8)
print(result)

// MARK: Parameter labels

func sayHello(to name: String) {
    print("Hello, \(name)")
}

sayHello(to: "Eduardo")

// MARK: Omitting parameter labels

//func greet(_ person: String) {
//    print("Hello, \(person)")
//}
//
//greet("Eduardo")

// MARK: Default parameters

func greet(_ person: String, nicely: Bool = true) {
    if nicely == true {
        print("Hello, \(person)")
    } else {
        print("Oh no, it's \(person) again...")
    }
}

greet("Eduardo")
greet("Eduardo", nicely: false)

// MARK: Variadic functions

print("Haters", "gonna", "hate")

func square(numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}

square(numbers: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

// MARK: Writing/Running throwing functions

enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    return true
}

do {
    try checkPassword("password")
    print("That password is good")
} catch {
    print("You cannot use that password")
}

// MARK: inout parameters

func doubleInPlace(number: inout Int) {
    number *= 2
}

var myNumber = 20
doubleInPlace(number: &myNumber)
print(myNumber)
