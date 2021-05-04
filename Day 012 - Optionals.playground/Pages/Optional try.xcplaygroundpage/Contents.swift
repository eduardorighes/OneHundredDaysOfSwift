//: [Previous](@previous)

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
    print("That password is good!")
} catch {
    print("You can't use that password.")
}

if let result = try? checkPassword("password") {
    print("Result was \(result)")
} else {
    print("Nope")
}

// if you know the function will not fail, you can use
// try!, but that will crash the application if it gets
// nil

try! checkPassword("segredo")
print("OK")

//: [Next](@next)
