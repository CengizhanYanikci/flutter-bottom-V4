import 'package:flutter/material.dart';
import 'package:modelflutter/models/todo.dart';
import 'package:modelflutter/screens/tododetail.dart';

class TodoListModel extends StatefulWidget {
  const TodoListModel({super.key});

  @override
  State<TodoListModel> createState() => _TodoListModelState();
}

class _TodoListModelState extends State<TodoListModel> {
  List<Todo> todolistModel = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String title;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isObsecure = false;
  late Todo editTodo;
  late bool isEdit = false;

  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          isEdit ? uptadeTodo(editTodo) : addTodo();
        },
        child: !isEdit ? const Icon(Icons.add) : const Icon(Icons.save_as),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      controller: titleController,
                      onFieldSubmitted: isEdit
                          ? (value) => uptadeTodo(editTodo)
                          : (value) => addTodo(),
                      obscureText: isObsecure,
                      decoration: InputDecoration(
                          labelText: "Title",
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                isObsecure = !isObsecure;
                              });
                            },
                            child: Icon(isObsecure
                                ? Icons.visibility_off
                                : Icons.visibility),
                          )),
                      autovalidateMode: autovalidateMode,
                      onSaved: (newvalue) {
                        setState(() {
                          title = newvalue!;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "It can't be empty";
                        } else {}
                      },
                    ),
                  ),
                )),
            Expanded(
              flex: 3,
              child: ListView.separated(
                padding: const EdgeInsets.all(16.0),
                separatorBuilder: (context, index) => const Divider(
                  height: 5,
                  color: Colors.transparent,
                ),
                itemCount: todolistModel.length,
                itemBuilder: (context, index) {
                  var element = todolistModel[index];
                  return ListTile(
                    tileColor: element.isCompleted!
                        ? Colors.red[isEdit && editTodo == element ? 300 : 100]
                        : Colors
                            .green[isEdit && editTodo == element ? 300 : 100],
                    leading: Checkbox(
                        activeColor: Colors.blue,
                        onChanged: (newValue) {
                          setState(() {
                            element.isCompleted = newValue!;
                          });
                        },
                        value: element.isCompleted),
                    title: Text(
                      element.title,
                      style: TextStyle(
                          decoration: element.isCompleted!
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                    subtitle: const Text("Check if your job is done"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                isEdit = !isEdit;
                                titleController.text = element.title;
                                editTodo = element;
                                if (!isEdit) {
                                  titleController.text = "";
                                }
                              });
                            },
                            child: Icon(
                              Icons.edit,
                              color: isEdit && editTodo == element
                                  ? Colors.blue
                                  : Colors.black45,
                            )),
                        InkWell(
                            onTap: () {
                              setState(() {
                                element.isStar = !element.isStar!;
                              });
                            },
                            child: Icon(
                              Icons.star,
                              color: element.isStar!
                                  ? Colors.amber
                                  : Colors.black45,
                            )),
                        InkWell(
                            onTap: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TodoDetail(todo: element),
                                    ));
                              });
                            },
                            child: const Icon(Icons.more_vert)),
                        InkWell(
                            onTap: () {
                              setState(() {
                                getDeleteAlert();
                                todolistModel.remove(element);
                              });
                            },
                            child: const Icon(Icons.delete)),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void addTodo() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Todo todo = Todo(
          Id: todolistModel.isEmpty ? 1 : todolistModel.last.Id + 1,
          title: title);

      setState(() {
        todolistModel.add(todo);
      });

      getSuccsessAlert();
      formKey.currentState!.reset();
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  void uptadeTodo(Todo editTodo) {
    todolistModel
        .map((e) => {
              if (e == editTodo)
                {
                  setState(() {
                    getUptadeAlert();
                    e.title = titleController.text;
                    isEdit = false;
                    titleController.text = "";
                  })
                }
            })
        .toList();
  }

  Future<void> getSuccsessAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Icon(Icons.check, color: Colors.green, size: 120)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> getUptadeAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Todo Uptaded!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Icon(Icons.refresh, color: Colors.blue, size: 120)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> getDeleteAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure to Delete?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Icon(Icons.close, color: Colors.red, size: 120)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
