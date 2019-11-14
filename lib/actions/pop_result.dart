import 'package:meta/meta.dart';

/// PopResult
class PopWithResults<T> {
  /// poped from this page
  final String fromPage;

  /// pop until this page
  final String toPage;

  /// results
  final dynamic results;

  /// constructor
  PopWithResults(
      {@required this.fromPage, @required this.toPage, this.results});
}
