//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

// Mark 数组

let fibs = [1,32,3,5,6,6]

var fibs1 = [1,3,4,5,6]
fibs1 .append(0)
fibs1.append(contentsOf: [9])
fibs1.append(0)

// 数组是值类型 x赋值给y其实是拷贝了一份新值给y y改变 x不变
var x = [1,3,4,5]
var y = x
y.append(contentsOf: [4,5])
x

let a = NSMutableArray(array:[2,4,5])
let b:NSArray = a.copy() as! NSArray
a.add(0)
b

let c = 5
a.index(of: 5)


let d = x.map { (n) in
    n*n
}
d

extension Array {
    
    func map<T>(_ transform:(Element)->T) -> [T] {
        var resultArr : [T] = []
        for t in self {
            resultArr.append(transform(t))
        }
        return resultArr
    }
    
    func map2<T>(_ transform:(Element) -> T) -> [T] {
        return self.reduce([], {
            $0 + [transform($1)]
        })
        
    }
    
    func filter(_ transform:(Element) -> Bool) -> [Element] {
        var resultArr:[Element] = []
        for item in self {
            if transform(item) {
                resultArr.append(item)
            }
        }
        return resultArr;
    }
    
    func filter2(_ transform:(Element) -> Bool) -> [Element] {
        return reduce([], {
            transform($1) ? ($0 + [$1]) : $0
        })
        
    }

    // 集合通过某一条件合并
    func reduce<T>(_ initialResult:T,_ transform:(Element,_ B:T) -> T) -> T {
        
        var result : T = initialResult
        for item in self {
           result = transform(item,result)
        }
        return result
    }
    
 
    
    // 累加 合并集合中的元素 并保留每一步的值
    func accumulate<T>(_ initialResult:T,_ transform:(Element,_ B:T) -> T) ->  [T]{
    var result : T = initialResult
    var resultArr : [T] = []
    for item in self{
        resultArr.append(transform(item,result))
    }
        return map({ (x) -> T in
           result = transform(x,result)
            return result
        })
    }
    // 逆序数组寻找第一个满足特定条件的元素
    func last(_ transform:(Element) -> Bool) -> Element? {
        
        for item in self.reversed() {
            if transform(item) {
                return item
            }
        }
        return nil
    }
    
    
}

let arr = [1,2,3]
let count = arr.reduce(0, +)

// 筛选
x.filter { (n) -> Bool in
    n>2
}

// 产生新的集合
x.map { (n)  in
  return  n/2
}

let name = ["dfd","vfvf","qwe","asd"]

// 0～100内同时满足是偶数并且是其平方的数
let filtArr = (1..<10).map{$0 * $0}.filter{$0%2==0}
filtArr

filtArr.contains { (item) -> Bool in
    item > 5
}


extension Array {
    func filter1(_ filterFunc:(Element) -> Bool) -> [Element]{
        var resultArr:[Element] = []
        for item in self {
            if filterFunc(item) {
                resultArr.append(item)
                }
        }
        return resultArr
    }
    
    // 判断数组是否全部满足某一个条件
    func all(matching predicate:(Element) -> Bool) -> Bool {
        
        return !contains{item -> Bool in !predicate(item)}
    }
}

filtArr.all { (item) -> Bool in
    item > 6
}  // true


filtArr.contains { (item) -> Bool in
    item < 6
}  // true


filtArr + [8]  // [4,16,36,64,8]

let catArr = [1,3,4,54,6,7]
let flatArr = catArr.flatMap { (item)  in
    (item,item)
}
flatArr

// Mark 字典

enum Setting {
    case text(String)
    case bool(Bool)
    case int (Int)
}

let defaultString:[String:Setting] = [
    "a":Setting.text("hh"),
    "b":Setting.bool(false)
]

defaultString["a"]
defaultString["c"]
// 和数组不同 字典使用下标获取值如果没有会返回空nil 数组直接会报错
var changeString = defaultString
changeString["d"] = .text("jiji")

changeString  // a b c
defaultString // a b


let oldname = changeString.updateValue(.int(5), forKey: "a")// 返回当前键值在更新数据之前对应的值 没有则返回nil

var oldDict:[String:Setting] = ["a":.text("haha"),"f":.int(9)]
var newDict:[String:Setting] = ["a":.text("jiji "),"f":.int(0)]

// 合并字典
let valueDict = oldDict.merging(newDict) { (string, setting) -> Setting in
    if case let Setting.text( _ ) = setting{
      return  Setting.text("koko")
    }else if case let Setting.int(order) = setting{
     return   Setting.int(6)
    }else {
     return   Setting.int(9)
    }
}

// 保存字典的结构 只对值映射
let settingValues = changeString.mapValues { setting -> String in
    switch setting {
    case .text(let test):
        return test
    case .int(let number):
        return String(number)
    case .bool(let value):
        return String(value)
    }
}

// Mark - set
let iPods: Set = ["iPod touch", "iPod nano", "iPod mini",
"iPod shuffle", "iPod Classic"]
let discontinuedIPods: Set = ["iPod mini", "iPod Classic",
                              "iPod nano", "iPod shuffle"]
let currentIPods = iPods.subtracting(discontinuedIPods) // ["iPod touch"]”


// “我们如果想要为 Sequence 写一个扩展，来获取序列中所有的唯一元素”
extension Sequence where Element:Hashable {
    
    func unique() -> [Element] {
        
        var set:Set<Element> = []
        return self.filter({ element in
            if set.contains(element){
                return false
            }else{
                set.insert(element)
                return true
            }
        })
    }
}

let fronValue = 0...






class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(label)
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
