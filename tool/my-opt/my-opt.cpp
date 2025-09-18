#include "myproject/Dialect/MyDialect/IR/MyDialect.h"
#include "mlir/InitAllDialects.h"
#include "mlir/Tools/mlir-opt/MlirOptMain.h"

int main(int argc, char *argv[]) {
  mlir::DialectRegistry registry;

  mlir::registerAllDialects(registry);
  registry.insert<mlir::mydialect::MyDialectDialect>();

  return mlir::asMainReturnCode(
      mlir::MlirOptMain(argc, argv, "Optimizer driver\n", registry));
}
