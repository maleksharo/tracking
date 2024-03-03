import 'dart:async';

/// This class is for doing some codes after sometime [delay]
class Debounce {
  Debounce(
    this.delay,
  );

  Duration delay;
  Timer? _timer;

  void dispose() {
    _timer?.cancel();
  }

  void call(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }
}
