/// Represents the basic information we collect from the student/learner.
/// This is intentionally simple – you can extend it with more fields later.
class CareerProfile {
  final String fullName;
  final int age;
  final String educationLevel;
  final String interests;
  final String skills;
  final String careerGoal;

  CareerProfile({
    required this.fullName,
    required this.age,
    required this.educationLevel,
    required this.interests,
    required this.skills,
    required this.careerGoal,
  });

  /// Generates the final prompt text that will be sent to Gemini.
  String toPrompt() {
    return '''
You are an expert human career counsellor.
Generate a detailed but practical career guidance report for the following student.

Name: $fullName
Age: $age
Education level / current course: $educationLevel
Interests: $interests
Current skills / subjects: $skills
Initial career goal / dream role: $careerGoal

Return the answer in a well-formatted structure with clear headings such as:
1. Short Profile Summary
2. Possible Career Directions (with explanation)
3. Skills Gap Analysis
4. Recommended Skills, Tools & Technologies
5. 1–3 Year Roadmap (step-by-step, semester-wise if possible)
6. Additional Tips (mindset, internships, networking)

Write in simple, student-friendly English.
Avoid bullet points that are too short – give proper explanation.
''';
  }
}
