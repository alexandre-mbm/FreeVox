{
Por Luciano de Souza
Em 21/07/2012

Recebe uma express�o regular pela linha de comando e tenta casar com um texto recebido tamb�m pela linha de comando.
}

program e010;
{$mode objfpc}{$H+}

uses
sysutils, regexpr;

var
regex: TRegExpr;
text: string;
i: integer;

BEGIN
regex := TRegExpr.create;
try
text := paramstr(2);
regex.expression := paramstr(0);
if regex.exec(text) then
begin
for i := 1 to regex.SubExprMatchCount do
writeln(regex.match[i]);
end
else
writeln('N�o foi encontrado o padr�o');
finally
regex.free;
end;
END.