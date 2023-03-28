import 'package:flutter/material.dart';

class FilterTodoScreen extends StatelessWidget {
  const FilterTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        children: [
          /* AppBar(
            backgroundColor: Colors.green,
            title: Text("Filtered TODO!"),
          ), */
          Expanded(
            child: Center(
              child: Text("Filter TODO Screen!"),
            ),
          ),
        ],
      ),
    );
  }
}
