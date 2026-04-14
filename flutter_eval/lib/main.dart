import 'package:flutter/material.dart';
import 'stats_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const TodoListScreen(),
    );
  }
}

// ─── Modèle de données ────────────────────────────────────────────────────────

class Task {
  final String title;
  bool isDone;

  Task({required this.title, this.isDone = false});
}

// ─── Écran principal ──────────────────────────────────────────────────────────

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Task> tasks = [
    Task(title: 'Faire à manger'),
    Task(title: 'Aller faire du sport'),
    Task(title: 'Jouer au jeu vidéo'),
  ];

  final TextEditingController _controller = TextEditingController();

  void _addTask() {
    final text = _controller.text.trim();

    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez entrer une tâche non vide.')),
      );
      return;
    }

    setState(() {
      tasks.add(Task(title: text));
    });

    _controller.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: const Text('Ma Todo List'),
  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
  actions: [
    IconButton(
      icon: const Icon(Icons.bar_chart),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StatsScreen(
              total: tasks.length,
              completed: tasks.where((t) => t.isDone).length,
              remaining: tasks.where((t) => !t.isDone).length,
            ),
          ),
        );
      },
    ),
  ],
),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'nouvelle tache',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addTask(), 
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addTask,
                  child: const Text('Ajouter'),
                ),
              ],
            ),
          ),

          Expanded(
            child: tasks.isEmpty
                ? const Center(child: Text('Pas de tache pour le moment'))
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];

                      return Dismissible(
                        key: Key(task.title),
                        onDismissed: (direction) {
                          setState(() {
                            tasks.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${task.title} Tache supprimée')),
                          );
                        },
                        background: Container(color: Colors.red),
                        child: ListTile(
                          leading: Checkbox(
                            value: task.isDone,
                            onChanged: (value) {
                              setState(() {
                                task.isDone = value!;
                              });
                            },
                          ),
                          title: Text(
                            task.title,
                            style: TextStyle(
                              decoration: task.isDone
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: task.isDone ? Colors.grey : null,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}