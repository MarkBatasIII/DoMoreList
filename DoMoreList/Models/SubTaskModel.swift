import Foundation

import Foundation

struct SubTaskModel: Identifiable, Codable {
    let id: String
    var subTask: String
    var isSubCompleted: Bool

    init(
        id: String = UUID().uuidString,
        subTask: String,
        isSubCompleted: Bool
    ) {
        self.id = id
        self.subTask = subTask
        self.isSubCompleted = isSubCompleted
    }
}
