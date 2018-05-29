//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


// 构建一种在字符串中迭代单词的方式
var string = "still i see monsters"
//string.split(separator: " ") // 返回substring类型其实就是string 所关联的subsequence类型

var dropstring = string.drop(while: {$0 == " "})
dropstring

print(dropstring)
extension Substring {
    
    var nextWordRange:Range <Index >{
        let start = drop(while:{$0 == " "})
        let end = start.index(where: {
            $0 == " "
        }) ?? endIndex
        return start.startIndex..<end
    }
}

print(dropstring.nextWordRange.lowerBound)

// 即使在使用证书索引时一个集合的索引也并不是需要从0 开始
let cities = ["new york","rio","london","belin"]

let slice = cities[2...3]

slice.startIndex
cities.startIndex

// 可选值
enum Optional<Wrapped> {
    case none
    case some(Wrapped)
}
var array = ["one", "two", "three"]
let idx = array.index(of: "four")
switch array.index(of: "four"){
case .some(let idx):
    array.remove(at: idx)
case .none:
    break
}

// 可选绑定
if let idx = array.index(of:"four"){
    array.remove(at: idx)
}

for i in 0..<10 where i % 2 == 0 {
    print(i, terminator: " ")
} // 0 2 4 6 8
//“可选值是值类型，解包一个可选值做的事情是将它里面的值复制出来。”


let persons : Array<Int> = [1,2,3,4,5,5]

guard let i = persons.first else {
    fatalError()
}
persons.first
persons.index(after: 4)

var iterator = persons.makeIterator()
while let mayneint = iterator.next(){
    print(mayneint)
}

for case let x？ in persons {
    print(x？)
}

// case 匹配可以通过重载～=运算符进行扩展
struct Pattern {
    let s:String
    init(_ s:String) {
        self.s = s
    }
}

func ~=(pattern:Pattern,value:String) -> Bool {
    return value.range(of: pattern.s) != nil
}

let s = "taylor swift"
if case Pattern("swift") = s {
    print("\(String(reflecting: s)) contains")
}

// 可选绑定 是如果是值类型对值得拷贝

var a: Int? = 5
a? = 10
a // Optional(10)
var b: Int? = nil
b? = 10
b // nil”
// 注意“a = 10 和 a? = 10 的细微不同。前一种写法无条件地将一个新值赋给变量，而后一种写法只在 a 的值在赋值发生前不是 nil 的时候才生效。

var dictWithNils: [String: Int?] = [
    "one": 1,
    "two": 2,
    "none": nil
]

dictWithNils["two"] = nil
dictWithNils

dictWithNils["one"]? = nil
dictWithNils

let w:[Int?] = [1,2,nil]
let e:[Int?] = [1,2,nil]

//w==e

func ==<T:Equatable>(lhs:[T?],rhs:[T?]) -> Bool {
    return lhs.elementsEqual(rhs){$0 == $1}
}

w == e

// 编译错误：remove(at:) 接受 Int，而不是 Optional<Int>
//array.remove(at: idx)



struct point {
    var x:Int{
        didSet{
            print("xiugfaix")
        }
        
    }
    var y:Int{
        didSet{
            print("xiugfaiy")
        }
        
    }
    
}

struct size {
    var w:Int{
        didSet{
            print("xiugfaiw")
        }
        
    }
    var h:Int{
        didSet{
            print("xiugfaih")
        }
        
    }
    
}

struct frame {
    
    var point:point{
        didSet{
            print("point")
        }
        
    }
    var size:size
    
}

var screen = frame.init(point: point.init(x: 0, y: 0), size: size.init(w: 10, h: 10))
screen.point.x = 10
screen.point = point.init(x: 30, y: 40)


// “可以使用 isKnownUniquelyReferenced 函数来检查某个引用只有一个持有者”
final class Box<A> {
    var unbox: A
    init(_ value: A) { self.unbox = value }
}
var x = Box(NSMutableData())
isKnownUniquelyReferenced(&x) // true”

var y = x
isKnownUniquelyReferenced(&y)

var q = 0
func uniquenInteger() -> Int {
    q += 1
    return q;
}

uniquenInteger()
uniquenInteger()


struct cooradine : Codable {
    var lng:Double
    var lat:Double

}

struct place : Codable {
    var name : String
    var coor :cooradine
    
}

let jsonEncode = JSONEncoder()

let data = try jsonEncode.encode([
    place.init(name: "1", coor: cooradine.init(lng: 5, lat: 9)),
    place.init(name: "1", coor: cooradine.init(lng: 5, lat: 9)),
    ])

let json = String.init(data: data, encoding: .utf8)

guard let cjson = json else {
    fatalError()
}

print(cjson)


let decode = JSONDecoder()
let jsondata = cjson.data(using: .utf8)

if let jsondatata = jsondata    {
    let data = try decode.decode([place].self, from: jsondatata)
}












