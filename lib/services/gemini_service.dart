import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/career_profile.dart';

/// Very small wrapper around the Gemini REST API.
/// We keep it simple and readable for viva explanation.
class GeminiService {
  GeminiService(this.apiKey);

  final String apiKey;

  static const String _model = 'gemini-2.5-flash';
  static const String _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models';

  /// Low-level method that sends a plain text prompt and returns the raw text.
  Future<String> _callGemini(String prompt) async {
    final uri = Uri.parse('$_baseUrl/$_model:generateContent');

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'x-goog-api-key': apiKey,
      },
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': prompt},
            ],
          }
        ],
      }),
    );

    if (response.statusCode != 200) {
      // In viva you can explain how you handle errors here.
      throw Exception(
        'Gemini error: ${response.statusCode} – ${response.body}',
      );
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final candidates = data['candidates'] as List<dynamic>?;
    if (candidates == null || candidates.isEmpty) {
      return 'No response received from AI. Please try again.';
    }

    final content = candidates.first['content'] as Map<String, dynamic>?;
    final parts = content?['parts'] as List<dynamic>?;
    if (parts == null || parts.isEmpty) {
      return 'AI did not return any text parts.';
    }

    final text = parts.first['text'] as String?;
    return text?.trim() ?? 'Empty response from AI.';
  }

  /// High-level method used by the "No Idea? Assessment" flow.
  Future<String> generateAssessmentReport(CareerProfile profile) {
    return _callGemini(profile.toPrompt());
  }

  /// High-level method for the chatbot screen.
  Future<String> askCareerQuestion(
    String question, {
    CareerProfile? profile,
  }) {
    const baseInstruction = '''
You are a friendly but realistic career mentor.
Answer the student's question with practical, actionable advice.
Use short paragraphs and examples where useful.
''';

    final prompt = [
      baseInstruction,
      if (profile != null) 'Student Profile (context):\n${profile.toPrompt()}\n',
      'Student Question: $question',
    ].join('\n');

    return _callGemini(prompt);
  }
}
