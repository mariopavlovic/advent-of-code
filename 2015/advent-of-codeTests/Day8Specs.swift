import Quick
import Nimble
@testable import advent_of_code

class Day8Specs: QuickSpec {
    override func spec() {
        var sut: StringCounter!
        var fileReader: FileReader!
        
        beforeEach { 
            sut = StringCounter()
            fileReader = FileReader()
        }
        
        describe("Given StringCounter") { 
            describe("when counting characters of code", { 
                it("should count correctly for string in file input", closure: {
                    let strings = fileReader.contentsOfFile("day8")
                    let first = strings[0]
                    expect(sut.numCodeCharacters(first)).to(equal(38))
                })
            })
            
            describe("when counting characters in memory", {
                it("should count correctly for string in file input", closure: {
                    let strings = fileReader.contentsOfFile("day8")
                    let first = strings[0]
                    expect(sut.numMemoryCharacters(first)).to(equal(29))
                })
            })
            
            describe("when counting diff code/memory characters", { 
                it("should count correctly", closure: { 
                    let input = fileReader.contentsOfFile("day8")
                    let result = sut.diffCodeMemoryCharacters(input)
                    expect(result).to(equal(0))
                })
            })
        }
        
        describe("Given FileReader") {
            describe("when reading contents of a file", {
                it("should read correctly", closure: {
                    let result = fileReader.contentsOfFile("day8")
                    expect(result).to(haveCount(300))
                })
            })
        }

    }
}
