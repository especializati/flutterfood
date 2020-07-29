import 'dart:convert';

import './Food.dart';
import './Evaluation.dart';

class Order {
  String identify;
  String date;
  String status;
  String table;
  double total;
  String comment;
  List<Food> foods;
  List<Evaluation> evaluations;

  Order(
      {this.identify,
      this.date,
      this.status,
      this.table,
      this.total,
      this.comment,
      this.foods,
      this.evaluations});

  factory Order.fromJson(jsonData) {
    return Order(
      identify: jsonData['identify'],
      date: jsonData['date'],
      status: jsonData['status'],
      table: jsonData['table'],
      total: double.parse(jsonData['total']),
      comment: jsonData['comment'],
      foods: jsonData['foods'],
      evaluations: jsonData['evaluations'],
    );
  }

  toJson() {
    return jsonEncode({
      'identify': identify,
      'date': date,
      'status': status,
      'table': table,
      'total': total,
      'comment': comment,
      'foods': foods,
      'evaluations': evaluations,
    });
  }
}
