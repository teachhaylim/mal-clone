enum BlocStatus {
  initial,
  loading,
  processing,
  refresh,
  success,
  fail,
  loaded,
  error;

  bool get isInitial => this == BlocStatus.initial;
  bool get isLoading => this == BlocStatus.loading;
  bool get isProcessing => this == BlocStatus.processing;
  bool get isRefresh => this == BlocStatus.refresh;
  bool get isSuccess => this == BlocStatus.success;
  bool get isError => this == BlocStatus.error;
  bool get isLoaded => this == BlocStatus.loaded;
  bool get isFail => this == BlocStatus.fail;
}
