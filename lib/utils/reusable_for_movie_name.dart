import 'package:flutter/material.dart';
import 'package:task_assignment/main.dart';

class ResuableForMovieName extends StatefulWidget {
  final String moviekey;
  final String movieValue;
  const ResuableForMovieName(
      {super.key, required this.moviekey, required this.movieValue});

  @override
  State<ResuableForMovieName> createState() => _ResuableForMovieNameState();
}

class _ResuableForMovieNameState extends State<ResuableForMovieName> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('${widget.moviekey} : ',
            style: const TextStyle(
              fontSize: 15,
            )),
        SizedBox(
          height: mq.height * 0.03,
          width: mq.width * 0.39,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  widget.movieValue,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
