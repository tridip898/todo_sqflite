import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:sqlite_todolist/database/item_database.dart';
import 'package:sqlite_todolist/provider/task_provider.dart';
import 'package:sqlite_todolist/view/home_page.dart';

import '../models/task_model.dart';

class AddTaskPage extends StatefulWidget {
  final TaskModel? taskModel;
  final TaskProvider? tasks;
  AddTaskPage({Key? key, this.taskModel, this.tasks}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _titleController=TextEditingController();
  TextEditingController _descriptionController=TextEditingController();

  String _title='';
  String _description='';
  String _titleText="Create Task";




  // _submit(){
  //   if(_formKey.currentState!.validate()){
  //     _formKey.currentState!.save();
  //     TaskModel taskModel=TaskModel(title: _title,description: _description,date: _date);
  //     if(widget.taskModel==null){
  //       taskModel.status=0;
  //       SQLHelper.instance.insertTask(taskModel);
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           elevation: 0,
  //           backgroundColor: Colors.redAccent,
  //           content: Text(
  //             "Add Item Successfully",
  //             style: TextStyle(
  //                 fontSize: 13.sp, color: Colors.white),
  //           )));
  //       Navigator.push(context, MaterialPageRoute(builder: (_)=>HomePage()));
  //     }else{
  //       taskModel.id=widget.taskModel!.id;
  //       taskModel.status=widget.taskModel!.status;
  //       SQLHelper.instance.updateTask(taskModel);
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           elevation: 0,
  //           backgroundColor: Colors.redAccent,
  //           content: Text(
  //             "Update Item Successfully",
  //             style: TextStyle(
  //                 fontSize: 13.sp, color: Colors.white),
  //           )));
  //       Navigator.push(context, MaterialPageRoute(builder: (_)=>HomePage()));
  //     }
  //     widget.updateTaskList!();
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.taskModel !=null){
      _title=widget.taskModel!.title!;
      _description=widget.taskModel!.description!;

      setState(() {
        _titleText="Update Task";
      });
    }else{
      setState(() {
        _titleText="Create Task";
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    return SafeArea(
      child: Scaffold(
          body: Consumer<TaskProvider>(
            builder: (context,provider,child){
              return GestureDetector(
                onTap: () =>FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  size: 3.2.h,
                                )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _titleText,
                                  style: TextStyle(
                                      fontSize: 20.sp, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  DateFormat.yMMMd('en_US').format(DateTime.now()),
                                  style: TextStyle(
                                      fontSize: 14.sp, fontWeight: FontWeight.w500),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 2.w),
                                child: TextFormField(
                                  style: TextStyle(fontSize: 15.sp),
                                  decoration: InputDecoration(
                                      hintText: "Title",
                                      hintStyle: TextStyle(fontSize: 15.sp),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black,width: 5),
                                          borderRadius: BorderRadius.circular(10))),
                                  onSaved: (input)=>_title=input!,
                                  initialValue: _title,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 2.w),
                                child: TextFormField(
                                  style: TextStyle(fontSize: 15.sp),
                                  decoration: InputDecoration(
                                      hintText: "Description",
                                      hintStyle: TextStyle(fontSize: 15.sp),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black,width: 5),
                                          borderRadius: BorderRadius.circular(10))),
                                  onSaved: (input)=>_description=input!,
                                  initialValue: _description,
                                ),
                              ),

                              SizedBox(height: 2.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  MaterialButton(
                                    onPressed: (){
                                      final title=_titleController.text.trim();
                                      final description=_descriptionController.text.trim();
                                      if(provider.task == null){
                                        final task=TaskModel(title: title,description: description);
                                        Provider.of<TaskProvider>(context,listen: false).addTask(task);
                                        _titleController.clear();
                                        _descriptionController.clear();
                                        Navigator.push(context, MaterialPageRoute(builder: (_)=>HomePage()));
                                      }else{

                                      }
                                    },
                                    color: Color(0xff2E4F4F),
                                    child: Text(provider.task == null ? "Save": "Update",style: TextStyle(fontSize: 16.sp,color: Colors.white),),
                                    padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 1.h),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                  ),
                                  SizedBox(width: 2.w,),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          )
    ),
    );
  }
}
