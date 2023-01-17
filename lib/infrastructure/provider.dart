import 'package:db_hive/model/data.dart';
import 'package:riverpod/riverpod.dart';
import '../screens/search.dart';

final imgProvider = StateProvider.autoDispose(((ref) => ''));

final searchProvider = StateProvider(((ref) => studentList));


