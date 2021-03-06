import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hsos/courses/courses_bloc.dart';
import 'package:hsos/courses/detail/course_detail_page.dart';
import 'package:hsos/db/database.dart';
import 'package:hsos/widgets/error_scaffold.dart';
import 'package:hsos/widgets/loading_scaffold.dart';
import 'package:osca_dart/app/models/course.dart';
import 'package:osca_dart/app/osca_app_api.dart';
import 'package:provider/provider.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CoursesBloc(
        context.read<OscaAppApi>(),
        context.read<AppDatabase>(),
      ),
      child: BlocBuilder<CoursesBloc, CoursesState>(
        builder: (context, state) => state.when(
          error: (message) => ErrorScaffold(
            title: 'Kurse',
            errorMessage: message,
          ),
          loading: () => const LoadingScaffold(
            title: 'Kurse',
          ),
          loaded: (courses) => _CoursesListScaffold(
            courses: courses,
          ),
        ),
      ),
    );
  }
}

class _CoursesListScaffold extends StatelessWidget {
  const _CoursesListScaffold({Key key, this.courses}) : super(key: key);
  final List<Course> courses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kurse')),
      body: ListView(
        children: courses.map((e) {
          return ListTile(
            title: Text(e.courseName),
            onTap: () {
              Navigator.push<void>(context,
                  MaterialPageRoute(builder: (context) {
                return CourseDetailPage(
                  course: e,
                );
              }));
            },
          );
        }).toList(growable: false),
      ),
    );
  }
}
