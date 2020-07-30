import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../widgets/flutter_bottom_navigator.dart';

class EvaluationOrderScreen extends StatelessWidget {
  const EvaluationOrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avaliar o pedido'),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: _buildScreenEvaluationOrder(context),
      bottomNavigationBar: FlutterFoodBottomNavigator(1),
    );
  }

  Widget _buildScreenEvaluationOrder(context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          _buildHeader(),
          Container(height: 22),
          _buildFormEvaluation(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      child: Text(
        "Avaliar o Pedido: 3213dfds",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildFormEvaluation(context) {
    return Container(
      child: Column(
        children: <Widget>[
          RatingBar(
            initialRating: 1,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 30,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (value) {
              print(value);
            },
          ),
          Container(height: 14),
          TextFormField(
            autocorrect: true,
            style: TextStyle(color: Theme.of(context).primaryColor),
            cursorColor: Theme.of(context).primaryColor,
            onSaved: (value) {
              print(value);
            },
            decoration: InputDecoration(
                labelText: 'Comentário (ex: Muito bom)',
                labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                )),
          ),
          Container(height: 14),
          Container(
            //margin: EdgeInsets.only(bottom: 30, top: 10),
            //padding: EdgeInsets.only(left: 20, right: 20),
            child: RaisedButton(
              onPressed: () {
                print('avaliar o pedido');
              },
              color: Theme.of(context).primaryColor,
              elevation: 2.2,
              child: Text(
                'Avaliar o Pedido',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
            ),
          ),
        ],
      ),
    );
  }
}
