import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddTodoCard extends StatelessWidget {
  const AddTodoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        clipBehavior: Clip.antiAlias,
        color: Colors.blue.shade300,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Card(
          color: Colors.white,
          child: SizedBox(
            height: 500,
            width: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Outside Shell'),
                TextButton(
                  onPressed: () {
                    // context.pop();
                    showSearch(
                      context: context,
                      delegate: TodoSearch(),
                    );
                  },
                  child: const Text(
                    "Back",
                  ),
                ),
                OpenContainer(
                  transitionType: ContainerTransitionType.fadeThrough,
                  openBuilder: (context, action) => TextButton(
                    onPressed: action,
                    child: const Text(
                      "Close Container!",
                    ),
                  ),
                  closedBuilder: (context, action) => TextButton(
                    onPressed: action,
                    child: const Text(
                      "Open Container!",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TodoSearch extends SearchDelegate {
  final List<String> searchSource = [
    "Apple",
    "Appla",
    "Mango",
    "Manga",
    "Banana",
    "Banaa",
    "Ginger",
    "Gingleer",
  ];

  @override
  List<Widget>? buildActions(BuildContext context) => [];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () {
          context.pop();
        },
        icon: const Icon(
          Icons.arrow_back,
        ),
      );

  @override
  Widget buildResults(BuildContext context) {
    final resultList = searchSource
        .where(
          (element) => element.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    return ListView.builder(
      itemCount: resultList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(
            resultList[index],
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) => Container();
}
