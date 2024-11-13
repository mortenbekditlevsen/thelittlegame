#if os(iOS)
import Foundation
#endif

struct Point: Equatable {
  var x: Int
  var y: Int

  func distance(to other: Point) -> Double {
    let a = (Double(other.x) - Double(x))
    let b = (Double(other.y) - Double(y))
    return sqrt(a * a + b * b)
  }
}

func + (lhs: Point, rhs: Point) -> Point {
  Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

func - (lhs: Point, rhs: Point) -> Point {
  Point(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

struct PointD: Equatable {
    var x: Double
    var y: Double
    
    func distance(to other: PointD) -> Double {
        let a = (Double(other.x) - Double(x))
        let b = (Double(other.y) - Double(y))
        return sqrt(a * a + b * b)
    }
}

func + (lhs: PointD, rhs: PointD) -> PointD {
    PointD(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

func - (lhs: PointD, rhs: PointD) -> PointD {
    PointD(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}
