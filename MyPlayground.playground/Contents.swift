//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

struct GroceryProduct: Codable {
    var name : String
    var points :Int
    var description :String
    var ability : Ability?
    
    
    struct Ability:Codable {
        var mathematics:Appraise
        var physics:Appraise
        var chemistry:Appraise
    }
    
    enum Appraise:String,Codable {
        
        case excellent ,fine,bad
    }
}

let json =  """
{
    "name": "Durian",
    "points": 600,
    "description": "A fruit with a distinctive scent."
}
""".data(using:.utf8)!

let decoder = JSONDecoder()
let product = try decoder.decode(GroceryProduct.self,from:json)

print(product.name)

// 注意GroceryProduct 结构体需要遵循codeable

let json1 = """
{
    "name": "Durian",
    "points": 600,
    "ability": {
        "mathematics": "excellent",
        "physics": "bad",
        "chemistry": "fine"
    },
    "description": "A fruit with a distinctive scent."
}
""".data(using:.utf8)!

let decoder1 = JSONDecoder()
let product1 = try decoder1.decode(GroceryProduct.self,from:json1)
let ability = product1.ability!
print(ability.mathematics)

let json3 = """
{
    "nick_name": "Tom",
    "points": 600,
}
""".data(using: .utf8)!

//这里 nick_name 我们希望处理成 swift 的风格，那么我们可以使用一个遵循 CodingKey 协议的枚举来做映射。

struct GroceryProduct1: Codable {
    var nickName: String
    var points: Int
    
    enum CodingKeys : String, CodingKey{
        case nickName = "nick_name"
        case points
    }
    //这个方法是个通用方法，不光能够处理 snake case 还能够起自己喜欢的命名，比如你喜欢简写，nick name 写成 nName，那么也可以用这个方法。Codable 协议默认的实现实际上已经能够 cover 掉现实环境的大部分问题了，如果有些自定义的东西要处理的话可以通过覆盖默认 Codable 的方式来做。关键点就是 encoder 的 container，通过获取 container 对象进行自定义操作。
}

let pairsWithDuplicateKeys = [("a", 1), ("b", 2), ("a", 3), ("b", 4)]
let firstValues = Dictionary(pairsWithDuplicateKeys,
                             uniquingKeysWith: { (first, _) in first })
// ["b": 2, "a": 1]
let lastValues = Dictionary(pairsWithDuplicateKeys,
                            uniquingKeysWith: { (_, last) in last })
// ["b": 4, "a": 3]

// 函数
let animals = ["elephant","zebra","dog"]
animals.sorted { (lhs, rhs) -> Bool in
    let l = lhs.reversed()
    let r = rhs.reversed()
    return l.lexicographicallyPrecedes(r)
}

// final 标记不能对该类进行继承或重写
final class Person:NSObject {
    
    let first : String
    @objc let last : String
    let yearOfBirth : Int
    init(first:String,last:String,yearOFBirth:Int) {
        self.first = first
        self.last = last
        self.yearOfBirth = yearOFBirth
    }
}

let people = [
        Person(first: "Emily", last: "Young", yearOFBirth: 2002),
        Person(first: "David", last: "Gray", yearOFBirth: 1991),
        Person(first: "Robert", last: "Barnes", yearOFBirth: 1985),
        Person(first: "Ava", last: "Barnes", yearOFBirth: 2000),
        Person(first: "Joanne", last: "Miller", yearOFBirth: 1994),
        Person(first: "Ava", last: "Barnes", yearOFBirth: 1998)
    ]
let  lastDescriptor = NSSortDescriptor.init(key: #keyPath(Person.last), ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))

(people as NSArray).sortedArray(using: [lastDescriptor])

people.sorted{
    $0.yearOfBirth < $1.yearOfBirth
}

typealias SortDescriptor<Value> = (Value,Value) -> Bool
let sortByYear : SortDescriptor<Person> = {
    $0.yearOfBirth < $1.yearOfBirth
}






