// ignore_for_file: public_member_api_docs, sort_constructors_first
class OnboardingContent {
  String image;
  String text;
  String highlightedText;
  String description;

  OnboardingContent({
    required this.image,
    required this.text,
    required this.highlightedText,
    required this.description,
  });
}

List<OnboardingContent> contents = [
  OnboardingContent(
    image: "assets/images/introductory/splash_screen/splash_1.png",
    text: 'Discover Your',
    highlightedText: 'Path',
    description:
        'AI-assisted career matching based on your strengths, interests, and goals',
  ),
  OnboardingContent(
    image: "assets/images/introductory/splash_screen/splash_2.png",
    text: 'Learn from',
    highlightedText: 'Experts',
    description:
        'Connect with expert mentors for insights and support to advance your career',
  ),
  OnboardingContent(
    image: "assets/images/introductory/splash_screen/splash_3.png",
    text: 'Personalized',
    highlightedText: 'Growth Plan',
    description:
        'Get tailored recommendations for skill growth, networking, and career goals to help you achieve your dreams',
  ),
];
