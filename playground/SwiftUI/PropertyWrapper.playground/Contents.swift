struct Address {
    private var cityName: String = ""
    var city: String {
        get { cityName }
        set{ cityName = newValue.uppercased() }
    }
}

var address: Address = Address()
address.city = "Chicago"
print(address.city)

@propertyWrapper
struct FixCase {
    private(set) var value: String = ""
    var wrappedValue: String {
        get { value }
        set { value = newValue.uppercased() }
    }
    
    init(wrappedValue initialValue: String) {
        self.wrappedValue = initialValue
    }
}

struct Contact {
    @FixCase var name: String
    @FixCase var city: String
    @FixCase var country: String
    // 생략가능
//    init(name: String, city: String, country: String) {
//        self.name = name
//        self.city = city
//        self.country = country
//    }
}

var contact: Contact = Contact(name: "John", city: "Chicago", country: "USA")
print("contact: \(contact.name), \(contact.city), \(contact.country)")

@propertyWrapper
struct MinMaxVal<V: Comparable> {
    private(set) var value: V
    let min: V
    let max: V
    
    init(wrappedValue initialValue: V, min: V, max: V) {
        self.min = min
        self.max = max
        value = initialValue
    }
        
    var wrappedValue: V {
        get { value }
        // 조건을 가지고 변수 할당을 대신 처리하는 set 함수
        set {
            // 최대값을 넘는 경우 최대값으로 변수의 값을 지정
            if newValue > max {
                value = max
            // 최소값보다 작은 경우 최소값으로 변수의 값을 지정
            } else if newValue < min {
                value = min
            } else {
                value = newValue
            }
        }
    }
}

struct IntDemo {
    @MinMaxVal(min:10, max:200) var value: Int = 100
}

var demo = IntDemo()
demo.value = 150
print(demo.value) // 출력: 150

demo.value = 250
print(demo.value) // 출력: 200 (최댓값으로 제한됨)

struct StringDemo {
    @MinMaxVal(min: "Apple", max: "Orange") var value: String = ""
}

var stringDemo = StringDemo()
stringDemo.value = "Banana"
print(stringDemo.value) // 출력: Banana

stringDemo.value = "Pear"
print(stringDemo.value) // 출력: Orange (최댓값으로 제한됨)
