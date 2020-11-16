import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class Todo {
  String what;
  bool done;
  Todo(this.what) : done = false;

  void toggleDone() => done = !done;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'masApp',
      home: TodolistPage(),
    );
  }
}

class TodolistPage extends StatefulWidget {
  const TodolistPage({
    Key key,
  }) : super(key: key);

  @override
  _TodolistPageState createState() => _TodolistPageState();
}

class _TodolistPageState extends State<TodolistPage> {
  List<Todo> _todos;

  @override
  void initState() {
    _todos = [
      Todo('Primero'),
      Todo('Segundo'),
      Todo('Tercero'),
    ];
    super.initState();
  }

  _removeChecked() {
    List<Todo> pending = [];
    for (var todo in _todos) {
      if (!todo.done) pending.add(todo);
    }
    setState(() => _todos = pending);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('masApp'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _removeChecked,
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            setState(() {
              _todos[index].toggleDone();
            });
          },
          child: ListTile(
            leading: Checkbox(
              value: _todos[index].done,
              onChanged: (checked) {
                setState(() {
                  _todos[index].done = checked;
                });
              },
            ),
            title: Text(
              _todos[index].what,
              style: TextStyle(
                  decoration: (_todos[index].done)
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
            builder: (_) => NewTodoPage(),
          ))
              .then((what) {
            setState(() {
              _todos.add(Todo(what));
            });
          });
        },
      ),
    );
  }
}

class NewTodoPage extends StatefulWidget {
  NewTodoPage({Key key}) : super(key: key);

  @override
  _NewTodoPageState createState() => _NewTodoPageState();
}

class _NewTodoPageState extends State<NewTodoPage> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
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
        title: Text('Nuevo ToDo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              onSubmitted: (what) {
                Navigator.of(context).pop(what);
              },
            ),
            RaisedButton(
              child: Text('Guardar'),
              onPressed: () {
                Navigator.of(context).pop(_controller.text);
              },
            )
          ],
        ),
      ),
    );
  }
}
