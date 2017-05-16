import XCTest
@testable import NoDB

class NoDBTests: XCTestCase {
    
    class Foo: Tableable {
        var name: String {
            return "Foo"
        }
        
        var bar1: String?
        var bar2: String?
        
        var propertys: [Property] {
            return [
                Property(key: "bar1", value: bar1, type: .string),
                Property(key: "bar2", value: bar2, type: .string),
            ]
        }
    }
    
    func testCreateSQL() {
        
        XCTAssertEqual(Foo().createSQL,
                       "CREATE TABLE IF NOT EXISTS Foo(id INTEGER PRIMARY KEY AUTOINCREMENT,bar1 TEXT,bar2 TEXT)")
    }

    func testInsertSQL() {
        
        XCTAssertEqual(Foo().updateSQL,
                       "INSERT INTO Foo(bar1,bar2) VALUES(?,?)")
    }

    static var allTests = [
        ("testCreateSQL", testCreateSQL),
        ("testInsertSQL", testInsertSQL)
    ]
}
