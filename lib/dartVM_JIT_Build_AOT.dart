//! Como o dart VM executa o código:
//? do código fonte ou binario do Kernel usando JIT(Just in Time)
//? de snapshots AOT e AppJIT.
//* A principal diferença no entando é quando e como a VM converte código dart em executavel


//! Build (principais):
//! Build JIT(just in time)
//? JIT compilação do programa em tempo de execução 
//? Build utilizada em quando desenvolvemos
//? Utiliza compilação incremental (Hot Reload) -> ao usar o hot reaload o código que ja ta compilado e não tem alteração ele é mantido !
//? Fornece métricas ao vivo para o dart DevTools
//? Suporte a depuração
//? Hot reload, Hot restart, Depuração

//! Build (principais):
//! Build AOT(ahead of time) **Executavel**
//? AOT compilação do programa antecipadamente
//? Build utilizada depois do ciclo de desenvolvimento (release)
//? Baixo tempo de inicialização
//? API NDK para arquitetura android (ARM e x86) e API LLVM para arquitetura IOS (ARM)
//* Android(CORE JIT) -> é o mecanismo capaz de pré compilar o código para a arquitetura conforme necessidade,
//* o método de AOT Assembly também esta disponivel para build no android, porém não é o padrao pois seu resultado final acaba sendo muito grande pois engloba todos os suportes e varias arquiteturas
//* Ios(AOT Assembly) -> App Store não permite distribuição dinamica de código binario, isso quer dizer que o código ja vai buildado(AOT),
//* como uma pré configuração de arquitetura e todas as informações necessarias para rodar nos dispositivos ISO com seu respectivo código pré compilado.
