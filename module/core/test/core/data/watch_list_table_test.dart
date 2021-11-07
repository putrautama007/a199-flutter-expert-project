import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const watchlistTable = WatchListTable(
    id: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    title: 'title',
  );

  test('should be return of json value', () async {
    final result = watchlistTable.toJson();
    expect(result, isA<Map<String, dynamic>>());
  });
}
