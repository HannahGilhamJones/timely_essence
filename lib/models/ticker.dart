class Ticker {
  const Ticker();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Ticker && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  Stream<int> tickStream({required int ticks}) {
    return Stream.periodic(
        Duration(
          seconds: 1,
        ),
        (x) => ticks - x - 1).take(ticks);
  }
}
