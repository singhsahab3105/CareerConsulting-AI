/// Simple model for representing a single message in the chatbot screen.
/// Keeping it as a separate class makes it easier to extend later.
enum ChatRole { user, assistant }

class ChatMessage {
  final ChatRole role;
  final String text;
  final DateTime time;

  ChatMessage({
    required this.role,
    required this.text,
    DateTime? time,
  }) : time = time ?? DateTime.now();
}
