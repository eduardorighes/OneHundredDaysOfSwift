//: [Previous](@previous)

protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}

protocol Employee: Payable, NeedsTraining, HasVacation { }

struct Engineer: Employee {
    
    func calculateWages() -> Int {
        return 10
    }
    
    func study() {
        print("Studying...")
    }
    
    func takeVacation(days: Int) {
        print("Taking \(days) off")
    }
}

let engineer = Engineer()
engineer.calculateWages()
engineer.study()
engineer.takeVacation(days: 5)

//: [Next](@next)
