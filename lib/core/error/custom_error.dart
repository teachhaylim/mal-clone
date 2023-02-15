class CustomError {
  final int statusCode;
  final String message;

  const CustomError(
      {this.statusCode = -1, this.message = "Something went wrong"});
}
