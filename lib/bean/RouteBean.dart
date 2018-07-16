import 'package:flutter/material.dart';

class RouteBean {
  String name;
  Route<MaterialPageRoute> builder;
  RouteBean(this.name, this.builder);
  toString() => this.name;
}
