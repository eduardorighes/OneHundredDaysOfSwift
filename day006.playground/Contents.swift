// MARK: Closures, part one

// MARK: Creating basic closures

let driving1 = {
    print("driving a car...")
}

driving1()

// MARK: Accepting parameters in a closure

let driving2 = { (place: String) in
    print("driving to \(place)")
}

driving2("London")

// MARK: Returning values

let driving3 = { (place: String) -> String in
    return "I am going to \(place)"
}

let message = driving3("London")
print(message)

// MARK: Closures as parameters

func travel(action: () -> Void) {
    print("-----------------")
    print("Preparing...")
    action()
    print("Done.")
}

travel(action: driving1)

travel(action: {
    print("driving somewhere...")
})

// MARK: Trailing closure syntax

// the block below is the closure being passed to
// travel(action: () -> Void)

// the following is only valid because the closure is
// the last parameter in travel.
// using this syntax it is possible to pass additional
// parameters in the parenthesis

travel() {
    print("travel1")
}

// this syntax only works if travel does not take any other
// parameters

travel {
    print("travel2")
}

