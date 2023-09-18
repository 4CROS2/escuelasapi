// ignore_for_file: depend_on_referenced_packages

import 'package:escuelasapi/bloc/app/app_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  BlocProvider<AppCubit>(create: (context)=> AppCubit())
];
