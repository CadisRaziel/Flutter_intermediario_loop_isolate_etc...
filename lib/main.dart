import 'dart:async';

void main() {
  //*a função main é sincrona
  //* esse exemplo é para demonstrar o loop de eventos do flutter
  //* ele separa em dois blocos os 'events' e os 'microtask'
  //? events -> Responsavel pelas tarefas: Assincrona, futures, Temporizador, Gestos, Desenhos, Streams (Processos pesados)
  //? microTasks -> Responsavel pelas tarefas: Sincronas de curta duração, Funções simples (ocorre no inicio e no final) (Processos Leves)
  print('Main Primeiro');
  scheduleMicrotask(() => print('Micro task 1 '));

  //? importante, as vezes o Delayded não leva 1 segundo como especificamos aqui
  //? ele pode levar alguns micro segundos ou segundos a mais porque o dart não sabe o tempo fixo exato que as tarefas antes/entre dele vai ser executada
  Future.delayed(Duration(seconds: 1), () => print('Future delay 1'));

  Future(() => print('Future 2'));
  Future(() => print('Future 3'));


  scheduleMicrotask(() => print('Micro task 2 '));

  print('Main Final');


  //! Resumo do resultado acima
  //* 1º -> print('Main Primeiro'); **MicroTask** | **Sequencial**
  //* 2º -> print('Main Final'); **MicroTask** | **Sequencial**
  //* 3º -> scheduleMicrotask(() => print('Micro task 1 ')); **MicroTask**
  //* 4º -> scheduleMicrotask(() => print('Micro task 2 ')) **MicroTask**
  //* 5º -> Future(() => print('Future 2')); **Event**
  //* 6º -> Future(() => print('Future 3')); **Event**
  //* 7º -> Future.delayed(Duration(seconds: 1), () => print('Future delay 1')); **Event**

  //TODO Lembrando que a fila acima o PRIMEIRO que entra é o PRIMEIRO que sai !!!
}

//* Outro exemplo
//! main2 porque ja criei o main acima
void main2() async {
  metodoA();
  await metodoB();
  await metodoC('main');
  metodoD();
}

void metodoA(){
  print('Metodo A');
}

metodoB() async {
  print('Metodo B iniciou');
  await metodoC('B');
  print('Metodo B terminou');
}

metodoC(String from) async {
  print('C iniciou em $from');

  Future(() => {
    print('C esta rodando em $from')
  }).then((_) => {
    print('C terminou a future em $from')
  });

  print('C terminou em $from');
}

metodoD() {
  print('Metodo D');
}

  //! Resumo do resultado acima (rode esse codigo no DartPad !!)
//* 1º -> Metodo A
//* 2º -> Metodo B iniciou
//* 3º -> C iniciou em B
//* 4º -> C terminou em B
//* 5º -> Metodo B terminou
//* 6º -> C iniciou em main
//* 7º -> C terminou em main
//* 8º -> Metodo D
//* 9º -> C esta rodando em B
//* 10º -> C terminou a future em B
//* 11º -> C esta rodando em main
//* 12º -> C terminou a future em main


