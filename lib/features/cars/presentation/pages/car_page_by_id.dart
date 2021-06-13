import 'package:app/features/cars/presentation/viewmodel/car_viewmodel.dart';
import 'package:app/imports.dart';

class CarByIdPage extends StatefulWidget {
  final int id;

  CarByIdPage(this.id);

  @override
  _CarByIdPageState createState() => _CarByIdPageState();
}

class _CarByIdPageState extends State<CarByIdPage> {
  int get id => widget.id;

  final CarViewModel viewModel = get<CarViewModel>();

  @override
  void initState() {
    super.initState();

    viewModel.fetch(id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamViewState<Car>(
      state: viewModel.state,
      builder: (_, car) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(car.name ?? ""),
          ),
          body: Container(
            padding: EdgeInsets.all(16),
            child: CarWidget(car),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();

    viewModel.close();
  }
}
