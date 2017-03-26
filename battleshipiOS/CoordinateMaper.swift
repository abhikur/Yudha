class CoordinateMaper {
    
    private let alphaNumericMap: [String: String] = ["0": "A", "1": "B", "2": "C", "3": "D", "4": "E", "5": "F", "6": "G", "7": "H", "8": "I", "9": "J"]
    
    func mapToAlpha(numericCoord coord: String) -> String {
        let splitedValue = coord.split()
        return "\(numToAlpha(splitedValue.first!))\(splitedValue[1])"
    }

    func mapToNumeric(alphaCoord coord: String) -> [Int] {
        let splitedValue = coord.split()
        return "\(alphaToNum(splitedValue.first!))\(splitedValue[1])".splitIntoInt()
    }
 
    func alphaToNum(_ alpha: String) -> String {
        let index = alphaNumericMap.index { (key, value) -> Bool in
            return value == alpha
        }
        if let i = index as? DictionaryIndex<String, String>? {
            return "\(alphaNumericMap[i!].key)"
        }
        return ""
    }
    
    func numToAlpha(_ num: String) -> String {
        return alphaNumericMap[num]!
    }
}

extension String {
    
    func split() -> [String] {
        return self.characters.map({ (char) -> String in
            return char.description
        })
    }
    
    func splitIntoInt() -> [Int] {
        var nums: [Int] = self.characters.map({
            return Int($0.description)!
        })
        if nums.count == 1 {
            nums.append(0)
            nums.reverse()
        }
        return nums
    }
}
