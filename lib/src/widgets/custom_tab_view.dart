import 'package:flutter/material.dart';

class CustomTabView extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder tabBuilder;
  final IndexedWidgetBuilder pageBuilder;
  //Creem el constructor del nostre widget
  CustomTabView({
      @required this.itemCount,
      @required this.tabBuilder,
      @required this.pageBuilder
  });
  //
  @override
  _CustomTabViewState createState() => _CustomTabViewState();
}

class _CustomTabViewState extends State<CustomTabView>
    with TickerProviderStateMixin {
  TabController _controller;
  int _currentCount;
  //S'executa el codi en el moment de crear l'estat.
  @override
  void initState() {
    _controller = new TabController(length: widget.itemCount, vsync: this);
    //Actualitzem el contador
    _currentCount = widget.itemCount;
    //Comprovació
    print('Estic dins del initState del CustomTabView');
    super.initState();
  }

  //
  @override
  void didUpdateWidget(CustomTabView oldWidget) {
    if (_currentCount != widget.itemCount) {
      //Eliminem el controller existent
      _controller.dispose();
      //Actualitzem el valor de _currentCount
      _currentCount = widget.itemCount;
      //Actualitzem l'estat
      setState(() {
        //Tornem a crear el _controller amb les dades actualitzades
        _controller = new TabController(length: widget.itemCount, vsync: this);
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  //El següent codi s'executa quan el widget és eliminat
  @override
  void dispose() {
    //Eliminem el controlador
    _controller.dispose();
    super.dispose();
  }

  //El següent codi retorna el Widget
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: TabBar(
            controller: _controller,
            labelColor: Theme.of(context).accentColor,
            unselectedLabelColor: Theme.of(context).hintColor,
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).accentColor,
                  width: 2,
                ),
              ),
            ),
            tabs: List.generate(
              widget.itemCount,
              (index) => widget.tabBuilder(context, index),
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _controller,
            children: List.generate(
              widget.itemCount,
              (index) => widget.pageBuilder(context, index),
            ),
          ),
        ),
      ],
    );
  }
}