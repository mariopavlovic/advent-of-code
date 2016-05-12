import Foundation

class Day7 {
    enum Gate: String {
        case AND = "AND"
        case OR = "OR"
        case NOT = "NOT"
        case RSHIFT = "RSHIFT"
        case LSHIFT = "LSHIFT"
    }
    
    struct Instruction {
        var leftWire: String
        var rightWire: String
        var operation: Gate
        var outputWire: String
        
        init() {
            leftWire = ""
            rightWire = ""
            operation = .AND
            outputWire = ""
        }
    }
}

// MARK: - File input
extension Day7 {
    func readInput(localPath: String) -> [String] {
        guard let path = NSBundle.mainBundle().pathForResource(localPath, ofType: "txt"),
            let fileContent = try? NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding) else { return [] }
        
        return fileContent.componentsSeparatedByString("\n")
    }
}

// MARK: - Parsing input
extension Day7 {
    func parseInstructions(input input: [String]) -> [Instruction] {
        return input.map { line in
            var instruction = Instruction()
            
            let parts = line.componentsSeparatedByString(" ")
            if let index = parts.indexOf("->") {
                let leftPart = parts[0 ..< index]
                
                switch leftPart.count {
                case 1:
                    instruction.operation = .AND
                    instruction.leftWire = leftPart[0]
                    instruction.rightWire = leftPart[0]
                case 2:
                    instruction.operation = .NOT
                    instruction.leftWire = leftPart[1]
                    instruction.rightWire = leftPart[1]
                case 3:
                    instruction.leftWire = leftPart[0]
                    instruction.operation = Gate(rawValue: leftPart[1])!
                    instruction.rightWire = leftPart[2]
                default:
                    //report error
                    print("Reached non-logical part")
                }
            }
            
            instruction.outputWire = parts.last ?? ""
            
            return instruction
        }
    }
}