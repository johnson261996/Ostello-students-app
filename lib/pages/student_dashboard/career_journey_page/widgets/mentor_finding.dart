import 'package:flutter/material.dart';

class FindingMentorAnimationWidget extends StatefulWidget {
  const FindingMentorAnimationWidget({Key? key}) : super(key: key);

  @override
  State<FindingMentorAnimationWidget> createState() =>
      _FindingMentorAnimationWidgetState();
}

class _FindingMentorAnimationWidgetState
    extends State<FindingMentorAnimationWidget> with TickerProviderStateMixin {
  final height = 400.0;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..repeat();

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();

    // Timer(
    //   const Duration(seconds: 5),
    //   () => Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (builder) => const MentorPage(),
    //     ),
    //   ),
    // );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 40;

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xff0056FF).withOpacity(0.1),
          ),
        ),
        Container(
          width: width / 2,
          height: height / 2,
          decoration: BoxDecoration(
              color: const Color(0xff0056FF).withOpacity(0.01),
              border: Border.all(color: Colors.white),
              shape: BoxShape.circle),
        ),
        Container(
          width: width / 5,
          height: height / 5,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              shape: BoxShape.circle),
        ),
        ScaleTransition(
          scale: _animation,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                color: const Color(0xff0056FF).withOpacity(0.1),
                shape: BoxShape.circle),
          ),
        ),
        const Text(
          '120',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Positioned(
          bottom: height / 3.5,
          left: width / 6,
          child: const CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('assets/images/mentor/mentor_1.jpeg'),
            backgroundColor: Colors.amber,
          ),
        ),
        Positioned(
          top: height / 4,
          right: width / 5,
          child: const CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('assets/images/mentor/mentor_2.jpeg'),
            backgroundColor: Colors.amber,
          ),
        ),
      ],
    );
  }
}
