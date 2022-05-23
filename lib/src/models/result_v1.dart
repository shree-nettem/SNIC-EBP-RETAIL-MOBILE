class ResultV1<T> {
  ResultV1._();

  factory ResultV1.loading(T msg) = LoadingState<T>;

  factory ResultV1.success(T value) = SuccessState<T>;

  factory ResultV1.error(T msg) = ErrorState<T>;
}

class LoadingState<T> extends ResultV1<T> {
  LoadingState(this.msg) : super._();
  final T msg;
}

class ErrorState<T> extends ResultV1<T> {
  ErrorState(this.msg) : super._();
  final T msg;
}

class SuccessState<T> extends ResultV1<T> {
  SuccessState(this.value) : super._();
  final T value;
}
