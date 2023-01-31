abstract class UseCase<Result, Parameters extends UseCaseParameters> {
  Result call(Parameters params);
}

abstract class UseCaseParameters {
  const UseCaseParameters();
}
