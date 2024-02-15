import "dart:io";
import "dart:convert";

saudacao() {
  stdout.write("Digite seu nome: ");
  String nome = stdin.readLineSync()!;
  print("Olá, seja bem vindo, $nome");
}

void main() {
  bool voltar = false;
  saudacao();

  do {
    stdout.write(
      "Qual operação deseja executar?\n1 - Adicionar produto à lista\n2 - Apagar produto da lista pelo nome\n3 - Listar itens\n4 - Voltar\n");
    String opcao = stdin.readLineSync()!;
    switch (opcao) {
      case '1':
        salvarListaNoArquivo(lista);
        break;
      case '2':
        stdout.write("Digite o nome do produto que deseja excluir: ");
        String produtoD = stdin.readLineSync()!;
        bool estaNaLista = lista.contains(produtoD);
          if (estaNaLista) {
            removerDaListaEArquivo(lista, '$produtoD');
            break;
          } else {
            print("Não foi possível localizar o produto");
            break;
          }
      case '3':
        print(lista);
        break;
      case '4':
        voltar = true;
        break;
      default:
        print("Opção inválida");
    }
  } while (!voltar);
}

// Salva a lista no arquivo
List<String>? carregarListaDoArquivo() {
  try {
    File arquivo = File('minha_lista.txt');
    if (arquivo.existsSync()) {
      String conteudo = arquivo.readAsStringSync();
      List<dynamic> listaJson = json.decode(conteudo);
      List<String> lista = listaJson.cast<String>();
      return lista;
    }
  } catch (e) {
    print('Erro ao carregar a lista do arquivo: $e');
  }
  return null;
}

void salvarListaNoArquivo(List<String> lista) {{

    stdout.write("Digite o nome do produto: ");
    String produto = stdin.readLineSync()!;
    lista.add(produto);
  }
  try {
    File arquivo = File('minha_lista.txt');
    String conteudo = json.encode(lista);
    arquivo.writeAsStringSync(conteudo);
    print('Lista salva com sucesso.');
  } catch (e) {
    print('Erro ao salvar a lista no arquivo: $e');
  }
}

void salvarListaNoArquivoAoDeletar(List<String> lista) {
  try {
    File arquivo = File('minha_lista.txt');
    String conteudo = json.encode(lista);
    arquivo.writeAsStringSync(conteudo);
  } catch (e) {
    print('Erro ao salvar a lista no arquivo: $e');
  }
}

void removerDaListaEArquivo(List<String> lista, String elementoParaRemover) {
  // Remove o elemento da lista
  lista.remove(elementoParaRemover);
  // Salva a lista atualizada no arquivo
  salvarListaNoArquivoAoDeletar(lista);
  print('Elemento removido da lista e arquivo.');
}

List<String> lista = carregarListaDoArquivo() ?? [];