var index: Int?
index = 3

var treeArray = ["Oak", "Apple", "Banana", "Birch"]

if index != nil {
    print(treeArray[index!]) // 강제 언래핑
} else {
    print("값이 할당되지 않았을때")
}
// if let index = index => 축약해서 사용 가능
if let index {
    // 이 중괄호 안에서는 옵셔널이 아닌 Int 타입으로 사용 가능
    print(treeArray[index])
}

var optionalName1: String?
var optionalName2: String?
var optionalName3: String?

optionalName1 = "Swift"
optionalName2 = "Programming"
optionalName3 = "Language"

if let name1 = optionalName1,
   let name2 = optionalName2,
   let name3 = optionalName3 {
    print("\(name1) \(name2) \(name3)")
}

var myDictionary = Dictionary<String, Int>()
myDictionary["Swift"] = 100
myDictionary["Programming"] = 200
myDictionary["Language"] = 300

print(myDictionary["C++"] ?? (3+2))

if let value  = myDictionary["Swift"] {
    print(value)
}
else {
    print(0)
}

let value = myDictionary["Swift"] as! Int
print(value)

let myButton: UIButton = UIButton()
let myControl = myButton as UIControl

let myScrollView -> UITextView
let myScrollView: UIScrollView = UIScrollView()

if let myTextView = myScrollView as? UItextView {
    print(myTextView.text ?? "")
    
}
else {
    print("UITextView 로 타입 캐스팅하지 못했습니다.")
}
