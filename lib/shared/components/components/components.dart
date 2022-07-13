import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist/shared/cubit/cubit.dart';

import '../constant/constant.dart';

Widget defualtTextForm({
  required TextEditingController controller,
  required String lable,
  required IconData iconPrefix,
  required TextInputType type,
  required FormFieldValidator validatefunction,
  Function()? tap,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      label: Text(lable),
      border: const OutlineInputBorder(),
      prefixIcon: Icon(
        iconPrefix,
      ),
    ),
    keyboardType: type,
    validator: validatefunction,
    onTap: tap,
  );
}

Widget buildItemTaskScreen(Map model, BuildContext context) {
  return Dismissible(
    key:Key(
        model['title'].toString()
    ),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 45,
            child: Text(
              model['time'],
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  model['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                ),
                Text(
                  model['date'],
                  style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
            AppCubit.get(context).updateDataBase(status: "done", id: model['id']);
            },
            icon: const Icon(
              Icons.check_box,
              color: Colors.green,
            ),
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context).updateDataBase(status: "archive", id: model['id']);

            },
            icon: const Icon(
              Icons.archive_outlined,
              color: Colors.black26,
            ),
          ),
        ],
      ),
    ),
    onDismissed: (direction){
      AppCubit.get(context).deleteDataInDataBase(id: model['id']);
    },
  );
}

Widget buildConditionalItem(List<Map> tasks){
  return tasks.isEmpty ? Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.menu,
          size: 50.0,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          "No Tasks Yet ,Please Enter Tasks",
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
          ),
        ),
      ],
    ),
  ) :ListView.separated(
    itemBuilder: (context,index)=>buildItemTaskScreen(tasks[index],context),
    separatorBuilder: (context,index)=>Container(
      height: 1.0,
      color: Colors.grey,
    ),
    itemCount: tasks.length,
  );
}