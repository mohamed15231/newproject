import 'package:todolist/shared/cubit/cubit.dart';

abstract class AppStates{}

class InitialState extends AppStates{}

class ChangeBottomNavBar extends AppStates{}

class InsertDataBase extends AppStates{}

class LoadingGetDataBase extends AppStates{}

class GetDataBase extends AppStates{}

class DeleteDataFromDataBase extends AppStates{}

class UpdateDataBase extends AppStates{}

class CreateDataBase extends AppStates{}

class ChangeBottomSheet extends AppStates{}