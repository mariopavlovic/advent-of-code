import Quick
import Nimble
@testable import advent_of_code


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
                    
                    let first = result.first!
                    expect(first.leftWire).to(equal("123"))
                    expect(first.outputWire).to(equal("x"))
                    
                    let last = result.last!
                    expect(last.rightWire).to(equal("x"))
                    expect(last.outputWire).to(equal("h"))
                })
            })
            
            describe("when running single operation systems", { 
                it("should work correctly on direct value", closure: {
                    var instruction = Day7.Instruction()
                    instruction.leftWire = "3"
                    instruction.operation = .AND
                    instruction.rightWire = "3"
                    instruction.outputWire = "x"
                    
                    let result = sut.outputValue(onWire: "x", model: [instruction])
                    expect(result).to(equal(3))
                })
                
                it("should work correctly on AND operation", closure: {
                    var instruction = Day7.Instruction()
                    instruction.leftWire = "123"
                    instruction.operation = .AND
                    instruction.rightWire = "456"
                    instruction.outputWire = "x"
                    
                    let result = sut.outputValue(onWire: "x", model: [instruction])
                    expect(result).to(equal(72))
                })

                it("should work correctly on OR operation", closure: {
                    var instruction = Day7.Instruction()
                    instruction.leftWire = "123"
                    instruction.operation = .OR
                    instruction.rightWire = "456"
                    instruction.outputWire = "x"
                    
                    let result = sut.outputValue(onWire: "x", model: [instruction])
                    expect(result).to(equal(507))
                })

                it("should work correctly on LSHIFT operation", closure: {
                    var instruction = Day7.Instruction()
                    instruction.leftWire = "123"
                    instruction.operation = .LSHIFT
                    instruction.rightWire = "2"
                    instruction.outputWire = "x"
                    
                    let result = sut.outputValue(onWire: "x", model: [instruction])
                    expect(result).to(equal(492))
                })

                it("should work correctly on RSHIFT operation", closure: {
                    var instruction = Day7.Instruction()
                    instruction.leftWire = "456"
                    instruction.operation = .RSHIFT
                    instruction.rightWire = "2"
                    instruction.outputWire = "x"
                    
                    let result = sut.outputValue(onWire: "x", model: [instruction])
                    expect(result).to(equal(114))
                })

                it("should work correctly on NOT operation", closure: {
                    var instruction = Day7.Instruction()
                    instruction.operation = .NOT
                    instruction.rightWire = "123"
                    instruction.outputWire = "x"
                    
                    let result = sut.outputValue(onWire: "x", model: [instruction])
                    expect(result).to(equal(65412))
                })
            })
            
            describe("when running the circuit", { 
                it("should give wire output value for desired wire", closure: { 
                    let input = ["123 -> x", "456 -> y", "x AND y -> d", "x OR y -> e", "x LSHIFT 2 -> f", "y RSHIFT 2 -> g", "NOT x -> h", "NOT y -> i"]
                    let d = sut.outputSignal(onWire: "d", input: input)
                    let e = sut.outputSignal(onWire: "e", input: input)
                    let f = sut.outputSignal(onWire: "f", input: input)
                    let g = sut.outputSignal(onWire: "g", input: input)
                    let h = sut.outputSignal(onWire: "h", input: input)
                    let i = sut.outputSignal(onWire: "i", input: input)
                    let x = sut.outputSignal(onWire: "x", input: input)
                    let y = sut.outputSignal(onWire: "y", input: input)
                    
                    expect(d).to(equal(72))
                    expect(e).to(equal(507))
                    expect(f).to(equal(492))
                    expect(g).to(equal(114))
                    expect(h).to(equal(65412))
                    expect(i).to(equal(65079))
                    expect(x).to(equal(123))
                    expect(y).to(equal(456))
                })
                
                it("should find a solution for day 7 tasks - part 1", closure: {
                    let result = sut.runCircut(resultOnWire: "a", filePath: "day7")
                    expect(result).to(equal(16076))
                })
                
                it("should find a solution for day 7 tasks - part 2", closure: {
                    let result = sut.runCircut(resultOnWire: "a", filePath: "day7-part2")
                    expect(result).to(equal(2797))
                })

            })
        }
    }
}
