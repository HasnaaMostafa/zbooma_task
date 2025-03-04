import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zbooma_task/app.dart';
import 'package:zbooma_task/core/observers/bloc_observer.dart';
import 'package:zbooma_task/core/services/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocator();

  Bloc.observer = MyBlocObserver();
  runApp(const ZboomaTask());
}
