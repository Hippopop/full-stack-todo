import 'package:flutter/material.dart';

class AllTodoScreen extends StatelessWidget {
  const AllTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        children: [
          /* AppBar(
            backgroundColor: Colors.red,
            title: Text("All TODO!"),
          ), */
          Expanded(
            child: Center(
              child: Text("All TODO Screen!"),
            ),
          ),
        ],
      ),
    );
  }
}
