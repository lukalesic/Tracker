import Firebase
import FirebaseFirestore

struct Saving: Identifiable, Hashable {
    var id = UUID().uuidString
    var amount: Double
    var date: Date
    
    private var savingsCollection: CollectionReference {
        return Firestore.firestore().collection("savings")
    }
    
    init(amount: Double, date: Date) {
        self.amount = amount
        self.date = date
    }
    
    init(id: String, amount: Double, date: Date) {
        self.id = id
        self.amount = amount
        self.date = date
    }
    
    func save() {
        let savingData: [String: Any] = [
            "amount": amount,
            "date": Timestamp(date: date)
        ]
        
        savingsCollection.addDocument(data: savingData)
    }
    
    static func fetchAll(completion: @escaping ([Saving]) -> Void) {
        Firestore.firestore().collection("savings").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching savings: \(error)")
                completion([])
                return
            }
            
            guard let snapshot = snapshot else {
                print("Error fetching savings: unknown error")
                completion([])
                return
            }
            
            let savings = snapshot.documents.compactMap { document -> Saving? in
                guard let amount = document.get("amount") as? Double,
                      let dateTimestamp = document.get("date") as? Timestamp
                else {
                    return nil
                }
                
                let saving = Saving(
                    id: document.documentID,
                    amount: amount,
                    date: dateTimestamp.dateValue()
                )
                
                return saving
            }
            
            completion(savings)
        }
    }
}
