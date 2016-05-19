import Foundation

class StringCounter {
    func diffCodeMemoryCharacters(input: [String]) -> Int {
        return input.reduce(0, combine: { (count, line) -> Int in
            let diff = numCodeCharacters(line) - numMemoryCharacters(line)
            return count + diff
        })
    }
}

class FileReader {
    func contentsOfFile(file: String) -> [String] {
        guard let path = NSBundle.mainBundle().pathForResource(file, ofType: "txt") else { return [] }
        
        do {
            let data = try String(contentsOfFile: path)
            return data.componentsSeparatedByString("\n")
        } catch {
            return []
        }
    }
}

// MARK: - Counting Chars
extension StringCounter {
    func numCodeCharacters(input: String) -> Int {
        return input.characters.count
    }
    
    func numMemoryCharacters(input: String) -> Int {
        let size = input.characters.count
        let espacedSize = numEscapedChars(input)
        return size - espacedSize - 2 //2 for first/last "
    }
    
    func numEscapedChars(input: String) -> Int {
        var count = 0
        var escapedPairs = 0
        
        for (i, char) in input.characters.enumerate() {
            //if we've previously escaped a double \\
            //now we just skip the next char (that must
            //be \ again). This way string "\\\\" is 
            //evaluated as "\\" and we have 2 escaped chars
            //and not 4
            if escapedPairs % 2 == 1 {
                escapedPairs += 1
                continue
            }
            
            if char == "\\" {
                let nextChar = input[input.characters.startIndex.advancedBy(i).successor()]
                
                if nextChar == "x" {
                    count += 3
                } else if nextChar == "\\" {
                    escapedPairs += 1
                } else {
                    count += 1
                }
            }
        }
        
        return count + escapedPairs / 2
    }
}