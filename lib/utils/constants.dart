import 'package:dio/dio.dart';

final http = Dio();

List splashScreenData = [
  {
    "splashText": "Career Guidance & Mentoring",
    "splashImage": "assets/images/introductory/splash_screen/splash_1.png"
  },
  {
    "splashText": "Card for better connect",
    "splashImage": "assets/images/introductory/splash_screen/splash_2.png"
  },
  {
    "splashText": "Offers & Rewards",
    "splashImage": "assets/images/introductory/splash_screen/splash_3.png"
  },
];

const String host = "https://api.ostello.co.in";
const String mediaHost = "https://cdn.ostello.co.in";

enum PRONOUNS { male, female, others }

enum OFFERS { course_at_99, birthday_special }

enum MODES { offline, online, hybrid }

enum LANGUAGES { hindi, english, other }

List<String> kStreams = ["Science", "Commerce", "Arts"];

List<String> kUserTypes = ["School Student", "College Student", "Parent"];

enum EXAMS { boards, jeeMains, jeeAdvanced, neet, none }

enum STRENGTHS { poor, bad, intermediate, good, excellent }

List<String> kExperiences = [
  '<=1 year',
  '2-4 years',
  '5-7 years',
  '8-10 years',
  '>=11 years',
];

List<String> kInterests = [
  'Career Counseling',
  'Personal Branding',
  'Mentorship',
  'Entrepreneurship',
];

List<String> kAudience = [
  'School Students K-12',
  'Undergrads',
  'Postgrads',
  'Entrepreneurs',
];

List<String> kClasses = [
  "Class 1 (I)",
  "Class 2 (II)",
  "Class 3 (III)",
  "Class 4 (IV)",
  "Class 5 (V)",
  "Class 6 (VI)",
  "Class 7 (VII)",
  "Class 8 (VIII)",
  "Class 9 (IX)",
  "Class 10 (X)",
  "Class 11 (XI)",
  "Class 12 (XII)",
  "Class 12 Dropout",
];

List<String> kEducationLevels = ["Undergrad", "Postgrad"];

List<String> quickReplies = [
  "I need help with my career decisions",
  "I need help with my class 10th boards exams",
  "I want to find a good coaching institute nearby",
  "Explore internship opportunities",
  "I have some other issues",
  "Go back to the main menu",
  "Doubt in subject or in any topic",
];

List<String> kExpertises = [
  "NDA",
  "Pilot",
  "CDS",
  "Commerce",
  "Economics",
  "Accounts",
  "Event Management",
  "Product Management",
  "General Management",
  "Marketing",
  "Entrepreneurship",
  "Teaching",
  "NEET",
  "UPSC",
  "JEE",
  "CAT Preparation",
  "CUET Prepration",
  "IELTS Preparation",
  "SAT/ACT/AP Preparation",
  "Engineering",
  "Software",
  "IT",
  "Computer Science",
  "Cloud Computing",
  "Aeronautical",
  "Astronautical",
  "Automobile",
  "Mechanical",
  "Civil",
  "Architecture",
  "Urban Planning",
  "Biotechnology",
  "Botany",
  "Zoology",
  "Neurology",
  "NeuroScience",
  "Agricultural Science",
  "Forensic Science",
  "Interior Design",
  "Fashion Design",
  "Apparel Design",
  "Leather Design",
  "Footwear Design",
  "Jewelry Design",
  "UI/UX Design",
  "Psychology",
  "Psychiatry",
  "Dentistry",
  "Pharmacy",
  "Physiotherapy",
  "Policy Making",
  "Journalism",
  "Content Writing",
  "Public Speaking",
  "Interview Preparation",
  "Sportsperson",
  "Musician",
  "Dancer",
  "Guitarist",
  "Vocalist",
  "Cartoonist",
  "Film Making",
  "Photography",
  "Videography",
  "Cinematography",
  "Animation",
  "Tarot Card Reader",
  "Astrology",
  "Astronomy",
  "Astrophysics",
  "Cartography",
  "Statistics",
  "Cabin Crew",
  "Hotel Management",
  "Culinary Arts",
  "Tourism",
  "Defense",
  "Law",
  "Finance and Banking",
  "CA",
  "CFA",
  "Actuarial Science",
  "CS",
  "CPA",
  "Data Science",
  "Artificial Intelligence",
];

List kMembershipInfoContent = [
  {
    "imagePath": 'assets/images/mentor/communication.png',
    "content": 'Spark Connections: Generate vibrant leads in our vast network',
  },
  {
    "imagePath": 'assets/images/mentor/earnings.png',
    "content": 'Fuel Earnings: Empower lives, elevate your income',
  },
  {
    "imagePath": 'assets/images/mentor/teacher.png',
    "content":
        'Shine Your Brand: Enhance your influence, radiate your reputation',
  },
];
