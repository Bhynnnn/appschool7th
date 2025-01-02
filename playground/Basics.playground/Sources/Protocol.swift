//
//  Protocol.swift
//
//
//  Created by Jungman Bae on 1/2/25.
//
import Foundation

public func runProtocol() {
    print("runProtocol")
    let person = Person2(name: "Jungman", age: 20)
    print(person.description)

    let car = Car()
    car.move(to: CGPoint(x: 10, y: 20))
    print(car.postion)

    let person3 = Person3(name: "Jungman")
    person3.printDescription()

    print("car".makeUpperCase())
    
    let duck = Duck()
    duck.fly()
    duck.run()
    duck.swim()
    
    var intStack = IntStack()
    intStack.add(1)
    intStack.add(2)
    intStack.add(3)
    print(intStack.count)
}

protocol Describable {
    var description: String { get }
}

fileprivate struct Person2: Describable {
    let name: String
    let age: Int
    
    var description: String {
        return "Person: \(name), \(age)"
    }
}

protocol Movable {
    func move(to point: CGPoint)
}

class Car: Movable {
    var postion: CGPoint = CGPoint(x: 0, y: 0)
    
    func move(to point: CGPoint) {
        postion = point
        print("Car moved to \(point)")
    }
}

protocol Named {
    init(name: String)
    
    func displayName() -> String
}

extension Named {
    func printDescription() {
        print(displayName())
    }
}

extension String {
    func makeUpperCase() -> String {
        return uppercased()
    }
}

class Person3: Named {
    func displayName() -> String {
        return "Person2: \(name)"
    }
    
    let name: String
    
    required init(name: String) {
        self.name = name
    }
}

fileprivate class Friend2: Person3 {
    
    required init(name: String) {
        fatalError("init(name:) has not been implemented")
    }
    
    
    let age: Int
    
}

fileprivate struct Point2: Named {
    func displayName() -> String {
        return "Point: \(name)"
    }
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

protocol Payable {
    func calculateWages() -> Double
}

protocol TimeOffRequestable {
    func requestTimeOff(days: Int) -> Bool
}

func processEmployee(employee: Payable & TimeOffRequestable) {
    let wages = employee.calculateWages()
    let timeOffRequested = employee.requestTimeOff(days: 10)
    print("Wages: \(wages), Time Off Requested: \(timeOffRequested)")
}

protocol Container {
    associatedtype Item
    mutating func add(_ item: Item)
    var count: Int { get }
}

struct IntStack: Container {
    typealias Item = Int
    
    private var items: [Item] = []
    mutating func add(_ item: Item) { items.append(item) }
    var count: Item { items.count }
}

func printDecription<T: Describable>(_ item: T) {
    print(item.description)
}

protocol Runnable {
    func run()
}

protocol Swimmable {
    func swim()
}

protocol Flyable {
    func fly()
}

struct Bird: Flyable, Runnable {
    func fly() { print("Flying") }
    func run() { print("Running") }
}

struct Fish: Swimmable {
    func swim() { print("Swimming") }
}

struct Duck: Flyable, Runnable, Swimmable {
    func fly() { print("Flying") }
    func run() { print("Running") }
    func swim() { print("Swimming") }
}
