import Quick
import Nimble

class Day7Specs: QuickSpec {
    override func spec() {
        var sut: Day7!
        
        beforeEach { 
            sut = Day7()
        }
        
        describe("Given Day7 task") { 
            describe("when transfering input to instructions (domain)", {
                it("should read from file", closure: {
                    let results = sut.readInput("day7")
                    expect(results.count).to(equal(339))
                    
                    if let first = results.first,
                        let last = results.last {
                        expect(first).to(equal("lf AND lq -> ls"))
                        expect(last).to(equal("he RSHIFT 5 -> hh"))
                    }
                })
                
                it("should map input to instructions", closure: { 
                    let input = ["123 -> x", "x AND y -> d", "x OR y -> e", "x LSHIFT 2 -> f", "y RSHIFT 2 -> g", "NOT x -> h"]
                    let result = sut.parseInstructions(input: input)
                    
                    expect(result.count).to(equal(6))
                })
            })
        }
    }
}
