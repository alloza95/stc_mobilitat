import 'package:flutter/material.dart';
import 'package:stc_mobilitat_app/src/models/titlesBus.dart';

class TitlesPrices extends StatefulWidget {
  static String routeName = '/titlesPrices';
  @override
  _TitlesPricesState createState() => _TitlesPricesState();
}

class _TitlesPricesState extends State<TitlesPrices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Títols i tarifes'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: ListView.builder(
          itemCount: titlesBus.length,
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.only(bottom: 24),
            child: ExpansionTile(
              title: Text(titlesBus[index].title),
              leading: Image(image: AssetImage(titlesBus[index].image)),            
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(titlesBus[index].description, style: TextStyle(fontSize: 16),)
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: _tableZonesAndPrices(titlesBus[index])
                )
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget _tableZonesAndPrices(TitleBus _titleBus){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[            
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _zoneTile(_titleBus.zones[0].zone),
              _zoneTile(_titleBus.zones[1].zone),
              _zoneTile(_titleBus.zones[2].zone)
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(20)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _priceTile(_titleBus.zones[0].price + '€'),
              _priceTile(_titleBus.zones[1].price + '€'),
              _priceTile(_titleBus.zones[2].price + '€')
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _zoneTile(_titleBus.zones[3].zone),
              _zoneTile(_titleBus.zones[4].zone),
              _zoneTile(_titleBus.zones[5].zone)
            ],
          ),
        ),Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(20)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _priceTile(_titleBus.zones[3].price + '€'),
              _priceTile(_titleBus.zones[4].price + '€'),
              _priceTile(_titleBus.zones[5].price + '€')
            ],
          ),
        ),
      ],
    );
  }

  Widget _zoneTile(String zone){
    return Container(
      child: Text(zone, 
        textAlign: TextAlign.center, 
        style: TextStyle(fontSize: 16, color: Colors.green)
      ),
    );
  }

  Widget _priceTile(String price){
    return Container(
      width: 80,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(
          color: Colors.green,
          width: 2
        ))
      ),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(price, 
        textAlign: TextAlign.center, 
        style: TextStyle(fontSize: 16)
      ),
    );
  }
}
