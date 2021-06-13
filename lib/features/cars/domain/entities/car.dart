import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Car extends Equatable {
  final int id;
  String? name;
  String? type;
  String? description;
  String? photoUrl;

  Car.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['nome'],
        type = map['tipo'],
        description = map['descricao'],
        photoUrl = map['urlFoto'];

  @override
  List<Object> get props => [id];
}
