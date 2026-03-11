import 'package:flutter/widgets.dart';

/// A utility to chain multiple validators together.
///
/// Validators are executed in the order they are added.
/// The first validator that returns a non-null string (error) will stop the chain
/// and return that error.
///
/// Example:
/// ```dart
/// TextFormField(
///   validator: MultiValidator([
///     (v) => Validators.validateName(v),
///     (v) => v!.length < 3 ? 'Too short' : null,
///   ]),
/// )
/// ```
class MultiValidator {
  final List<FormFieldValidator<String>> validators;

  MultiValidator(this.validators);

  /// Executes all validators, returning the first error encountered.
  String? call(String? value) {
    for (final validator in validators) {
      final error = validator(value);
      if (error != null) {
        return error;
      }
    }
    return null;
  }
}
