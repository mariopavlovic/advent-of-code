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
    
    var outputs: [String : UInt16] = [:]
    
    func runCircut(resultOnWire resultOnWire: String, filePath: String) -> UInt16 {
        let fileInput = readInput(filePath)
        return outputSignal(onWire: resultOnWire, input: fileInput)
    }
}

// MARK: - Finding value in a circuit
extension Day7 {
    func outputSignal(onWire onWire: String, input: [String]) -> UInt16 {
        let model = parseInstructions(input: input)
        return outputValue(onWire: onWire, model: model)
    }
    
    func outputValue(onWire onWire: String, model: [Instruction]) -> UInt16 {
        //check if it has it first
        if let output = outputs[onWire] {
            return output
        }
        
        //find desired wire
        guard let resultWireInstruction = (model.filter { instruction in
            return instruction.outputWire == onWire
            }.first) else { return 0 }
        
        //check what kind of inputs we have (values or wires)
        var leftInput: UInt16
        if UInt16(resultWireInstruction.leftWire) == nil {
            leftInput = outputValue(onWire: resultWireInstruction.leftWire, model: model)
        } else {
            leftInput = UInt16(resultWireInstruction.leftWire)!
        }
        
        var rightInput: UInt16
        if UInt16(resultWireInstruction.rightWire) == nil {
            rightInput = outputValue(onWire: resultWireInstruction.rightWire, model: model)
        } else {
            rightInput = UInt16(resultWireInstruction.rightWire)!
        }
        
        var result: UInt16
        switch resultWireInstruction.operation {
        case .AND:
            result = leftInput & rightInput
        case .OR:
            result = leftInput | rightInput
        case .NOT:
            result = ~rightInput
        case .LSHIFT:
            result = leftInput << rightInput
        case .RSHIFT:
            result = leftInput >> rightInput
        }
        
        //store and return
        outputs[onWire] = result
        return result
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