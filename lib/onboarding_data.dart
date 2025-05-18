// lib/onboarding_data.dart
class OnboardingPageData {
  final String imagePath;
  final String title;
  final String description;

  OnboardingPageData({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

final List<OnboardingPageData> onboardingPages = [
  OnboardingPageData(
    imagePath: 'assets/AI_planning.png', // From image_78328f.png
    title: 'Plan your travel with AI',
    description: '',
  ),
  OnboardingPageData(
    imagePath: 'assets/travel_stress_free.png', // You'll need to name your second illustration file this way.
    title: 'Travel Stress-free',
    description: '',
  ),
  // Add more pages here as needed
  // OnboardingPageData(
  //   imagePath: 'assets/another_illustration.png',
  //   title: 'Another Title',
  //   description: 'Another description here.',
  // ),
];