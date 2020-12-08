import 'package:flutter/material.dart';

class HomePanelProvisional extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        HeaderPanel()

      ],
    );
  }
}

class HeaderPanel extends StatelessWidget {

  final radiusPanel = Radius.circular(24);

  @override
  Widget build(BuildContext context) {
    print('Holaaaaaaaaaaaaa');
    return Container(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: radiusPanel, topRight: radiusPanel),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 4))
          ]),
      child: SafeArea(
        child: Column(
          children: [
            Text(
              'PG. FRANCESC MACIÀ / CREU',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500
              ),
            ), 
            Container(
              height: 40,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) => LineBusWidget(number: index.toString()),
              ),
            )
          ],
        ),
      )
    );
  }
}

class LineBusWidget extends StatelessWidget {
  final String number;

  const LineBusWidget({this.number});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        alignment: Alignment.center,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(4)
        ),
        child: Text(number),
      ),
    );
  }
}
