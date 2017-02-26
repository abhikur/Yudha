struct Cell {
    let index: Int
    
    init(index: Int) {
        self.index = index
    }
}

struct Cells {
    
    var cells = [Cell]()
    
    init() {
        for index in 0...99 {
            self.cells.append(Cell(index: index))
        }
    }
}
