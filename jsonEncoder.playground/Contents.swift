//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport


struct GroceryProduct: Codable {
    var name : String
    var points :Int
    var description :String
    var ability : Ability
    
    
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
print(product1.name)



