import 'dart:async';

class TimerManager {
  Timer? _timer;

  final void Function() onTimeElapsed;

  TimerManager({required this.onTimeElapsed});

  void startTimer(Duration duration) {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer(duration, onTimeElapsed);
  }

  void dispose() {
    _timer?.cancel(); // Ensure timer is cancelled when no longer needed
  }
}