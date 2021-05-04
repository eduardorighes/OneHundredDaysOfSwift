//: [Previous](@previous)

func username(for id: Int) -> String? {
    if id == 0 {
        return "root"
    } else {
        return nil
    }
}

// username will return nil, so use the nil coalescing
// operator to provide a default value in that case

let user = username(for: 1000) ?? "Unknown"
print(user)

//: [Next](@next)
