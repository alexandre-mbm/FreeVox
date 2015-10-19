# Git

O objetivo deste documento é fornecer aos leitores informações necessárias para uso inicial do git. Para melhor compreensão do git, alguns conceitos precisam ser entendidos.

## O que é um sistema controlador de versões?

É um sistema que guarda a história de todas as manutenções feitas em um conjunto de arquivos, permitindo que o estado desse conjunto de arquivos possa ser revertido para um outro estado. Isso significa dizer que o conteúdo do conjunto de arquivos pode ser restaurado para um ponto anterior ao atual. O sistema controlador de versões mantém registro de todas as atualizações, o que permite que as atualizações possam ser desfeitas. São ainda mantidas pelo sistema informações de quem fez as alterações, bem como a natureza das mesmas.

O conjunto de arquivos e o histórico das manutenções são armazenados e mantidos pelo sistema controlador de versões em uma estrutura de dados chamada repositório.

## Tipos de controlador de versões

Existem duas categorias de sistemas de controle de versões: centralizados e distribuidos.

Os centralizados armazenam o repositório em uma unica máquina, onde todos os usuários se conectam ao mesmo para submeter as alterações.

Nos sistemas distribuidos, cada usuário possui uma cópia do repositório e as alterações são submetidas localmente. O usuário pode empurrar essas alterações para repositórios de outros usuarios, ou ainda outros usuarios podem puxar essas alterações.

Naturalmente as operações de empurrar e puxar alterações precisam de autorização.

O git é um sistema controlador de versões a exemplo do subversion, mas enquanto o subversion está na categoria dos sistemas centralizados, o git está na categoria dos sistemas distribuidos.

## Configuração

Agora que já sabemos o que é um sistema controlador de versões, o que é um repositório e o que é o git, podemos começar a sujar as mãos. Inicialmente usaremos apenas um repositório local, mas tudo que vamos aprender nessa parte do tutorial poderá ser aplicado quando estivermos utilizando repositórios remotos.

Lembre-se de que tudo que é feito no git é primeiramente feito na cópia local do seu repositório e depois propagado para outros repositórios.

Os exemplos mostrados neste tutorial são executados em uma máquina com o **Ubuntu 12.04** instalado, mas devem funcionar sem problemas em ambiente Windows ou em ambiente Mac.

### Instalação em Windows

git, da maneira que é ensinando neste tutorial, trabalha em modo texto, o que significa dizer que em ambiente Windows seria o caso de utilizar o Prompt de Comando.

Para instalar o git na sua máquina Windows, você deve acessar [git-for-windows.github.io](https://git-for-windows.github.io/) e baixar o arquivo sugerido, na versão mais recente que encontrar. O instalador implantará na sua máquina o git e ferramentas básicas de sistemas Unix, tal como a shell Bash, que é como um Prompt de Comando. Um atalho "Msys" será criado no menu iniciar, dentro da pasta Programas. Todos os comandos do seu Windows estarão disponníveis naquela shell, e mais o git e alguns comandos portados de  ambientes _unix-like_ tais como Mac OS e GNU/Linux.

### Instalação em Mac

Para instalar o git no Mac, a forma mais simples é usando o instalador que é [disponibilizado](http://code.google.com/p/git-osx-installer/downloads/list?can=3&q=&sort=-uploaded&colspec=Filename+Summary+Uploaded+Size+DownloadCount) pelo projeto **git-osx-installer**. Baixe a versão mais recente e execute o arquiv o .PKG.

Opcionalmente você poderá lançar mão de um gerenciador de pacotes tal como o homebrew ou o macports. Poderá utilizá-los para instalar o git com muito mais praticidade, desde que você tenha instaladas as "ferramentas de desenvolvedor" da Apple.

### Instalação em GNU/Linux

Em ambiente GNU/Linux que seja derivado da distribuição Debian, você deverá executar o seguinte comando:

```sh
sudo apt-get install git-core
```

### Compilar?

Em Mac ou GNU/Linux, e mesmo em Windows, se você for suficientemente louco para tal, você pode compilar o git. O código fonte você obtém com o projeto [git-core](http://code.google.com/p/git-core/downloads/list).

### Versão do git

Uma vez instalado o git, vamos verificar se a instalação está OK. Para tal, digite o seguinte comando:

```console
$ git version
git version 1.7.9.5
```

É possível que a versão do git em seu sistema seja da versão apresentada no exemplo acima. Isso não tem muito importância, não deverá ser um problema. Pois os comandos ensinados neste material são simples e rotineiros, provavelmente compatíveis com qualquer versão de git existente.

### Identidade do usuário

O próximo passo é informar ao git um nome de usuário e um e-mail. Essas informações serão utilizadas pelo git para ele identificar o autor das manutenções que são feitas no conjunto dos arquivos gerenciados. As configurações podem valer globalmente, para todos os repositórios, ou individualmente, para um único repositório.

O procedimento é feito executando-se os seguintes comandos:

```sh
git config --global user.name "José Vilmar Estácio de Souza"
git config --global user.email "vilmar@informal.com.br"
```

Observe que o nome do usuário e o e-mail estão entre aspas duplas, pois são valores. E que existem dois hífens antes da palavra global, porque ela é uma opção do comando.

Para checar se a configuração está correta, faça como a seguir:

```console
$ git config --list
user.name=José Vilmar Estácio de Souza
user.email=vilmar@informal.com.br
```

A opção `--global` indica que todos os repositórios estarão configurados para o mesmo nome de usuário e o mesmo e-mail. Caso você queira ou precise configurar um e-mail e/ou nome de usuário diferente para algum de seus repositórios, você pode fazer um `cd` para a pasta do repositório, e executar os comandos de configuração sem a opção `--global`.

## Uso

Agora que já temos o git instalado e configurado, está na hora de criar o nosso primeiro repositório e colocar nele alguns arquivos.

### Clone de repositório local

O repositório pode ser criado fazendo-se um _clone_ de um repositório já existente, ou então a partir de uma pasta local da máquina do usuário. Se optarmos pela primeira opção, fazer um _clone_ de um repositório já existente, este pode estar na máquina de quem está criando o repositório ou em uma máquina remota. Vamos começar pela segunda opção: criar o repositório a partir de uma pasta existente na máquina local do usuário.

Crie uma pasta de nome `repo1` e coloque nela dois arquivos: `a.txt` e `b.txt`. Os dois arquivos podem ter qualquer conteúdo.

Usando a linha de comandos, mude-se para essa pasta e execute o seguinte:

```console
$ git init
Initialized empty Git repository in /home/vilmar/repo1/.git/
```

Uma coisa a ser notada é que o comando vai criar uma pasta chamada `.git` dentro da pasta `repo1`. Essa nova pasta será utilizada pelo git para armazenar todas as informações relacionadas ao repositório, além das atualizações.

Outra coisa que deve ser dita é que o comando `git init` não coloca nenhum arquivo no repositório, apenas o cria. É função do usuário informar ao git quais são os arquivos e diretórios que serão incluidos no repositório. O fato de um arquivo estar presente na pasta de um repositório não o inclui automaticamente nesse repositório.

Para complicar um pouco mais, o mesmo vale para as alterações feitas nos arquivos. Suponha que o arquivo `a.txt` já esteja incluido no repositório, e que eu decida efetuar uma alteração nesse arquvo. Após essa alteração eu terei de informar ao git que a alteração deve ser incluida no repositório também.

### Gravando alterações

O processo de adicionar arquivos, pastas e alterações ao repositório é feito em duas fases.

Na primeira fase vamos usar o comando `git add` para marcar as  alterações que serão incluidas no repositório. A essa fase damos o nome de _staging_.

Na segunda fase vamos usar o comando `git commit` para que as modificações feitas na fase anterior sejam efetivadas no repositório. A essa fase damos o nome de _committing_.

Uma coisa importante que precisa ser dita é que o repositório possui 3 áreas lógicas.

A primeira é chamada de _working tree_ e contém todos os arquivos do repositório. É a área utilizada pelo usuário para editar os arquivos.

A segunda área é chamada de _index_ e contém uma fotografia de todos os arquivos do projeto. É nela que os arquivos adicionados pelo comando `git add` são colocados.

A terceira é a área que guarda os commits feitos no repositório.

Vamos a um exemplo prático utilizando o repositório criado anteriormente.  Lembrando que os comandos devem ser executados no prompt de comandos.

Inicialmente vamos perguntar ao git qual é a situação atual, e para tal vamos utilizar o comando `git status`:

```console
Git status
# On branch master 
# 
# Initial commit 
# 
# Untracked files: 
#   (use "git add <file>..." to include in what will be committed) 
# 
#	a.txt 
#	b.txt 
nothing added to commit but untracked files present (use "git add" to track) 
```

Olhando para a resposta do comando, temos algumas informações bastante interessantes:

```
# Untracked files:
```

Esta linha nos informa que existem arquivos modificados, mas que essas modificações ainda não estão sob controle do git. Os arquivos estão modificados na nossa _working tree_ mas ainda não foram adicionados ao _index_.

```
#   (use "git add <file>..." to include in what will be committed)
```

Esta linha nos informa que devemos utilizar o comando `git add` para que essas modificações sejam incluidas no próximo commit, ou seja, adicionadas ao index.

```
#	a.txt
#	b.txt
```

As duas linhas anteriores informam quais são os arquivos modificados e que ainda não foram incluidos no próximo commit.

Podemos então usar o comando `git add a.txt b.txt` para incluir os dois arquivos. Se apenas quisermos incluir as modificações feitas no arquivo `a.txt`, usamos o comando `git add a.txt`.

Uma forma rápida de incluir todas as modificações é usar o comando `git add .`. Mas é preciso ter cuidado, pois você pode acabar incluindo mais do que deseja. Para evitar inclusões indesejadas especifique os arquivos no comando.

```console
$ git add a.txt b.txt
Git status
# On branch master 
# 
# Initial commit 
# 
# Changes to be committed: 
#   (use "git rm --cached <file>..." to unstage) 
# 
#	new file:   a.txt 
#	new file:   b.txt 
#
```

Repare na resposta dada pelo comando `git status` após o comando `git add`:

```
# Changes to be committed: 
```

A resposta nos informa que existem alterações que devem ser aplicadas no repositório. "Changes to be committed:". Na prática, as alterações estão na área chamada de _index_. O próximo passo é fazer o commit dessas alterações, e para tal, vamos utilizar o comando `git commit`:

```sh
git commit -m "primeiro commit"
```

Repare que no comando usei a opção `-m`, de mensagem, e um texto entre aspas. O texto será armazenado no repositório e serve para descrever o motivo do commit. Uma boa prática é usar descriçoes coerentes com o motivo do commit.

Caso a opção `-m` não seja utilizada, o git vai invocar um editor de texto para que o usuário possa editar a descrição do commit. (não sei qual editor será utilizado no windows)

A resposta do comando `git commit` é parecida com o que se segue:

```
[master (root-commit) bc75312] primeiro commit 
 0 files changed 
 create mode 100644 a.txt 
 create mode 100644 b.txt 
```

Vamos analisar a resposta linha linha.

```
[master (root-commit) bc75312] primeiro commit
bc75312 é o identificador do commit.
```

Para quem conhece o subversion, esse identificador é equivalente ao número da revisão. Ele é um Sha1 gerado a partir do conteúdo do commit e utiliza 40 dígitos hexadecimais para representar, embora a mensagem só tenha mostrado 7 digitos. Mais adiante veremos na prática para que servem esses identificadores.

```
 0 files changed
 create mode 100644 a.txt
 create mode 100644 b.txt 
```

As três linhas anteriores nos informam que nenhum arquivo foi alterado e que dois arquivos foram criados.

Veja a resposta do comando `git status` após o commit:

```console
$ git status

# On branch master 
nothing to commit (working directory clean) 
```

A área está limpa e não existe nenhum commit para ser feito. Todas as alterações estão no repositório e não existem alterações pendentes.

Vamos agora alterar o conteúdo do arquivo `a.txt` para começar o processo de uma nova modificação. Incluirei nesse arquivo uma nova linha. Veja a resposta do comando `git status` após essa modificação:

```
Git status
# On branch master 
# Changes not staged for commit: 
#   (use "git add <file>..." to update what will be committed) 
#   (use "git checkout -- <file>..." to discard changes in working directory) 
# 
#	modified:   a.txt 
#
no changes added to commit (use "git add" and/or "git commit -a")
```

Olhando para a resposta, podemos notar que o git nos informa a existência de alterações ainda não marcadas para entrarem no próximo commit. As alterações estão presentes na nossa _working tree_.

Vamos fazer o que o git nos sugere: adicionar essas alterações para que elas entrem no próximo commit.

```console
$ git add a.txt
$ git status

# On branch master 
# Changes to be committed: 
#   (use "git reset HEAD <file>..." to unstage) 
# 
#	modified:   a.txt 
# 
```

A resposta nos mostra que existem alterações que devem ser efetivadas no próximo commit e que o arquivo modificado é o `a.txt`. As alterações estão na área chamada de _index_.

Existem outras informações importantes que veremos mais adiante.

Vamos agora ver o que acontece se alterarmos o arquivo `b.txt` antes de fazer o commit das alterações feitas no arquivo `a.txt`. Como sempre, o comando `git status` será o nosso amigo:

```console
$ git status
# On branch master 
# Changes to be committed: 
#   (use "git reset HEAD <file>..." to unstage) 
# 
#	modified:   a.txt 
# 
# Changes not staged for commit: 
#   (use "git add <file>..." to update what will be committed) 
#   (use "git checkout -- <file>..." to discard changes in working directory) 
# 
#	modified:   b.txt 
# 
```

Vamos dividir a resposta em duas partes:

```
# Changes to be committed: 
#   (use "git reset HEAD <file>..." to unstage) 
# 
#	modified:   a.txt 
```

Existem alterações esperando por um commit e o arquivo em questão é o `a.txt`. Essas alterações estão presentes na área chamada de _index_.

```
# Changes not staged for commit: 
#   (use "git add <file>..." to update what will be committed) 
#   (use "git checkout -- <file>..." to discard changes in working directory) 
# 
#	modified:   b.txt 
# 
```

Existem alterações que ainda não foram marcadas para um commit e o arquivo em questão é o `b.txt`. Essas alterações estão na nossa _working tree_. Tudo isto para dizer que, se executarmos o comando `git commit` nesse momento, apenas as alterações feitas no arquivo `a.txt` serão efetivadas, visto que o commit transfere para o repositório apenas as alterações que estão na área _index_.

Recapitulando:

Para que as alterações feitas sejam colocadas no repositório, precisamos executar dois passos.

1. Informar ao git as alterações a serem consideradas no próximo commit. Usamos para tal o comando `git add`.
2. Informar ao git que o commit deve ser feito. Usamos para tal o comando `git commit`.

Uma coisa que não foi dita antes, mas que pode ser dita agora, é que existe um atalho para executarmos os dois passos com um unico comando. Basta que se inclua no comando `git commit` a opção `-a`. O comando ficaria da seguinte forma:

```console
$ git commit -a -m "alterações no arquivo a.txt e b.txt"
[master 6f2d250] alterações no arquivo a.txt e b.txt 
 2 files changed, 3 insertions(+) 
```

É sempre bom lembrar que um copo vazio está cheio de ar, e que os commits feitos estão apenas no repositório do usuário. O que significa dizer que outros usuários ainda não tem acesso a essas modificações. Mas, conforme já dito, é possível propagar essas modificações para outros usuários, o que será visto mais adiante.

O próximo passo é aprender a identificar o que foi modificado e por quem. Lembre-se que desde que devidamente autorizado, o seu repositório pode ser alterado a partir de outros repositórios da mesma forma que o seu repositório também pode alterar outros repositórios. Além do mais, você vai fazer tantas alterações no seu repositório que em pouco tempo vai se esquecer do que foi feito. Por essas e por outras é muito importante que você documente muito bem o que faz.

Um outro ponto fundamental é que você não misture as modificações. Supondo que a sua aplicação tem dois erros para serem corrigidos, tente proceder da seguinte maneira:

1. Corrija o primeiro erro, teste a correção e faça commit.
2. Corrija o segundo erro, teste a correção e faça commit.

Evite, se possível, colocar as duas correções em um único commit.

O comando que nos mostra quem alterou e a documentação das alterações, é o comando `git log`:

```console
$ git log

commit 6f2d25013af746c5bc062b29e4883ff034c29e6c 
Author: José Vilmar Estácio de Souza <vilmar@informal.com.br> 
Date:   Sat Jul 28 21:09:41 2012 -0300 

    alterações no arquivo a.txt e b.txt 

commit bc75312a17b9c726435740f4aa493017601491db 
Author: José Vilmar Estácio de Souza <vilmar@informal.com.br> 
Date:   Sat Jul 28 19:15:26 2012 -0300 

    primeiro commit 
```

Olhando para essa resposta identificamos que dois commits foram feitos. Conseguimos identificar também o autor dos commits. Identificamos ainda as datas em que os commits foram feitos e um texto que descreve a natureza das alterações. Podemos observar também que cada commit possui um identificador, que é formado por 40 digitos hexa-decimais, algarismos de 0 a 9 e letras de A a F.

Uma pergunta que pode estar passando pela cabeça de quem está lendo esse texto é a seguinte:

> Como é que o git conseguiu identificar o nome e o e-mail do autor dos commits?

A resposta é a seguinte:

```sh
git config --global user.name "José Vilmar Estácio de Souza"
git config --global user.email "vilmar@informal.com.br"
```

Lembram-se desses comandos?

A saída do comando `git log` é um tanto verbosa. Você ouvirá, do último para o primeiro commit, a lista das últimas alterações. Se a alteração que lhe interessa não estiver no topo, é mais provável que prefira ler o log em um arquivo de texto. Neste caso, poderá redirecionar a saída para um arquivo deste modo:

```sh
git log > git.log
```

Nesse caso será gerado um arquivo `git.log` com toda a saída do comando. Isto vale para qualquer comando do git.

Um problema que voce pode ter, é que se voce gerar o arquivo `git.log` dentro da pasta `repo1`, pasta aonde reside o repositório, o git vai te informar que o arquivo `git.log` ainda não foi marcado para fazer parte do próximo commit. Isto acontece porque o arquivo `git.log` agora faz parte da sua _working tree_. Então, se voce usar o comando `git add .` para adicionar todos os arquivos da _working tree_ à área _index_, o arquivo `git.log` será adicionado indevidamente.

Mais adiante veremos que é possível configurar o git para que ele ignore certos arquivos. Poderemos informar ao git, por exemplo, que o arquivo chamado `git.log` nunca será incluido no repositório. Podemos ainda diminuir o tamanho da saída do comando `git log` usando a opção `--pretty=oneline`.

O comando `git log` tem ainda a opção `-p`, que é bastante interessante. A opção mostra o que foi alterado dentro dos arquivos que fazem parte do commit. Atualmente o arquivo `a.txt` possui apenas uma linha com o seguinte conteudo:

```
linha 1
```

Vou alterar esse arquivo colocando um "." no final da primeira linha e acrescentar uma segunda linha. A opção -1 limita a quantidade de commits a ser mostrada:

```console
$git log -p -1

commit e537dc86b66f7ab267597f043ddbb4e0d2c0e0b8 
Author: José Vilmar Estácio de Souza <vilmar@informal.com.br> 
Date:   Sun Jul 29 10:03:55 2012 -0300 

    alteracoes feitas para demonstrar o comando git log com a opcao -p 

diff --git a/a.txt b/a.txt 
index 76b34f2..e459484 100644 
--- a/a.txt 
+++ b/a.txt 
@@ -1,2 +1,3 @@ 
-linha 1 
+linha 1. 
+linha 2 
```

O que temos de novo nessa resposta está a partir das seguintes linhas:

```diff
diff --git a/a.txt b/a.txt 
index 76b34f2..e459484 100644 
--- a/a.txt 
+++ b/a.txt 
@@ -1,2 +1,3 @@ 
-linha 1 
+linha 1. 
+linha 2 
```

Serão mostradas as diferenças introduzidas no último commit, em relação ao anterior.

```diff
-linha 1 
```
Informa que essa linha foi removida.

```diff
+linha 1. 
```
Informa que essa linha foi incluida.

```diff
+linha 2 
```
Informa que essa linha foi incluida.

Criando um repositório a partir de um repositório já existente.

Até agora aprendemos a criar um repositório a partir de uma pasta existente na nossa máquina local, usando o comando `git init`.

A outra forma de se criar um repositório é fazer um clone de um repositório já existente, não importando se o repositório já existente está na máquina local do usuário ou em uma outra máquina qualquer. O comando que utilizaremos para tal é o `git clone`.

Para começar, vamos fazer um clone do repositório `repo1` criado previamente.

1. Crie uma pasta chamada `clone`
2. Faça um `cd` para ela
3. Execute o seguinte comando:
```sh
git clone /home/vilmar/repo1
```

Lembrando que `/home/vilmar/repo1` é o nome da pasta aonde eu criei o meu repositório. Use o nome correto na sua máquina. A resposta deverá ser parecida com o que segue:

```
Cloning into 'repo1'...
done.
```

Dentro da pasta `clone` deve ser criada uma pasta chamada `repo1`, e acredite, é uma cópia do repositório `repo1` criado anteriormente. Para confirmar, faça um `cd` para a pasta `repo1` que está dentro da pasta `clone` e execute o comando `git log`. Depois faça um `cd` para a pasta `repo1` criada anteriormente e também execute o comando `git log`. Compare os dois resultados e verifique que eles são iguais.

Se o repositório a ser clonado estiver em outra máquina que não a sua máquina local, o processo de clone é o mesmo. O que muda é que vamos substituir no comando `git clone` o nome da pasta aonde está o repositório a ser clonado, por uma URL. Para dar um exemplo prático, vamos fazer um clone do repositório Freevox dentro da pasta clone criada anteriormente.

```console
$ git clone https://github.com/magoolation/FreeVox

Cloning into 'FreeVox'...
remote: Counting objects: 65, done.
remote: Compressing objects: 100% (37/37), done.
remote: Total 65 (delta 8), reused 59 (delta 5)
Unpacking objects: 100% (65/65), done.
```

A exemplo do que aconteceu anteriormente,voce vai encontrar dentro da pasta `clone` a pasta `Freevox`.  Faça um `cd` para a pasta Freevox e execute o comando `git log`.

Agora que aprendemos a fazer clones de um repositório, vamos aprender a atualizar o clone a partir do clonado e vice-versa.

Ao processo de atualização de um clone a partir de um clonado vamos dar o nome de _**pull**_. E ao processo de atulização de um clonado a partir de um clone daremos o nome de _**push**_.

Para ajudar na compreensão do processo, criei na minha máquina dois clones do repositório FreeVox. O primeiro reside na pasta `/data/software/freevox/FreeVox`, e o outro reside na pasta `/home/vilmar/clone/Freevox`.

Já fiz também pelo menos um commit no primeiro clone, o que o torna diferente do segundo. Mas ainda não subi esse commit para o repositório central do FreeVox.

A primeira coisa a fazer é ir para a pasta aonde está o primeiro clone do repositório. Para tal, vou executar o seguinte comando na minha máquina:

```sh
cd /data/software/freevox/FreeVox
```

É importante dizer que esse comando não pertence ao git, mas sim ao Linux aonde estou simulando o exemplo.

Agora vou pedir ao git que me mostre os três ultimos commits feitos no repositório. Usarei a opção `--pretty` para diminuir o tamanho da resposta.

```console
$ git log --pretty=oneline  -3
2238e613f3bc7e2a1374fa901ac11be3bc93356b Reforço de mais alguns conceitos
64bbbe7415374f8f7966a758835be1dbf7aba263 Algumas explicações adicionais relacion
a791e320acd452768fa77ddafdd4219f1578b29a Adicionando  2 patterns-amend
```

Farei o mesmo para o segundo clone:

```console
$ cd /home/vilmar/clone/FreeVox
$ git log --pretty=oneline -3

64bbbe7415374f8f7966a758835be1dbf7aba263 Algumas explicações adicionais relacion[m
a791e320acd452768fa77ddafdd4219f1578b29a Adicionando  2 patterns-amend[m
4704639380edf72d339ba12e7956792d89eadd03 Documentação de como fazer clone de rep[m
```

Analisando as duas respostas com atenção, vamos notar que o primeiro commit da primeira resposta não é igual ao primeiro commit da segunda resposta. Notaremos também que o segundo commit da primeira resposta é igual ao primeiro commit da segunda resposta, o que nos mostra que falta um commit no segundo clone.

Para que o commit faltante esteja presente no segundo clone, precisaremos executar dois passos:
1. A partir do primeiro clone, colocar o commit faltante no repositório central do FreeVox.
2. A partir do segundo clone, puxar o commit faltante. Executaremos a seguinte sequência de comandos:
```console
$ cd /data/software/freevox/FreeVox/
$ git push
Username for 'https://github.com': jvesouza
Password for 'https://jvesouza@github.com': 
To https://github.com/magoolation/FreeVox
   64bbbe7..2238e61  master -> master
```

O comando `git push` é responsável por transferir commits presentes no repositório local para o repositório remoto. O comando naturalmente só vai transferir os commits que ainda não estão presentes no central. Após a execução do comando, foram solicitados um login e uma senha.

Uma vez que os commits estão presentes no repositório remoto, posso instruir ao segundo clone que puxe esses commits.

```console
$ cd /home/vilmar/clone/FreeVox/
$ git pull
remote: Counting objects: 7, done.[K
remote: Compressing objects: 100% (1/1)   [K
remote: Compressing objects: 100% (1/1), done.[K
remote: Total 4 (delta 2), reused 4 (delta 2)[K
Unpacking objects:  25% (1/4)   
Unpacking objects:  50% (2/4)   
Unpacking objects:  75% (3/4)   
Unpacking objects: 100% (4/4)   
Unpacking objects: 100% (4/4), done.
From https://github.com/magoolation/FreeVox
   64bbbe7..2238e61  master     -> origin/master
Updating 64bbbe7..2238e61
Fast-forward
 Documentos/git.txt |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)
```

Posso executar o comando `git log` para verificar que todas as alterações estão presentes no segundo clone.

```console
$ git log --pretty=oneline -3
2238e613f3bc7e2a1374fa901ac11be3bc93356b Reforço de mais alguns conceitos[m
64bbbe7415374f8f7966a758835be1dbf7aba263 Algumas explicações adicionais relacion[m
a791e320acd452768fa77ddafdd4219f1578b29a Adicionando  2 patterns-amend[m
```

Com base na resposta do comando `git log`, podemos concluir que a atualização do segundo clone foi feita.

## Utilizando branches

### O que é um branch?

Sabemos que o nosso repositório é composto por um conjunto de commits, e que cada um deles representa um certo momento da coleção de arquivos armazenada no repositório. Temos então uma linha de desenvolvimento que vai crescendo à medida que vamos fazendo novos commits. Agora imagine que vamos precisar de duas linhas de desenvolvimento na nossa coleção de arquivos, sem que uma interfira na outra, e sem termos dois repositórios diferentes.

Para facilitar a nossa compreensão, vamos imaginar o seguinte cenário:

O meu projeto tem dois arquivos, `p1` e `p2`, e é mantido por três usuarios, a, b e c.

Em um dado momento do desenvolvimento, o usuario "a" descobre que o arquivo `p1` tem uma rotina de nome `r1` que pode ser melhorada, embora ele não tenha certeza. Esse usuário resolve modificar a rotina `r1` mas não pode colocá-la no repositório, para que essas modificações não interfiram no resto do desenvolvimento.

O desenvolvimento dos outros elementos do sistema não pode parar à espera de que o usuário "a" termine as modificações da rotina `r1`. E para complicar mais um pouco, o usuario "a" resolve pedir ajuda ao usuário "b", e para que o usuário "b" possa ajudar o usuário "a", as modificações precisam estar no repositório. Nesse momento vamos precisar de duas linhas de desenvolvimento. Uma para as manutenções normais e outra para a manutenção da rotina `r1`, presente no arquivo `p1`.

Vamos utilizar o conceito de branch, que nada mais é do que a criação de uma nova linha para o desenvolvimento.

### Listando e criando branches

Na prática, já trabalhamos por padrão em um branch chamado `master`. Observe a resposta ao comando `git status`:

```console
$ git status
# On branch master
nothing to commit (working directory clean)
```

A primeira linha do comando nos informa que estamos no branch chamado `master`. Esse é o branch padrão.

A criação de um branch é feita pelo comando `git branch`. Para executar o comando devemos estar no branch a partir do qual o novo branch pode ser criado. Sim, é possível criar um branch a partir de outro, lembrando que sempre inicialmente temos o branch `master`.

```console
$ git branch
* master
```

Como podemos ver, o comando acima lista os branches presentes no repositório local. No caso, só existe um branch e o seu nome é `master`. Além disso, o sinal "*" indica que ele é o branch no qual estamos trabalhando.

```sh
git branch rotina-r1
```

Criamos um novo branch e demos a ele o nome de `rotina-r1`.

Agora vamos listar os branches existentes em nosso repositório:

```console
$ git branch
* master
  rotina-r1
```

Repare que agora temos dois branches, um chamado `master` e outro chamado `rotina-r1`. Repare também que o branch chamado `master` é o branch no qual estamos trabalhando. Lembre-se do sinal "*" antes do nome do branch.

### Alternar entre branches

Agora vamos mudar o nosso foco para o branch `rotina-r1`. Isso é feito com o comando `git checkout`.

```console
$ git checkout rotina-r1
Switched to branch 'rotina-r1'
```

Vejamos agora o que nos diz o comando `git status`:

```console
$ git status
# On branch rotina-r1
nothing to commit (working directory clean)
```

A primeira linha da resposta nos informa que o nosso foco é o branch `rotina-r1`.

Vamos executar o comando `git branch`, aquele que mostra os branches existentes no nosso repositório.

```console
$ git branch
  master
* rotina-r1
```

Temos dois branches: `master` e `rotina-r1`. E o branch no qual estamos trabalhando é o `rotina-r1`.

#### Usar o branch, adicionando commits

Agora vamos incluir os arquivos `c.txt` e `d.txt` no branch `rotina-r1`, e depois faremos commit dessas alterações.

Depois de feitas as alterações, executaremos alguns comandos para mostrar como ficou o nosso repositório.

```console
$ git status
# On branch rotina-r1
nothing to commit (working directory clean)
```

A resposta do comando acima mostra que estamos no branch `rotina-r1` e que  não existem alterações pendentes.

#### Visualizar histórico de branch

```console
$ git log --pretty=oneline -3
7a149568f412b4081274ce57ae9b3b2d876044af Inclusao do arquivo d.txt
b813f75553c51b0177ce3d2ca6ab16e71df49267 Inclusão do arquivo c.txt
61ce98b042a2797aedbf5dfecbb4bd67459d479b incluindo mais arquivos
```

Usamos o comando `git log` para listar os três últimos commits feitos nesse branch.

```console
$ ls
a.txt  b.txt  c.txt  d.txt  nada
```

O comando acima não faz parte do git, mas sim do sistema operacional. Ele mostra os arquivos presentes na pasta corrente. Temos os seguintes arquivos: `a.txt`, `b.txt`, `c.txt`, `d.txt` e `nada`. São cinco arquivos.

#### Fazer "checkouts" e comparar históricos de branches

```console
$ git checkout master
Switched to branch 'master'
$ git status
# On branch master
nothing to commit (working directory clean)
```

No exemplo acima, o comando `git checkout` muda para o branch `master`, e o comando `git status` confirma que agora estamos no branch `master`.

```console
$ git log --pretty=oneline -3
61ce98b042a2797aedbf5dfecbb4bd67459d479b incluindo mais arquivos[m
e537dc86b66f7ab267597f043ddbb4e0d2c0e0b8 alteracoes feitas para demonstrar o com[m
6f2d25013af746c5bc062b29e4883ff034c29e6c alterações no arquivo a.txt e b.txt[m
```

Repare que o comando `git log` nos mostra uma sequência diferente de commits.
Os commits que descreviam a inclusâo do arquivo `c.txt` e do arquivo `d.txt` não aparecem mais. Isto acontece porque esses commits foram feitos no branch `rotina-r1` e nós estamos agora trabalhando no branch `master`.

```ls
$ ls
a.txt  b.txt  nada
```

Repare também na resposta do comando `ls`. Ela mostra que só temos os arquivos `a.txt`, `b.txt` e `nada`. São três arquivos. `c.txt` e `d.txt` só estão presentes no branch `rotina-r1`.

#### Resumo

O branch nos permite o desenvolvimento paralelo de duas ou mais versões do nosso sistema. Podemos ter quantos branches quisermos, em nosso repositório. Para criarmos um branch de nome `x` no nosso repositório, usamos o seguinte comando:

```sh
git branch x
```

Para listarmos os branches presentes no nosso repositório, usamos o seguinte comando:

```sh
git branch
```

Para mudarmos o foco para o branch `x`, usamos o seguinte comando:

```sh
git checkout x
```