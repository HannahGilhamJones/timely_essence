class Ticker {
  const Ticker();

  Stream<int> tickStream({required int ticks}) {
    return Stream.periodic(
        Duration(
          seconds: 1,
        ),
        (x) => ticks - x - 1).take(ticks);
  }
}
