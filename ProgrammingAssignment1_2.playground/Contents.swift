
import Foundation

// Частина 1

// Дано рядок у форматі "Student1 - Group1; Student2 - Group2; ..."

let studentsStr = "Дмитренко Олександр - ІП-84; Матвійчук Андрій - ІВ-83; Лесик Сергій - ІО-82; Ткаченко Ярослав - ІВ-83; Аверкова Анастасія - ІО-83; Соловйов Даніїл - ІО-83; Рахуба Вероніка - ІО-81; Кочерук Давид - ІВ-83; Лихацька Юлія- ІВ-82; Головенець Руслан - ІВ-83; Ющенко Андрій - ІО-82; Мінченко Володимир - ІП-83; Мартинюк Назар - ІО-82; Базова Лідія - ІВ-81; Снігурець Олег - ІВ-81; Роман Олександр - ІО-82; Дудка Максим - ІО-81; Кулініч Віталій - ІВ-81; Жуков Михайло - ІП-83; Грабко Михайло - ІВ-81; Іванов Володимир - ІО-81; Востриков Нікіта - ІО-82; Бондаренко Максим - ІВ-83; Скрипченко Володимир - ІВ-82; Кобук Назар - ІО-81; Дровнін Павло - ІВ-83; Тарасенко Юлія - ІО-82; Дрозд Світлана - ІВ-81; Фещенко Кирил - ІО-82; Крамар Віктор - ІО-83; Іванов Дмитро - ІВ-82"

// Завдання 1
// Заповніть словник, де:
// - ключ – назва групи
// - значення – відсортований масив студентів, які відносяться до відповідної групи

var studentsGroups: [String: [String]] = [:]

// Ваш код починається тут

let studentAndGroupStrs = studentsStr.components(separatedBy: "; ")

let pairs: [(student: String, group: String)] = studentAndGroupStrs.compactMap {
    let components = $0.components(separatedBy: "- ").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }

    guard components.count == 2 else {
        return nil
    }
    
    return (student: components[0], group: components[1])
}

for pair in pairs {
    
    let student = pair.student
    let group = pair.group
    
    if studentsGroups[group] == nil {
        studentsGroups[group] = [student]
    } else {
        studentsGroups[group]!.append(student)
    }
    
}


// Ваш код закінчується тут

print("Завдання 1")
print(studentsGroups)
print()

// Дано масив з максимально можливими оцінками

let points: [Int] = [12, 12, 12, 12, 12, 12, 12, 16]

// Завдання 2
// Заповніть словник, де:
// - ключ – назва групи
// - значення – словник, де:
//   - ключ – студент, який відносяться до відповідної групи
//   - значення – масив з оцінками студента (заповніть масив випадковими значеннями, використовуючи функцію `randomValue(maxValue: Int) -> Int`)

func randomValue(maxValue: Int) -> Int {
    switch(arc4random_uniform(6)) {
    case 1:
        return Int(ceil(Float(maxValue) * 0.7))
    case 2:
        return Int(ceil(Float(maxValue) * 0.9))
    case 3, 4, 5:
        return maxValue
    default:
        return 0
    }
}

var studentPoints: [String: [String: [Int]]] = [:]

// Ваш код починається тут

for group in studentsGroups.keys {
    studentPoints[group] = [:]

    for student in studentsGroups[group]! {
        studentPoints[group]![student] = []
        
        for maxPoints in points {
            studentPoints[group]![student]!.append(randomValue(maxValue: maxPoints))
        }
    }
}

// Ваш код закінчується тут

print("Завдання 2")
print(studentPoints)
print()

// Завдання 3
// Заповніть словник, де:
// - ключ – назва групи
// - значення – словник, де:
//   - ключ – студент, який відносяться до відповідної групи
//   - значення – сума оцінок студента

var sumPoints: [String: [String: Int]] = [:]

// Ваш код починається тут

for group in studentsGroups.keys {
    sumPoints[group] = [:]
    for (student, marks) in studentPoints[group]! {
        sumPoints[group]![student] = marks.reduce(0, +)
    }
}

// Ваш код закінчується тут

print("Завдання 3")
print(sumPoints)
print()

// Завдання 4
// Заповніть словник, де:
// - ключ – назва групи
// - значення – середня оцінка всіх студентів групи

var groupAvg: [String: Float] = [:]

// Ваш код починається тут

for group in studentsGroups.keys {
    
    let studentsInGroup = sumPoints[group]!.values.count
    let groupTotal = sumPoints[group]!.reduce(0) { $0 + $1.value }
    groupAvg[group] = Float(groupTotal) / Float(studentsInGroup)
    
}

// Ваш код закінчується тут

print("Завдання 4")
print(groupAvg)
print()

// Завдання 5
// Заповніть словник, де:
// - ключ – назва групи
// - значення – масив студентів, які мають >= 60 балів

var passedPerGroup: [String: [String]] = [:]

// Ваш код починається тут

for group in studentsGroups.keys {
    passedPerGroup[group] = []
    sumPoints[group]!.forEach {
        if $1 >= 60 {
            passedPerGroup[group]?.append($0)
        }
    }
}

// Ваш код закінчується тут

print("Завдання 5")
print(passedPerGroup)

// Приклад виведення. Ваш результат буде відрізнятися від прикладу через використання функції random для заповнення масиву оцінок та через інші вхідні дані.
//
//Завдання 1
//["ІВ-73": ["Гончар Юрій", "Давиденко Костянтин", "Капінус Артем", "Науменко Павло", "Чередніченко Владислав"], "ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-71": ["Андрющенко Данило", "Гуменюк Олександр", "Корнійчук Ольга", "Музика Олександр", "Трудов Антон", "Феофанов Іван"]]
//
//Завдання 2
//["ІВ-73": ["Давиденко Костянтин": [5, 8, 9, 12, 11, 12, 0, 0, 14], "Капінус Артем": [5, 8, 12, 12, 0, 12, 12, 12, 11], "Науменко Павло": [4, 8, 0, 12, 12, 11, 12, 12, 15], "Чередніченко Владислав": [5, 8, 12, 12, 11, 12, 12, 12, 15], "Гончар Юрій": [5, 6, 0, 12, 0, 11, 12, 11, 14]], "ІВ-71": ["Корнійчук Ольга": [0, 0, 12, 9, 11, 11, 9, 12, 15], "Музика Олександр": [5, 8, 12, 0, 11, 12, 0, 9, 15], "Гуменюк Олександр": [5, 8, 12, 9, 12, 12, 11, 12, 15], "Трудов Антон": [5, 0, 0, 11, 11, 0, 12, 12, 15], "Андрющенко Данило": [5, 6, 0, 12, 12, 12, 0, 9, 15], "Феофанов Іван": [5, 8, 12, 9, 12, 9, 11, 12, 14]], "ІВ-72": ["Киба Олег": [5, 8, 12, 12, 11, 12, 0, 0, 11], "Овчарова Юстіна": [5, 8, 12, 0, 11, 12, 12, 12, 15], "Бортнік Василь": [4, 8, 12, 12, 0, 12, 9, 12, 15], "Тимко Андрій": [0, 8, 11, 0, 12, 12, 9, 12, 15]]]
//
//Завдання 3
//["ІВ-72": ["Бортнік Василь": 84, "Тимко Андрій": 79, "Овчарова Юстіна": 87, "Киба Олег": 71], "ІВ-73": ["Капінус Артем": 84, "Науменко Павло": 86, "Чередніченко Владислав": 99, "Гончар Юрій": 71, "Давиденко Костянтин": 71], "ІВ-71": ["Корнійчук Ольга": 79, "Трудов Антон": 66, "Андрющенко Данило": 71, "Гуменюк Олександр": 96, "Феофанов Іван": 92, "Музика Олександр": 72]]
//
//Завдання 4
//["ІВ-71": 79.333336, "ІВ-72": 80.25, "ІВ-73": 82.2]
//
//Завдання 5
//["ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-73": ["Давиденко Костянтин", "Капінус Артем", "Чередніченко Владислав", "Гончар Юрій", "Науменко Павло"], "ІВ-71": ["Музика Олександр", "Трудов Антон", "Гуменюк Олександр", "Феофанов Іван", "Андрющенко Данило", "Корнійчук Ольга"]]

enum Direction {
    case latitude
    case longitude
}


class CoordinateMS {
    
    var direction: Direction
    var degree: Int
    var minutes: UInt
    var seconds: UInt
    
    init() {
        self.direction = Direction.latitude
        self.degree = 0
        self.minutes = 0
        self.seconds = 0
    }
    
    init(degree: Int, minutes: UInt, seconds: UInt) {
        
        if (0 <= minutes && minutes < 60) {
            self.minutes = minutes
        } else {
            self.minutes = 0
        }

        if (0 <= seconds && seconds < 60) {
            self.seconds = seconds
        } else {
            self.seconds = 0
        }

        if (-90 <= degree && degree < 90) {
            self.direction = .longitude
            self.degree = degree
        } else if (-180 <= degree && degree < 180) {
            self.direction = .latitude
            self.degree = degree
        } else {
            self.direction = .latitude
            self.degree = 0
        }
        
    }
    
    func location() -> String {
        return "\(degree)°​​\(minutes)′\(seconds)\"​ \(compasDirection)"
    }
    
    func decimalLocation() -> String {
        let value = (Double(abs(degree)) * 3600.0 + Double(minutes) * 60.0 + Double(seconds)) / 3600.0
        return (degree < 0 ? "-" : "+") + "\(value) \(compasDirection)"
    }
    
    var compasDirection: String {
        
        if direction == Direction.latitude {
            return degree >= 0 ? "N" : "S"
        } else {
            return degree >= 0 ? "E" : "W"
        }
    }
    
    func middle(to coordinate: CoordinateMS) -> CoordinateMS? {
        guard self.direction == coordinate.direction else {
            return nil
        }
        
        return CoordinateMS(degree: (degree + coordinate.degree) / 2,
                            minutes: (minutes + coordinate.minutes) / 2,
                            seconds: (seconds + coordinate.seconds) / 2)
    }
    
    static func middle(from startCoordinate: CoordinateMS, to endCoordinate: CoordinateMS) -> CoordinateMS? {
        return startCoordinate.middle(to: endCoordinate)
    }
    
}

let coord1 = CoordinateMS()
print("---------------------------")
print(coord1.location(), coord1.decimalLocation())
print("---------------------------")

let coord2 = CoordinateMS(degree: 999, minutes: 999, seconds: 999)
print(coord2.decimalLocation())
print("---------------------------")

let coord3 = CoordinateMS(degree: 54, minutes: 32, seconds: 10)
print(coord3.location())
print("---------------------------")

let coord4 = CoordinateMS(degree: 179, minutes: 59, seconds: 59)
print(coord4.location())
print("---------------------------")

print(CoordinateMS.middle(from: coord3, to: coord4)?.decimalLocation() as Any)
print("---------------------------")

let coord5 = CoordinateMS(degree: -111, minutes: 11, seconds: 11)
print(coord5.decimalLocation())
print("---------------------------")

print(CoordinateMS.middle(from: coord4, to: coord5)?.location() as Any)
print("---------------------------")

print(coord3.middle(to: coord5)?.location() as Any)
print("---------------------------")

print(coord1.middle(to: coord4)?.location() as Any)
print("---------------------------")
