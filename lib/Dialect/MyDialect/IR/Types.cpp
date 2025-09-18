#include "myproject/Dialect/MyDialect/IR/Types.h"
#include "myproject/Dialect/MyDialect/IR/MyDialect.h"
#include "llvm/ADT/TypeSwitch.h"
#include "mlir/IR/DialectImplementation.h"

using namespace ::mlir::mydialect;

#define GET_TYPEDEF_CLASSES
#include "myproject/Dialect/MyDialect/IR/MyDialectTypes.cpp.inc"
