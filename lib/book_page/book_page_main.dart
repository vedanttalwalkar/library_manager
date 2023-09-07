import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_manager/book_page/book_page_bloc.dart';
import 'package:library_manager/book_page/book_page_screen.dart';

class BookPageMain extends StatelessWidget {
  const BookPageMain({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (create) {
        return BookPageBloc();
      },
      child: const BookPageScreen(),
    );
  }
}
