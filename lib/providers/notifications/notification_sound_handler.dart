import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';

class NotificationSoundHandler {
  static final AudioPlayer _player = AudioPlayer();

  /// Play Notification Sound
  static Future<void> playSound() async {
    await _player.play(AssetSource("sounds/notification.mp3"));
  }

  /// Trigger Phone Vibration
  static Future<void> vibrate() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 300);
    }
  }

  /// Play both (used for push notifications)
  static Future<void> playAlert() async {
    await playSound();
    await vibrate();
  }
}
