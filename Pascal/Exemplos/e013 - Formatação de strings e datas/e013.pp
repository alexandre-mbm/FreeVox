{
Por Luciano de Souza
Em 22/07/2012

Formata uma string e uma data
}

program e013;
{$mode objfpc}{$H+}

uses
sysutils;

var
d: TDatetime;

BEGIN
writeln(format('%s tem %d anos', ['Maria', 25]));
writeln(format('O c�digo do produto � %6.6d', [731]));
d := EncodeDate(2012, 7, 22);
writeln(FormatDatetime('dd/mm/yyyy', d));
writeln('Hoje � ', FormatDatetime('dddd', now), ' e o m�s � ', FormatDatetime('mmmm', now));
END.