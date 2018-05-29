//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

// Mark -----集合类型协议
//。1.Squence协议

/*
 遍历序列
 for element in some_squence{
    dosomething(with:element)
 }
 满足squence协议 需要提供一个返回迭代器 iterator 的 makeiterator（）方法
 
 */

struct fibInterator : IteratorProtocol {
    typealias Element = Int
    var count : Int
    mutating func next() -> Int? {
        count = count + 2
        if count > 12 {
            return nil
        }else if count == 10{
            return nil
        }else {
            return count
        }
    }
}

struct FIBSquence : Sequence {
    let totalcount : Int
    
    func makeIterator() -> fibInterator {
        return fibInterator.init(count: totalcount)
    }
}

for element in FIBSquence.init(totalcount: 0) {
    print(element)
}

let fibsSequence2 = sequence(state: (0, 1)) {
    // 在这里编译器需要一些类型推断的协助
    (state: inout (Int, Int)) -> Int? in
    let upcomingNumber = state.0
    state = (state.1, state.0 + state.1)
    return upcomingNumber
}
Array(fibsSequence2.prefix(10)) // [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]”

var iterator = fibInterator.init(count: 1)
iterator.next()
iterator.next()
iterator.next()
iterator.next()

var time = "jiushiwi"
let index = time.index(of: "s")
time.index(after: index!)
//time.index(after: 2)
time[..<index!]

let standardIn = AnySequence{
    return AnyIterator{
        readLine()
    }
}

let numberedStdIn = standardIn.enumerated()
for (i, line) in numberedStdIn {
    print("\(i+1): \(line)")
}

/*
 SubSequence 关联类型的声明应该要包括 (a) 其本身也是序列，(b) 子序列的元素类型和其子序列类型，要和原序列中的对应类型一致这两个约束。如果我们加上这些约束，声明看起来会是这样的：
associatedtype SubSequence: Sequence
where Element == SubSequence.Element,
SubSequence.SubSequence == SubSequence
 
 prefix/suffix 获取序列前或后n个元素
 
*/

// indirect

/// 一个简单的链表枚举
enum List<Element> {
    case end
    indirect case node(Element, next: List<Element>)
}

extension List {
    /// 在链表前方添加一个值为 `x` 的节点，并返回这个链表
    func cons(_ x: Element) -> List {
        return .node(x, next: self)
    }
    
   mutating  func pop() -> Element? {
        switch self {
        case .end:
            return nil
        case let .node( x, next:tail) :
            self = tail
            return x
        }
    }
}

extension List: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        elements.reversed().reduce(.end) { (partialList, element) -> List in
            partialList.cons(element)
        }
        self = elements.reversed().reduce(.end) { partialList, element in
            partialList.cons(element)
        }
    }
}


extension List:IteratorProtocol,Sequence {
    
    mutating func next() -> Element? {
        return pop()
    }
    
}


let list2: List = ["3","2","1"]
list2.joined(separator: ",")


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
