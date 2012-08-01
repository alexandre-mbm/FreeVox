{$mode objfpc}
{$h+}

unit Calculadora;

interface
	uses SysUtils, Classes;
	
	Type
		{
			Definimos a nossa classe Singleton
		}
		TCalculadora = class
		private
			FValor: integer;
			{
				Um Singleton tem seu construtor definido como privado de forma a 
				n�o poder ser constru�do fora do escopo da classe.
				Infelizmente este comportamento n�o � respeitado pelo FPC
				por isso damos outro nome ao nosso Construtor
			}
			constructor Init;
		public
			property Valor: integer read FVAlor;
			procedure Somar(AValor: integer);
			{
				Para "enganar" os programadores definimos uma fun��o de classe que
				ir� nos retornar sempre a mesma instancia.
			}
			class function Create: TCalculadora;
		end;
		
	implementation
	
	{
		Aqui definimos uma vari�vel que � vis�vel apenas dentro deste bloco implementation
		com isso n�o sujamos o programa com vari�veis globais e
		s� colocamos o objeto na mem�ria ap�s o primeiro uso
	}
	var
		Singleton: TCalculadora = nil;
		
	{
		Um construtor normal. Chamaos o construtor padr�o de TObject
		e inicializamos o atributo de valor
	}
	constructor TCalculadora.Init;
	begin
		inherited Create;
		FValor := 0;
	end;
	
	{
		Aqui acontece a magica: se a instancia ainda n�o foi inicializada
		a inicializamos e sempre retornamos esse mesmo objeto
	}
	class function TCalculadora.Create: TCalculadora;
	begin
		if Singleton = nil Then
			Singleton := TCalculadora.Init;
		Result := Singleton;
	end;
	
	{
		M�todo simples de soma para demonstrar que a classe est� funcionando
	}
	procedure  TCalculadora.Somar(AValor: integer);
	begin
		Inc(FValor, AValor);
	end;
	
	end.