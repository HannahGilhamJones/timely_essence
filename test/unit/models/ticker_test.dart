import 'package:flutter_test/flutter_test.dart';

import 'package:timely_essence/models/ticker.dart';

void main() {
  group('Equality', () {
    test('Two ticker objects are the same', () {
      final Ticker ticker = Ticker();
      final Ticker tickerTwo = Ticker();

      expect(ticker, tickerTwo);
    });

    test('Ticker objects with different durations are not the same', () {
      final Ticker ticker = Ticker();
      final Ticker tickerTwo = Ticker();

      tickerTwo.tickStream(ticks: 2);

      expect(ticker, tickerTwo);
    });
  });

  test('should emit numbers in decreasing order', () {
    final Ticker ticker = Ticker();
    expect(ticker.tickStream(ticks: 5), emitsInOrder([4, 3, 2, 1]));
  });
}
