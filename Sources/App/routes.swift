import Fluent
import Vapor

class Repository {
    static let shared = Repository()
    var renameCounter = [String: Int]()    
}


func routes(_ app: Application) throws {
    app.get { req async in
        "hellowww worldd!"
    }
    
    // REST API to return probability of catching a Pokemon
    app.get("catch") { req -> BooleanResponse in
        let random = Double.random(in: 0..<1)
        return BooleanResponse(message: random < 0.5)
    }
    
    // REST API to release a Pokemon
    app.get("prime") { req -> IntegerResponse in
        let randomNumber = Int.random(in: 1...100)
        return IntegerResponse(message: randomNumber)
    }
    
    
    // REST API to rename a Pokemon
    app.put("rename") { req -> StringResponse in
        guard let name = try? req.query.get(String.self, at: "name") else {
            throw Abort(.badRequest)
        }
        var newName = ""
        
        var splitted = name.components(separatedBy: "-")
        
        //if last is a number, delete last row of splitted
        if
            let last = splitted.last,
            let _ = Int(last)
        {
            splitted.removeLast()
            let baseName = splitted.joined(separator: "-")
            newName = "\(baseName)-\(fibonacci(for: baseName))"
        }
        else {
            newName = "\(name)-\(fibonacci(for: name))"
        }
        
        return StringResponse(message: newName)
    }
}

// Function to calculate Fibonacci number
func fibonacci(for name: String) -> Int {
    let count = Repository.shared.renameCounter[name] ?? 0
    
    var a = 0, b = 1, n = count
    while(n > 0) {
        let temp = a
        a = b
        b = temp + b
        n -= 1
    }
    
    Repository.shared.renameCounter[name] = count + 1
    
    return a
}
