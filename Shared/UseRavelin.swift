import RavelinEncrypt

struct UseRavelin {
    var encrypt: RVNEncryption

    init(rsaKey: String) {
        encrypt = RVNEncryption.sharedInstance()
        encrypt.rsaKey = rsaKey
    }

    func useEncrypt() {
        // Encrypt customer card details, ready for sending for payment
        var error:NSError? = nil
        let encryptionPayload = encrypt.encrypt("41111111111111", month: "10", year: "27", nameOnCard: "Mr John Doe", error: &error)
        if let error = error {
            print("Ravelin encryption error \(error.localizedDescription)")
        } else {
            print("Ravelin Encryption payload: \(encryptionPayload as AnyObject)")
            // Send to server
        }
    }
}
