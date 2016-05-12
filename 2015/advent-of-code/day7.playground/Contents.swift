import UIKit

enum Operator: String {
    case AND = "AND"
    case OR = "OR"
    case NOT = "NOT"
    case LSHIFT = "LSHIFT"
    case RSHIFT = "RSHIFT"
}

struct Instruction {
    let leftWire: String?
    let valueOperator: Operator?
    let rightWire: String?
    let outputWire: String

    init(leftValue: String?, operatorValue: String?, rightValue: String?, outputWire: String) {
        self.leftWire = leftValue
        self.rightWire = rightValue
        self.outputWire = outputWire

        if let value = operatorValue {
            self.valueOperator = Operator(rawValue: value)
        } else {
            self.valueOperator = nil
        }
    }
}

func instructionsFrom(input: [String]) -> [Instruction] {
    return input.map { instruction in
        //break into left and right hand side
        guard let resultRange = instruction.rangeOfString("->") else { fatalError() }
        let leftHandSideInput = instruction.substringToIndex(resultRange.startIndex.advancedBy(-1))
        let rightHandSideInput = instruction.substringFromIndex(resultRange.endIndex)
        
        //parse left hand side
        let leftHandSideItems = leftHandSideInput.componentsSeparatedByString(" ")
        var leftWireValue: String?
        var rightWireValue: String?
        var operatorValue: String?
        
        switch leftHandSideItems.count {
        case 1:
            leftWireValue = leftHandSideItems.first
        case 2:
            operatorValue = leftHandSideItems.first
            rightWireValue = leftHandSideItems.last
        case 3:
            leftWireValue = leftHandSideItems[0]
            operatorValue = leftHandSideItems[1]
            rightWireValue = leftHandSideItems[2]
        default:
            fatalError()
        }
        
        return Instruction(leftValue: leftWireValue, operatorValue: operatorValue, rightValue: rightWireValue, outputWire: rightHandSideInput)
    }
    
}

let inputArray = input().characters.split { $0 == "\n"}.map(String.init)
let instructions = instructionsFrom(inputArray)
instructions.count
