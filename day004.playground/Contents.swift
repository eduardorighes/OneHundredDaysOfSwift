// MARK: Loops

// MARK: For loops

let count = 1...10

for number in count {
    print("number is \(number)")
}

let albums = ["Moving Pictures", "Permanent Waves", "Counterparts"]

for album in albums {
    print("album is \(album)")
}

for _ in 1...5 {
    print("loop")
}

// MARK: While loops

var number = 1

while number <= 20 {
    print(number)
    number += 1
}

// MARK: Repeat Loops

number = 1

repeat {
    print(number)
    number += 1
} while number <= 20

repeat {
    print("This is false")
} while false

// MARK: Exiting loops

var countDown = 10

while countDown >= 0 {
    print(countDown)
    countDown -= 1
}
print("Blast off")

countDown = 10

while countDown >= 0 {
    print(countDown)
    
    if countDown == 4 {
        print("Abort launch!")
        break
    }
    
    countDown -= 1
}

// MARK: Exiting multiple loops

for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print("\(i) * \(j) is \(product)")
    }
}

outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print("\(i) * \(j) is \(product)")
        
        if product == 50 {
            print("Exiting...")
            break outerLoop
        }
    }
}

// MARK: Skipping items

for i in 1...10 {
    if i % 2 == 1 {
        continue
    }
    print(i)
}

// MARK: Infinite loops

var counter = 0

while true {
    print(counter)
    counter += 1
    
    if counter == 14 {
        break
    }
}
