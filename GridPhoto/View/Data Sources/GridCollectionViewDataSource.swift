import UIKit
import RxDataSources

struct GridCellData: IdentifiableType, Equatable {
    var identity: String { return photoURL.absoluteString }
    var photoURL: URL
}

struct SectionOfGridCellData {
    var title: String
    var items: [Item]
}


extension SectionOfGridCellData: AnimatableSectionModelType {
    var identity: String {
        return title
    }
    
    typealias Identity = String
    typealias Item = GridCellData
    
    init(original: SectionOfGridCellData, items: [Item]) {
        self = original
        self.items = items
    }
}
