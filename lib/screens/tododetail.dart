import 'package:modelflutter/models/todo.dart';
import 'package:flutter/material.dart';

class TodoDetail extends StatefulWidget {
  final Todo todo;
  const TodoDetail({required this.todo, super.key});

  @override
  State<TodoDetail> createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.todo.title} Detail"),
        actions: [
          Checkbox(
            onChanged: (newValue) {},
            value: widget.todo.isCompleted,
            activeColor: Colors.blue,
          ),
          Icon(
            Icons.star,
            color: widget.todo.isStar! ? Colors.amber : Colors.black45,
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Center(
        child: Text(widget.todo.title),
      ),
    );
  }
}
