import Firebase
import FirebaseFirestore

struct Expense: Identifiable, Hashable {
    var id = UUID().uuidString
    var description: String
    var amount: Double
    var date: Date
    var type: ExpenseType
    var color: String
    
    private var expensesCollection: CollectionReference {
        return Firestore.firestore().collection("expenses")
    }
    
    init(description: String, amount: Double, date: Date, type: ExpenseType, color: String) {
        self.description = description
        self.amount = amount
        self.date = date
        self.type = type
        self.color = color
    }
    
    init(id: String, description: String, amount: Double, date: Date, type: ExpenseType, color: String) {
        self.id = id
        self.description = description
        self.amount = amount
        self.date = date
        self.type = type
        self.color = color
    }
    
    func save() {
        let expenseData: [String: Any] = [
            "description": description,
            "amount": amount,
            "date": Timestamp(date: date),
            "type": type.rawValue,
            "color": color
        ]
        
        expensesCollection.addDocument(data: expenseData)
    }
    
    static func fetchAll(completion: @escaping ([Expense]) -> Void) {
        Firestore.firestore().collection("expenses").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching expenses: \(error)")
                completion([])
                return
            }
            
            guard let snapshot = snapshot else {
                print("Error fetching expenses: unknown error")
                completion([])
                return
            }
            
            let expenses = snapshot.documents.compactMap { document -> Expense? in
                guard let description = document.get("description") as? String,
                      let amount = document.get("amount") as? Double,
                      let dateTimestamp = document.get("date") as? Timestamp,
                      let typeString = document.get("type") as? String,
                      let type = ExpenseType(rawValue: typeString),
                      let color = document.get("color") as? String
                else {
                    return nil
                }
                
                let expense = Expense(
                    id: document.documentID,
                    description: description,
                    amount: amount,
                    date: dateTimestamp.dateValue(),
                    type: type,
                    color: color
                )
                
                return expense
            }
            
            completion(expenses)
        }
    }
}

enum ExpenseType: String, Codable {
    case income = "Income"
    case expense = "Expense"
    case all = "All"
}
