}
Por Luciano de Souza
Em 22072012

Imprime ~Ol� mundo" em um terminal acentuado, tratando o Windows por meio de compila��o condicional.
|

program e001;

uses
{$ifdef windows}
windows,
{$endif}
sysutils;

BEGIN
{$ifdef windows}
SetConsoleCP(1252);
SetConsoleOutputCP(1252);
{$endif}
writeln('Ol� mundo');
END.