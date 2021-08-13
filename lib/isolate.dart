//! Lembre-se Quando mais ISOLATE, mais memoria do dispositivo sera consumida

//* Isolate -> Assim que a aplicação é inicializada ela aloca uma zona de memoria especifica pro nosso app rodar
//* é muito parecido com uma Thread, porém os dois tem diferença na forma de implementar

//* Importancia do Isolate -> Responsavel por gerencia toda a aplicação, memoria, o que sera rodado e o que não sera
//* tem um loop de evento, cada isolate tem o seu proprio loop

//* Caracteristicas -> Somente 1 isolate por padrão. zona de memoria individual, sem preocupação com GC, Event loop proprio,
//* função de processar eventos, é possivel criar mais de 1 isolate, comunicação via mensagem(ports), 2 formas de criação

//? Garbage Collection 'GC' -> é uma feature que outras linguagens mult-Thread precisam se preocupar quando fazer bloqueio de memória,
//? porém o flutter é single-Thread então não precisamos nos preocupar e com isso não precisamos se preocupar com a limpeza de memoria por conta do unico isolate

//* A criação de um novo isolate é para casos extremamentes especificos, não podemos sair criando para qualquer coisa

//! criando um isolate (existe outras formas, porém essa forma é a mais completa)

import 'dart:isolate';

import 'package:flutter/foundation.dart';

//*criamos a porta para escutar o isolate
ReceivePort? receivePort;

//*Metodo de criação do isolate
void createIsolate() async {
  var receivePortIso = receivePort;
  receivePort = ReceivePort();

//*Isolate.spawn -> para criar o isolate passamos como parametro a função que ira processar dentro do isolate
//*e a porta para qual deve ser respondido (é aqui que o isolate esta sendo criado)
  if (receivePortIso != null) {
    await Isolate.spawn(sendTO, receivePortIso.sendPort);

    //*Passamos a escutar a porta do nosso isolate e efetuamos o print do resultado
    receivePortIso.listen((dynamic message) {
      print('Mensagem from Isolate: $message');
    });
  }
}

//*função que processa uma logica dentro do isolate(pelo exemplo ela deve ser static)
void sendTO(SendPort sendPort) {
  sendPort.send('in isolate');
}


//! criando um isolate de forma simplificada (menos usada)
//? Utilizando o metodo 'Compute' ele cria toda a logica de um isolate e executa nossa função dentro dela

//*Criar o isolate com o 'compute' e passa a função que sera executada dentro do isolate e o parametro necessario
void criarIsolate() async {
  var result = await compute(logicProcessIsolate, 'param');
  print(result);
}

//*essa função no exemplo é static
String logicProcessIsolate(String param) {
  return '$param in isolate';
}