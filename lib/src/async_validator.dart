/// A utility class for handling asynchronous form field validations.
///
/// Standard `TextFormField.validator` only supports synchronous functions.
/// To support asynchronous validation (e.g. checking if an email is already registered via an API request),
/// use this debounced or manually awaited wrapper logic in your UI state or custom form field.
///
/// Note: Since Form fields natively require `String? function(String?)`, true async validation
/// must be managed via focus changes or submit buttons. We provide this class to help map the logic.
class AsyncValidator {
  /// A simple runner that awaits an asynchronous validation logic.
  /// Usage depends on integrating this into a debounced text field listener
  /// or triggering on submit.
  static Future<String?> run(
      String? value, Future<String?> Function(String?) checkFuture) async {
    return await checkFuture(value);
  }
}
