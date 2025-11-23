import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/career_profile.dart';
import 'models/chat_message.dart';
import 'services/gemini_service.dart';

/// IMPORTANT: Put your own Gemini API key here for testing.
/// For a college project this is generally okay, but do not share the key publicly.
const String kGeminiApiKey = 'AIzaSyBqqnYYcGv_G6-1uISTpsxlQyr4_7dBXIk';

/// Provides a single instance of [GeminiService] to the whole app.
final geminiServiceProvider = Provider<GeminiService>((ref) {
  return GeminiService(kGeminiApiKey);
});

/// Holds the last submitted [CareerProfile] from the assessment form.
/// The chatbot can also use this as context.
final currentProfileProvider = StateProvider<CareerProfile?>((ref) => null);

/// Holds the list of chat messages on the chatbot screen.
final chatMessagesProvider =
    StateNotifierProvider<ChatMessagesNotifier, List<ChatMessage>>((ref) {
  return ChatMessagesNotifier();
});

class ChatMessagesNotifier extends StateNotifier<List<ChatMessage>> {
  ChatMessagesNotifier() : super(const []);

  void addMessage(ChatMessage message) {
    state = [...state, message];
  }

  void clear() {
    state = const [];
  }
}
