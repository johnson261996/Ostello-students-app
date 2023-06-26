import 'package:dio/dio.dart';

final http = Dio();

List<Map<String, dynamic>> kP1Que1 = [
  {
    "option": "understanding the overall goal",
    "weightage": 5,
    "question":
        "When given a new project, what do you prioritize first: understanding the overall goals or creating a detailed plan of action?",
  },
  {
    "option": "creating a detailed plan of action",
    "weightage": 0,
  },
];

List<Map<String, dynamic>> kP1Que2 = [
  {
    "option": "completing tasks efficiently",
    "weightage": 0,
    "question":
        "Do you prefer to focus on completing tasks efficiently or building strong relationships with team members in a team setting?",
  },
  {
    "option":
        "building strong relationships with team members in a team setting",
    "weightage": 5,
  },
];

List<Map<String, dynamic>> kP1Que3 = [
  {
    "option": "Very Important",
    "weightage": 5,
    "question":
        "How important is establishing positive relationships and rapport with others in your work or personal life?",
  },
  {
    "option": "Not so important",
    "weightage": 0,
  },
];

List<Map<String, dynamic>> kP1Que4 = [
  {
    "option": "Yes",
    "weightage": 5,
    "question":
        "Do you prefer collaborative environments where teamwork and cooperation are emphasized?",
  },
  {
    "option": "No",
    "weightage": 0,
  },
];

List<Map<String, dynamic>> kP1Que5 = [
  {
    "option": "Extremely Motivated",
    "weightage": 0,
    "question":
        "How motivated are you by personal achievements and recognition?",
  },
  {
    "option": "Doesn't Matter",
    "weightage": 5,
  },
];

List<Map<String, dynamic>> kP1Que6 = [
  {
    "option": "Yes",
    "weightage": 0,
    "question":
        "Do you prefer work or activities where you have a high degree of independence and control over your outcomes?",
  },
  {
    "option": "No",
    "weightage": 5,
  },
];

List<Map<String, dynamic>> kP1Que7 = [
  {
    "option": "Very Important",
    "weightage": 5,
    "question":
        "How important is it for you to pay attention to small details and ensure accuracy in your work?",
  },
  {
    "option": "Not so important",
    "weightage": 0,
  },
];

List<Map<String, dynamic>> kP1Que8 = [
  {
    "option": "Yes",
    "weightage": 5,
    "question":
        "Do you find yourself naturally inclined to notice and focus on minute aspects of a situation or task?",
  },
  {
    "option": "No",
    "weightage": 0,
  },
];

List<Map<String, dynamic>> kP2Que1 = [
  {
    "option": "Reserved and private ",
    "weightage": -1,
    "question": "I am more likely to be seen as",
  },
  {
    "option": "Outgoing and sociable",
    "weightage": 5,
  },
];

List<Map<String, dynamic>> kP2Que2 = [
  {
    "option": "Logical reasoning and objective analysis",
    "weightage": 1,
    "question": "When making decisions, I primarily rely on",
  },
  {
    "option": "Personal values and the impact on people",
    "weightage": 5,
  },
];

List<Map<String, dynamic>> kP2Que3 = [
  {
    "option": "Practical, step-by-step approaches",
    "weightage": 1,
    "question": "When solving problems, I tend to focus on",
  },
  {
    "option": "The big picture and future possibilities",
    "weightage": 5,
  },
];

List<Map<String, dynamic>> kP2Que4 = [
  {
    "option": "Stick to a planned routine or strategy",
    "weightage": 1,
    "question": "When under pressure, I am more likely to",
  },
  {
    "option": "Adapt and respond to the situation spontaneously",
    "weightage": 5,
  },
];

List<Map<String, dynamic>> kP2Que5 = [
  {
    "option": "Value honesty and direct communication",
    "weightage": 3,
    "question": "When interacting with others, I tend to",
  },
  {
    "option": "Consider people's feelings and maintain harmony",
    "weightage": 3,
  },
];

List<Map<String, dynamic>> kP2Que6 = [
  {
    "option": "Strongly agree",
    "weightage": 5,
    "question": "I have a liberal approach",
  },
  {
    "option": "Agree",
    "weightage": 4,
  },
  {
    "option": "Neutral",
    "weightage": 3,
  },
  {
    "option": "Disagree",
    "weightage": 2,
  },
  {
    "option": "Strongly Disagree",
    "weightage": 1,
  },
];

List<Map<String, dynamic>> kP2Que7 = [
  {
    "option": "Strongly agree",
    "weightage": 5,
    "question": "I have a kind word for everybody",
  },
  {
    "option": "Agree",
    "weightage": 4,
  },
  {
    "option": "Neutral",
    "weightage": 3,
  },
  {
    "option": "Disagree",
    "weightage": 2,
  },
  {
    "option": "Strongly Disagree",
    "weightage": 1,
  },
];

List<Map<String, dynamic>> kP2Que8 = [
  {
    "option": "Strongly agree",
    "weightage": 5,
    "question": "I handle social situations well",
  },
  {
    "option": "Agree",
    "weightage": 4,
  },
  {
    "option": "Neutral",
    "weightage": 3,
  },
  {
    "option": "Disagree",
    "weightage": 2,
  },
  {
    "option": "Strongly Disagree",
    "weightage": 1,
  },
];

List<Map<String, dynamic>> kP2Que9 = [
  {
    "option": "Strongly agree",
    "weightage": 5,
    "question": "I can communicate efficiently",
  },
  {
    "option": "Agree",
    "weightage": 4,
  },
  {
    "option": "Neutral",
    "weightage": 3,
  },
  {
    "option": "Disagree",
    "weightage": 2,
  },
  {
    "option": "Strongly Disagree",
    "weightage": 1,
  },
];

List<Map<String, dynamic>> kP2Que10 = [
  {
    "option": "Strongly agree",
    "weightage": 1,
    "question": "I am troubled by negative thoughts",
  },
  {
    "option": "Agree",
    "weightage": 2,
  },
  {
    "option": "Neutral",
    "weightage": 3,
  },
  {
    "option": "Disagree",
    "weightage": 4,
  },
  {
    "option": "Strongly Disagree",
    "weightage": 5,
  },
];

List<Map<String, dynamic>> kP2Que11 = [
  {
    "option": "Yes",
    "weightage": 4,
    "question": "Do you always have a ready answer when people talk to you?",
  },
  {
    "option": "No",
    "weightage": 2,
  },
];

List<Map<String, dynamic>> kP2Que12 = [
  {
    "option": "Yes",
    "weightage": 4,
    "question": "Do you take much notice of what people think?",
  },
  {
    "option": "No",
    "weightage": 2,
  },
];

List<Map<String, dynamic>> kP2Que13 = [
  {
    "option": "Yes",
    "weightage": 4,
    "question": "Do you have many different hobbies?",
  },
  {
    "option": "No",
    "weightage": 2,
  },
];

List<Map<String, dynamic>> kP2Que14 = [
  {
    "option": "Yes",
    "weightage": 3,
    "question": "Does your mood often go up and down?",
  },
  {
    "option": "No",
    "weightage": 3,
  },
];

List<Map<String, dynamic>> kP2Que15 = [
  {
    "option": "Yes",
    "weightage": 5,
    "question": "Do you usually take initiative in making new friends?",
  },
  {
    "option": "No",
    "weightage": 1,
  },
];
