import Foundation

class Day4 {
    
    //input "yzbqklnj"
    func mineCoins(input: String) -> String {
        var index = 0
        var result: NSData
        repeat {
            result = md5("\(input)\(index)")
            index += 1
        } while !result.description.hasPrefix("<000000")
        
        print("Result is \(result), for index \(index - 1)")
        return "\(result)"
    }
    
    func md5(string: String) -> NSData {
        let digest = NSMutableData(length: Int(CC_MD5_DIGEST_LENGTH))!
        if let data :NSData = string.dataUsingEncoding(NSUTF8StringEncoding) {
            CC_MD5(data.bytes, CC_LONG(data.length),
                   UnsafeMutablePointer<UInt8>(digest.mutableBytes))
        }
        return digest
    }
}