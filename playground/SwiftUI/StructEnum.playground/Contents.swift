
struct SampleStruct {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func buildHelloMsg() -> String {
        // 함수의 한줄 실행구문(줄)의 결과가 함수의 반환타입과 일치하는 경우 return 생략이 가능
        /* return */ "Hello, \(name)"
    }
}

class SampleClass {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func buildHelloMsg() -> String {
        return "Hello " + name
    }
}

let myStruct1 = SampleStruct(name: "Mark")
var myStruct2 = myStruct1
myStruct2.name = "David"

print(myStruct1.name)  // 출력: Mark
print(myStruct2.name)  // 출력: David

let myClass1 = SampleClass(name: "Mark")
var myClass2 = myClass1
myClass2.name = "David"

print(myClass1.name)  // 출력: David
print(myClass2.name)  // 출력: David

enum Temperature {
    case hot
    case warm
    case cold(centigrade: Int)
}

func displayTempInfo(temp: Temperature) {
    switch temp {
    case .hot:
        print("Hot")
    case .warm:
        print("Warm")
    case .cold(let centigrade) where centigrade <= 0:
        print("Ice Warning: \(centigrade) degrees.")
    case .cold:
        print("Cold")
    }
}

displayTempInfo(temp: .cold(centigrade: -10))
displayTempInfo(temp: .cold(centigrade: 10))
