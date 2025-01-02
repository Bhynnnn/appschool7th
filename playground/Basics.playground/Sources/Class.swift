/// 클래스를 사용하는 경우:
/// - 참조가 필요
/// - 상속이 필요할 때
/// - 인스턴스의 identity를 제어해야할 때
class Person {
    let givenName: String
    let middleName: String?
    let familyName: String
    var country: String = "KR"
    
    init(givenName: String, middleName: String? = nil, familyName: String) {
        self.givenName = givenName
        self.middleName = middleName
        self.familyName = familyName
    }
    
    var displayName: String {
        return "\(fullName()) - Location: \(country)"
    }
    
    func fullName() -> String {
        var fullName: String = ""
        if let middleName { fullName += middleName + " " }
        fullName += self.givenName + " " + self.familyName
        return fullName
    }
    
    static func createDummyPerson() -> Person {
        return Person(givenName: "John", familyName: "Doe")
    }
}

final class Friend: Person {
    var whereWeMet: String?
    
    override var displayName: String {
        return super.displayName + " - Where we met: \(self.whereWeMet ?? "Unknown")"
    }
}
//class BusinessRelation: Friend {} // final 로 인해 더이상 상속 불가

final class Family: Person {
    let relationship: String
    
    init(givenName: String, middleName: String? = nil, familyName: String = "Barker", relationship: String) {
        self.relationship = relationship
        super.init(givenName: givenName, middleName: middleName, familyName: familyName)
    }
    
    override var displayName: String {
        return super.displayName + " - Relationship: \(self.relationship)"
    }
}


public func runClass() {
    let person = Person.createDummyPerson()
    print(person.fullName())

    let person2 = Person(givenName: "Jane", familyName: "Doe")
    print(person2.fullName())

    let person3 = Person.createDummyPerson()
    person3.country = "US"
    print(person3.displayName)
    print(person.displayName)

    let friend = Friend(givenName: "길동", familyName: "홍")
    friend.whereWeMet = "London"
    print(friend.displayName)

    print("------------------------------")

    let steve = Person(givenName: "Steve", middleName: "Paul", familyName: "Jobs")
    let sam = Friend(givenName: "Sam", middleName: "Now", familyName: "Rowley")
    sam.whereWeMet = "Work together at Jaguar Land Rover"
    let maddie = Family(givenName: "Maddie", middleName: "Rose", relationship: "Daughter")
    let mark = Family(givenName: "Mark", middleName: "David", familyName: "Pendlebury", relationship: "Brother-In-Law")
    mark.country = "USA"

    print(steve.displayName)
    print(sam.displayName)
    print(maddie.displayName)
    print(mark.displayName)
}
