import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sqlite_todolist/database/item_database.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_todolist/provider/task_provider.dart';
import '../models/task_model.dart';
import 'add_task.dart';
import 'package:sqlite_todolist/database/sqlite_crud.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<TaskModel>> _taskList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _updateTaskList();
  }
  late final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    return SafeArea(
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => AddTaskPage()));
              },
              backgroundColor: Colors.redAccent,
              child: Icon(
                Icons.add,
                size: 4.h,
              ),
            ),
            body: Consumer<TaskProvider>(
              builder: (context,provider,child){
                if(provider.task.isEmpty){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    itemCount: provider.task.length+1,
                    itemBuilder: (context, index) {
                      final tasks=provider.task[index];
                      if (index == 0) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 2.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "My Task",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                "0 Completed 10 incomplete",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        );
                      }
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>AddTaskPage(taskModel: taskModel,)));
                        },
                        child: CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(tasks.title!,style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500),),
                          subtitle: Text(tasks.description!,style: TextStyle(fontSize: 14.sp,color: Colors.grey.shade400),),
                          value: tasks.status,
                          onChanged: (value) {
                            // provider.updateTask(tasks.copy(status: value));
                            // provider.updateTask();
                          },
                          secondary: IconButton(onPressed: (){
                            provider.deleteTask(tasks.id!);
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>HomePage()));
                          }, icon: Icon(Icons.delete,size: 3.5.h,)),
                        ),
                      );
                    });
              },
            )
        )
    );
  }
}
