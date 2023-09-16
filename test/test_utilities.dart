import 'package:test/test.dart';

void expectListsEqual<T>(
  List<T> actual,
  List<T> matcher, {
  String? reason,
  Object? skip,
}) {
  expect(
    actual.length,
    equals(matcher.length),
    reason: reason,
    skip: skip,
  );
  expect(actual, containsAll(matcher));
}
