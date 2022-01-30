import 'package:app/imports.dart';

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class CarsPage extends StatefulWidget {
  @override
  _CarsPageState createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> {
  final viewModel = get<CarsViewModel>();

  @override
  void initState() {
    super.initState();

    viewModel.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: false,
        title: Text(R.strings.cars),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _onRefresh,
          )
        ],
      ),
      body: _body(),
      drawer: DrawerList(),
    );
  }

  _body() {
    return StreamViewState<List<Car>>(
      state: viewModel.state,
      builder: (context, cars) {
        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: _listView(cars),
        );
      },
    );
  }


  /// Para demonstração:
  /// Implementação sem o widget StreamViewState
  // _body() {
  //   return StreamBuilder(
  //     stream: viewModel.state.stream,
  //     initialData: viewModel.state,
  //     builder: (context, snapshot) {
  //       final state = snapshot.data as ViewState<List<Car>>;
  //
  //       if (state.loading) {
  //         // Loading
  //         return Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //
  //       var error = state.error;
  //       if (error != null) {
  //         return ErrorView(error.msg);
  //       }
  //
  //       List<Car> list = state.value!;
  //
  //       return RefreshIndicator(
  //         onRefresh: _onRefresh,
  //         child: _listView(list),
  //       );
  //     },
  //   );
  // }

  _listView(List<Car> cars) {
    return Container(
      padding: EdgeInsets.all(16),
      child: cars.isEmpty
          ? Center(
              child: ErrorView(
                R.strings.cars_list_is_empty,
                color: Colors.black,
              ),
            )
          : ListView.builder(
              itemCount: cars.length,
              itemBuilder: (context, idx) {
                Car c = cars[idx];
                return GestureDetector(
                  key: Key("list_item_$idx"),
                  onTap: () => _onClickCar(c),
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CarWidget(c),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _onClickCar(Car c) => push("/cars/${c.id}");

  // void _onClickCar(Car c) => push("/cars/car", args: c);

  Future<void> _onRefresh() => viewModel.fetch();

  @override
  void dispose() {
    super.dispose();

    viewModel.close();
  }
}
