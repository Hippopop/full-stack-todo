import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_client/src/features/homepage/controllers/homepage_controllers.dart';
import 'package:todo_client/src/repository/repository.dart';

class AddTodoCard extends ConsumerWidget {
  const AddTodoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        showSearch(
                          context: context,
                          delegate: TodoSearch(),
                        );
                      },
                      child: const Text(
                        "Back",
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        const todo = Todo(
                          id: 0,
                          priority: "low",
                          state: "active",
                          title: "Maybe 3rd Ever TODO from APP!",
                          description: "Now with description. Fun Huhh!"
                        );
                        ref.read(todosController.notifier).addTodo(todo);
                      },
                      child: const Text(
                        "Create new TODO",
                      ),
                    ),
                  ],
                ),
                /* OpenContainer(
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
                ), */
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
