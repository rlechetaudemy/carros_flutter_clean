import 'package:app/imports.dart';
import 'package:flutter/material.dart';

class CarWidget extends StatelessWidget {
  final Car car;

  const CarWidget(this.car);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: CachedNetworkImage(
              imageUrl: car.photoUrl ?? "",
              width: 280,
            ),
          ),
          Text(
            car.name ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 25, color: Colors.green),
          ),
          Text(
            "descrição...",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
