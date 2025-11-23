import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/career_profile.dart';
import '../providers.dart';
import '../widgets/primary_button.dart';

/// Left side / first flow: student fills this form when they have "no idea"
/// and want a full assessment from the AI.
class AssessmentScreen extends ConsumerStatefulWidget {
  const AssessmentScreen({super.key});

  @override
  ConsumerState<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends ConsumerState<AssessmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();
  final _educationCtrl = TextEditingController();
  final _interestsCtrl = TextEditingController();
  final _skillsCtrl = TextEditingController();
  final _highestQualCtrl = TextEditingController();
  final _collegeCtrl = TextEditingController();
  final _goalCtrl = TextEditingController();
  final _courseCtrl = TextEditingController();
  final _communicationCtrl = TextEditingController(); // Added this line
  final _hobbiesCtrl = TextEditingController(); // Added this line
  final _eventsCtrl = TextEditingController(); // Added this line
  final _projectsCtrl = TextEditingController(); // Added this line
  final _languagesCtrl = TextEditingController(); // Added this line
  final _preferredLocationsCtrl = TextEditingController(); // Added this line
  final _birthLocationCtrl = TextEditingController(); // Added this line
  final _careerViewCtrl = TextEditingController(); // Added this line

  String? _reportText;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _ageCtrl.dispose();
    _educationCtrl.dispose();
    _interestsCtrl.dispose();
    _skillsCtrl.dispose();
    _goalCtrl.dispose();
    super.dispose();
  }

  Future<void> _onGenerate() async {
    if (!_formKey.currentState!.validate()) return;

    final age = int.tryParse(_ageCtrl.text.trim()) ?? 0;

    final profile = CareerProfile(
      name: _nameCtrl.text.trim(),
      age: age,
      highestQualification: _highestQualCtrl.text.trim(),
      collegeOrSchoolName: _collegeCtrl.text.trim(),
      courseName: _courseCtrl.text.trim(),
      skillSet: _skillsCtrl.text.trim(),
      hobbies: _hobbiesCtrl.text.trim(),
      projectsEngaged: _projectsCtrl.text.trim(),
      preferredLocations: _preferredLocationsCtrl.text.trim(),
      birthLocation: _birthLocationCtrl.text.trim(),
      careerSelfView: _careerViewCtrl.text.trim(),
      interests: _interestsCtrl.text.trim(), // Added this line
      communicationLevel: _communicationCtrl.text.trim(), // Added this line
      eventsParticipated: _eventsCtrl.text.trim(), // Added this line
      languagesKnown: _languagesCtrl.text.trim(), // Added this line
);



    // store profile globally so that chatbot can also use it
    ref.read(currentProfileProvider.notifier).state = profile;

    final gemini = ref.read(geminiServiceProvider);

    setState(() {
      _isLoading = true;
      _reportText = null;
    });

    try {
      final result = await gemini.generateAssessmentReport(profile);
      setState(() {
        _reportText = result;
      });
    } catch (e) {
      setState(() {
        _reportText =
            'Something went wrong while talking to the AI: $e\nPlease check your network or API key.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 1000;

        final form = Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1. Comprehensive Career Assessment',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Fill this short form honestly. The AI will generate a personalised '
                  'career report along with skills and roadmap suggestions.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    SizedBox(
                      width: isWide ? 260 : double.infinity,
                      child: TextFormField(
                        controller: _nameCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: isWide ? 120 : double.infinity,
                      child: TextFormField(
                        controller: _ageCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Age',
                        ),
                        validator: (value) {
                          final text = value?.trim() ?? '';
                          final age = int.tryParse(text);
                          if (age == null || age <= 12 || age > 80) {
                            return 'Enter valid age';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _educationCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Current Education / Course',
                    hintText: 'e.g. B.Tech CSE 3rd Year',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your education details';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _interestsCtrl,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Interests',
                    hintText: 'e.g. coding, design, startups, finance...',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _skillsCtrl,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Current skills / subjects you are good at',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _goalCtrl,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Career goal or dream role (optional)',
                    hintText: 'e.g. Data Scientist at a product-based company',
                  ),
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  label: _isLoading
                      ? 'Generating career plan...'
                      : 'Generate Career Plan',
                  icon: Icons.auto_awesome,
                  isLoading: _isLoading,
                  onPressed: _onGenerate,
                ),
              ],
            ),
          ),
        );

        final report = _reportText == null
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'Your detailed AI-generated career report will appear here '
                    'after you submit the form.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: SelectableText(
                  _reportText!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(height: 1.4),
                ),
              );

        if (isWide) {
          return Row(
            children: [
              SizedBox(width: constraints.maxWidth * 0.45, child: form),
              const VerticalDivider(width: 1),
              Expanded(child: report),
            ],
          );
        }

        return Column(
          children: [
            Expanded(child: form),
            const Divider(height: 1),
            Expanded(child: report),
          ],
        );
      },
    );
  }
}
