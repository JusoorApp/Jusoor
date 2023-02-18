import 'package:flutter/material.dart';

class ModeBar extends StatefulWidget {
  const ModeBar(this.percent);
  final double percent;

  @override
  State<ModeBar> createState() => _ModeBarState();
}

class _ModeBarState extends State<ModeBar> {
  late double width;
  @override
  void initState() {
    width = 0;
    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      setState(() {
        width = widget.percent * (MediaQuery.of(context).size.width - 40);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Mode Bar",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ),
        Stack(
          alignment: AlignmentDirectional.centerStart,
          children: [
            Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                      ),
                      const BoxShadow(
                        color: Colors.white70,
                        spreadRadius: -5.0,
                        blurRadius: 20.0,
                      ),
                    ],
                    color: Colors.transparent,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    )),
                child: const Text("")),
            AnimatedContainer(
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 500),
                height: 50,
                width: width,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                    color: widget.percent < 0.25
                        ? Colors.pink.shade50
                        : widget.percent <= 0.7
                            ? Colors.lightBlue.shade100
                            : Colors.green.shade100,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: const Text("")),
            Center(
                child: Text(
              widget.percent < 0.25
                  ? '🙁'
                  : widget.percent <= 0.7
                      ? '😊'
                      : '😁',
              style: TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.bold, fontSize: 30),
            )),
          ],
        ),
      ],
    );
  }
}
