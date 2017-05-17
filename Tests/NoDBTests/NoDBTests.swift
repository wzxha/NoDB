import XCTest
@testable import NoDB

class NoDBTests: XCTestCase {
    
    class Foo: Tableable {
        init() {}
        
        required init(_ dictionary: [String : Any?]) {
            bar1 = dictionary["bar1"] as? String
            bar2 = dictionary["bar2"] as? String
        }

        var _id: Int?

        static var name: String {
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
                       "CREATE TABLE IF NOT EXISTS Foo(_id INTEGER PRIMARY KEY AUTOINCREMENT,bar1 TEXT,bar2 TEXT)")
    }

    func testInsertSQL() {
        
        XCTAssertEqual(Foo().insertSQL,
                       "INSERT INTO Foo(bar1,bar2) VALUES(?,?)")
    }

    func testFetchSQL() {
        
        XCTAssertEqual(Foo().fetchSQL,
                       "SELECT * FROM Foo")
        
        let foo1 = Foo()
        foo1.bar1 = "bar"
        
        XCTAssertEqual(foo1.fetchSQL,
                       "SELECT * FROM Foo WHERE bar1=?")
        
        let foo2 = Foo()
        foo2.bar2 = "bar"
        XCTAssertEqual(foo2.fetchSQL,
                       "SELECT * FROM Foo WHERE bar2=?")
        
        let foo3 = Foo()
        foo3.bar1 = "bar"
        foo3.bar2 = "bar"
        XCTAssertEqual(foo3.fetchSQL,
                       "SELECT * FROM Foo WHERE bar1=? AND bar2=?")
    }
    
    func testDeleteSQL() {
        
        XCTAssertEqual(Foo().deleteSQL,
                       "DELETE FROM Foo")
        
        let foo1 = Foo()
        foo1.bar1 = "bar"
        
        XCTAssertEqual(foo1.deleteSQL,
                       "DELETE FROM Foo WHERE bar1=?")
        
        let foo2 = Foo()
        foo2.bar2 = "bar"
        XCTAssertEqual(foo2.deleteSQL,
                       "DELETE FROM Foo WHERE bar2=?")
        
        let foo3 = Foo()
        foo3.bar1 = "bar"
        foo3.bar2 = "bar"
        XCTAssertEqual(foo3.deleteSQL,
                       "DELETE FROM Foo WHERE bar1=? AND bar2=?")
    }
    
    func testUpdateSQL() {
        let foo1 = Foo()
        foo1._id = 0
        
        XCTAssertEqual(foo1.updateSQL,
                       "UPDATE Foo WHERE _id=0")
        
        let foo2 = Foo()
        foo2._id = 0
        foo2.bar1 = "bar"
        
        XCTAssertEqual(foo2.updateSQL,
                       "UPDATE Foo SET bar1=? WHERE _id=0")
        
        let foo3 = Foo()
        foo3._id = 0
        foo3.bar2 = "bar"
        XCTAssertEqual(foo3.updateSQL,
                       "UPDATE Foo SET bar2=? WHERE _id=0")
        
        let foo4 = Foo()
        foo4._id = 0
        foo4.bar1 = "bar"
        foo4.bar2 = "bar"
        XCTAssertEqual(foo4.updateSQL,
                       "UPDATE Foo SET bar1=? AND bar2=? WHERE _id=0")
    }

    
    func testValue() {
        let foo1 = Foo()
        XCTAssert(foo1.values?.count == 0)
        
        let foo2 = Foo()
        foo2.bar1 = "bar"
        
        XCTAssert((foo2.values as! [String]) == ["bar"])
        
        let foo3 = Foo()
        foo3.bar2 = "bar"
        XCTAssert((foo3.values as! [String]) == ["bar"])
        
        let foo4 = Foo()
        foo4.bar1 = "bar"
        foo4.bar2 = "bar"
        XCTAssert((foo4.values as! [String]) == ["bar", "bar"])
        
    }
    
    static var allTests = [
        ("testCreateSQL", testCreateSQL),
        ("testInsertSQL", testInsertSQL),
        ("testFetchSQL", testFetchSQL),
        ("testDeleteSQL", testDeleteSQL),
        ("testUpdateSQL", testUpdateSQL),
        
        ("testValue", testValue)
    ]
}
