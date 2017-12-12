import Foundation

// md5 extension provided by /u/superezfe
extension String  {
    var md5: String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.deallocate(capacity: digestLen)
        
        return String(format: hash as String)
    }
}

// Problem implementation by Evan starts here:

extension String {
	subscript (i: Int) -> Character {
    	return self[index(startIndex, offsetBy: i)]
  	}
}

func isCoin( input: String, zeroLength: Int = 5 ) -> Bool {
	var pref: String = ""
	for _ in 1...zeroLength {
		pref = pref + "0"
	}
	return input.hasPrefix( pref )
}

func hash( key: String, number: Int ) -> String {
	return ( key + String(number) ).md5
}

func findNumber( key: String, zeroLength: Int = 5, startAt: Int = 0 ) -> Int {
	var count = startAt
	while true {
		if( isCoin( input: hash( key: key, number: count ), zeroLength: zeroLength ) ) {
			return count 
		}
		else {
			count = count + 1
		}
	}
}

func testFind( key: String, number: Int, zeroLength: Int = 5 ) -> Bool {
	return ( findNumber( key: key, zeroLength: zeroLength ) == number )
}

print( findNumber( key: "iwrupvqb", zeroLength: 6, startAt: 9900000 ) )
