#include "myproject/Dialect/MyDialect/IR/MyDialect.h"

using namespace ::mlir::mydialect;

#include "myproject/Dialect/MyDialect/IR/MyDialect.cpp.inc"

namespace mlir::mydialect {
void MyDialectDialect::initialize() {
  addTypes<
#define GET_TYPEDEF_LIST
#include "myproject/Dialect/MyDialect/IR/MyDialectTypes.cpp.inc"
  >();
}
} // namespace mlir::mydialect
