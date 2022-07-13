import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/shared/components/components/components.dart';
import 'package:todolist/shared/components/constant/constant.dart';
import 'package:todolist/shared/cubit/states.dart';

import '../../shared/cubit/cubit.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
      builder: (context, state) {
        List<Map>tasks=AppCubit.get(context).doneTasks;
        return buildConditionalItem(tasks);
      },
      listener: (context, state) {},
    );
  }
}
