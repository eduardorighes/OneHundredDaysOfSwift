// MARK: Closures, part two

// MARK: Passing parameters to closures

func travel(action: (String) -> Void) {
    print("--------------------")
    print("getting ready to travel")
    action("London")
}

travel { (place: String) in
    print("I am going to \(place)")
}

// MARK: Closures with return values

func travel2(action: (String) -> String) {
    print("--------------------")
    print("Getting ready to travel")
    let description = action("London")
    print(description)
    print("I arrived")
}

travel2 { (place: String) -> String in
    return "I am going to \(place)"
}

travel2(action: { (String) -> String in
    return "I am going to Southampton"
})

// MARK: Shorthand with parameter names

travel2 { (place: String) -> String in
    return "I am going to \(place)"
}

// Swift knows the type of 'place'
travel2 { place -> String in
    return "I am going to \(place)"
}

// Swift knows the return type
travel2 { place in
    return "I am going to \(place)"
}

// Swift knows if there is only one line of code
// that must be the return value, so you can omit
// the return keyword
travel2 { place in
    "I am going to \(place)"
}

// Swift allows automatic names for closure parameters
// starting from $0
travel2 {
    "I am going to \($0)"
}

// MARK: Closures with multiple parameters

func travel3(action: (String, Int) -> String) {
    print("------------")
    print("Getting ready")
    let description = action("London", 60)
    print(description)
    print("I arrived")
}

travel3 {
    "I am going to \($0) at \($1) mph"
}

travel3 { place, speed in
    "I am going to \(place) at \(speed) mph"
}

// MARK: Returning closures

print("------------")

func travel4() -> (String) -> Void {
    return {
        print("I am going to \($0)")
    }
}

let myClosure = travel4()
myClosure("London")

// MARK: Capturing values

print("------------")

func travel5() -> (String) -> Void {
    var counter = 1
    return {
        print("\(counter). I am going to \($0)")
        counter += 1
    }
}

let myCountedClosure = travel5();
myCountedClosure("London")
myCountedClosure("London")
myCountedClosure("London")

