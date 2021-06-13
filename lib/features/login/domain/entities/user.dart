import 'dart:convert' as convert;

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class User extends Equatable {
  String login;
  String nome;
  String email;
  String urlFoto;
  String token;

  User({
    required this.login,
    required this.nome,
    required this.email,
    required this.urlFoto,
    required this.token,
  });

  @override
  List<Object> get props => [login, nome, email];

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['urlFoto'] = this.urlFoto;
    data['token'] = this.token;
    return data;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      login: json['login'],
      nome: json['nome'],
      email: json['email'],
      urlFoto: json['urlFoto'],
      token: json['token'],
    );
  }

  String toJson() {
    Map map = toMap();

    String json = convert.json.encode(map);

    return json;
  }
}
