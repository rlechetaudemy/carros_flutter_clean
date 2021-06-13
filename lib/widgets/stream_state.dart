import 'package:app/imports.dart';

typedef _WidgetBuilder<T> = Widget Function(BuildContext context, T value);

///StreamBuilder that receives a stream of ViewState<T>
class StreamViewState<T> extends StatelessWidget {
  final ViewState<T> state;

  final _WidgetBuilder<T> builder;

  StreamViewState({
    required this.state,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ViewState<T>>(
      stream: this.state.stream,
      initialData: this.state,
      builder: (context, snapshot) {
        final state = this.state;

        if (state.loading) {
          // Loading
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        var error = state.error;
        if (error != null) {
          return ErrorView(error.msg);
        }

        T value = state.value!;

        return builder(context, value);
      },
    );
  }
}
