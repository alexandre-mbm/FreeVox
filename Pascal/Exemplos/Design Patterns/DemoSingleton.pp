{$mode objfpc}
{$h+}

program DemoSingleton;

uses SysUtils, Classes, Calculadora;

var
	Instancia1: TCalculadora;
	Instancia2: TCalculadora;
	Instancia3: TCalculadora;
begin
	WriteLn('Exemplo de Singleton.');
	{
		Ser�o criadas 3 instancias da classe Calculadora
		mas na verdade as 3 vari�veis apontam para uma instancia unica
		demonstrando o funcionamento do Singleton;
	}
	
	Instancia1 := TCalculadora.Create;
	Instancia2 := TCalculadora.Create;
	Instancia3 := TCalculadora.Create;
	
	{
		Fazemos algumas opera��es com a Instancia1
	}
	
	Instancia1.Somar(5);
	Instancia1.Somar(10);
	Instancia1.Somar(15);
	
	{
		Vamos imprimir o valor das 3 instancias
		Voce notar� que  nos 3 casos o resultado� o mesmo
	}
	
	WriteLn('Valor da Instancia 1: ' + IntToStr(Instancia1.Valor));
	WriteLn('Valor da Instancia 2: ' + IntToStr(Instancia2.Valor));
	WriteLn('Valor da Instancia 3: ' + IntToStr(Instancia3.Valor));
	
	WriteLn('Pressione ENTER para sair');
	ReadLn();
	
end.