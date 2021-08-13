import 'package:flutter/material.dart';

import '1_exemplo_classe_isolate.dart';



class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  var isolate = IsolateExample();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            //? StreamBuilder -> Objeto que fica escutanado as mudanças da minha stream, assim que tiver uma mudança ele muda automaticamente
            StreamBuilder<Object?>(
                stream: isolate.portResultListener,
                initialData: 0,
                builder: (context, snapshot) {
                  _counter = snapshot.data as int;
                  return Text(
                    '${_counter.toString()}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () => isolate.increment(_counter),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () => isolate.decrement(_counter),
            tooltip: 'Decrement',
            child: Icon(Icons.minimize),
          ),
        ],
      ),
    );
  }
}
