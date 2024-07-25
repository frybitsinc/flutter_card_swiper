import 'package:example/example_candidate_model.dart';
import 'package:flutter/material.dart';

class NumberCard extends StatelessWidget {
  final ExampleCandidateModel candidate;
  final double fontSize;
  const NumberCard(this.candidate, this.fontSize, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: candidate.color,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Center(
        child: Text(
          candidate.number.toString(),
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500,),
        ),
      ),
    );
  }
}
