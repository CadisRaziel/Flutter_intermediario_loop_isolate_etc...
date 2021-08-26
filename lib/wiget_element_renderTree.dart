import 'package:flutter/material.dart';

class WidgElementRenderTree extends StatefulWidget {
  const WidgElementRenderTree({ Key? key }) : super(key: key);

  @override
  _WidgElementRenderTreeState createState() => _WidgElementRenderTreeState();
}

class _WidgElementRenderTreeState extends State<WidgElementRenderTree> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}

//======================== RenderObject e RenderBox =========================================================================
//? Processos caros -> posicionamento, momento que pinta a tela
//*RenderObject -> Primeira abstração direta as apis do Skia, Responsavel pelos processos caros, Alta complexidade
//*Skia -> Desenho para pintar as telas

//*RenderBox -> Abstrai conceitos do RenderObject, Restrições para baixo com BoxContrainst, Baixa complexidade
//? resumindo com RenderObject e RenderBox conseguimos construir um widget do zero
//===========================================================================================================================



//============================= 1º Arvore -> de widgets ========================================================================
//*Imutabilidade -> s os Widgets são imutaveis !

//*Widget Tree 
//? Exemplo:
/*
  Container(
    color: Colors.red, //? -> Dentro do colors temos uma classe chamada 'ColoredBox' que tem um child 'color:' (ele tem uma logica que verifica se a cor foi aplicada)
    child: Row(
      children: [
        Image(), //? -> Dentro da image temos uma classe chamada 'RawImage' dentro dela tem um child que tem uma logica para ver se foi colocado imagem ou nao
        Text('Any'). //? -> Dentro da image temos uma classe chamada 'RichText' dentro dela tem um child que tem uma logica para ver se foi colocado texto ou nao
      ]
    )
  )
*/
//*Resumindo uma arvore de widget é imutavel, ela não sofre alteração, e sim é jogado tudo fora e renderizado novamente (reconstruida constantemente)
//*Caso altere algo como a cor, o flutter joga a arvore toda fora e reconstroi ela com a nova cor, com isso ele permanece com a imutabilidade
//===========================================================================================================================


//============================= 2º Arvore -> Element Tree ====================================================================

//*Arvore de elementos(Element Tree) -> faz o meio de campo entre a arvore de widgets e de renders,
//*quando um widget sofre uma alteração ela que informa a arvore de render qual propriedade precisa ser atualizada(canUpdtate),
//*E quando o widget não sobre alteração e a arvore é atualizada, ele mantem o Render existente.
//*CanUpdate -> responsavel por informar os widgets que sofreram alterações

//*ComponentElement -> um hospedeiro para outros elementos, um exemplo (container, row, columns etc..) [é o que a gente nao visualiza]

//*RenderObjectElement -> participa das fases de layout ou pintura [é o que a gente visualiza na tela]
//===========================================================================================================================


//============================= 3º Arvore -> Render Tree ====================================================================
//*Render tree -> é a arvore mais pesada dos processos, ela trabalha somente com os RenderObejctElement (processos visuais)
//*Ela faz o processo de criação da UI, Pintura da tela com o Skia
//* Ou seja tudo que é processo caro e lento, ela quem faz

//*Sempre que possivel o flutter utiliza a Render Tree existente(ele tenta sempre utilizar [e por isso que a arvore de wigets é imutavel])


//TODO OBS: todo container, text, image etc... É CRIADO UM ID ESPECIFICO QUE O FLUTTER USA PARA EVITAR FAZER ALTERAÇÕES DESNECESSARIAS


//TODO COM ISSO VIMOS QUE PARA UMA APLICAÇÃO PEQUENA/MEDIA porte que nao tem muita atualização o SETSTATE é SIMPLES E PERFEITO
