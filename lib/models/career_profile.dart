/// Represents the detailed information collected from the student.
/// The fields are exactly based on the latest requirement.
class CareerProfile {
  // Personal information
  final String name;
  final int age;
  final String highestQualification;

  // Academic & professional details
  final String collegeOrSchoolName;
  final String courseName;
  final String skillSet;

  // Interests & experience
  final String interests;
  final String hobbies;
  final String communicationLevel;
  final String eventsParticipated; // free text
  final String projectsEngaged; // free text

  // Logistics & aspirations
  final String languagesKnown;
  final String preferredLocations;
  final String birthLocation;
  final String careerSelfView;

  CareerProfile({
    required this.name,
    required this.age,
    required this.highestQualification,
    required this.collegeOrSchoolName,
    required this.courseName,
    required this.skillSet,
    required this.interests,
    required this.hobbies,
    required this.communicationLevel,
    required this.eventsParticipated,
    required this.projectsEngaged,
    required this.languagesKnown,
    required this.preferredLocations,
    required this.birthLocation,
    required this.careerSelfView,
  });

  /// Generates the final prompt text that will be sent to Gemini.
  /// This now contains all the new form fields.
  String toPrompt() {
    return '''
You are an experienced human career counsellor.
Generate a detailed but practical career guidance report for the following student.

== Personal Information ==
Name: $name
Age: $age
Highest Qualification: $highestQualification

== Academic & Professional Details ==
College / School Name: $collegeOrSchoolName
Course Name: $courseName
Skill Set: $skillSet

== Interests & Experience ==
Interests: $interests
Hobbies: $hobbies
Communication Level: $communicationLevel
Events Participated In: $eventsParticipated
Projects Engaged In: $projectsEngaged

== Logistics & Aspirations ==
Languages Known: $languagesKnown
Preferred Locations: $preferredLocations
Birth Location: $birthLocation
Own View on Career: $careerSelfView

Using the above information, prepare a structured report with headings:
1. Short Profile Summary
2. Suitable Career Directions (with reasons)
3. Skills Gap Analysis (what is missing)
4. Recommended Skills, Tools & Technologies
5. 1–3 Year Roadmap (step-by-step, semester-wise if useful)
6. Suggestions on Projects, Internships and Events to target
7. Additional Tips (mindset, networking, communication improvement)

Write in simple, student-friendly English with clear paragraphs.
''';
  }
}
