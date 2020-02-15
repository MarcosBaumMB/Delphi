unit UMaquinaDinheiro;

interface

uses
  System.Classes, System.SysUtils, System.Math,
  UIMaquina, UTroco;

type
  TMaquinaDinheiro = class(TInterfacedObject, Imaquina)
  private
    function ImprimirCabecalhoTroco(const aValor: string): string;
  public
    function MontarTroco(const aTroco: Double): TList;
    function MontarImpressao(const aListTroco: TList; const aValorTotalTroco: Double): TStringList;
  end;

implementation

{ TMaquinaDinheiro }

//  Fun��o para formatar a impress�o do cabe�alho para o troco da m�quina.
function TMaquinaDinheiro.ImprimirCabecalhoTroco(const aValor: string): string;
begin
  Result := Format('A entrada � %s e a sa�da �:', [ aValor ]);
end;

// Fun��o montar troco.. recebe um valor Double e processa as c�dulas/moedas necess�rias para
// dar de troco. Vai retornar a sempre a menor quantidade de c�dulas/moedas poss�veis.
function TMaquinaDinheiro.MontarTroco(const aTroco: Double): TList;
  procedure AddToResult(const aTipoCedula: TCedula; aQuantidade: Integer);
  begin
    Result.Add(TTroco.Create(aTipoCedula, aQuantidade));
  end;
var
  iValorInteiro,
  iValorFracao,
  iQuantidade: Integer;
  aCedula: TCedula;
  fQtd: Double;
begin
  Result := TList.Create;
  Result.Clear;
  iValorInteiro := Trunc(aTroco);
  iValorFracao := Round(Frac(aTroco) * 100);

  for aCedula := TCedula.ceNota100 to TCedula.ceMoeda100 do
  begin
    if (iValorInteiro > 0) then
    begin
      fqtd := (iValorInteiro / aCedula.GetValorStr.ToInteger);
      iQuantidade := Trunc(fQtd);

      if (iQuantidade > 0) then
      begin
        AddToResult(aCedula, iQuantidade);
        Dec(iValorInteiro, (iquantidade * aCedula.GetValorStr.ToInteger));
      end;
    end
  end;

  for aCedula := TCedula.ceMoeda50 to TCedula.ceMoeda1 do
  begin
    if (iValorFracao > 0) then
    begin
      fQtd := (iValorFracao / (aCedula.ToDouble * 100));
      iQuantidade := Trunc(fqtd);
      if (iQuantidade > 0) then
      begin
        AddToResult(aCedula, iQuantidade);
        Dec(iValorFracao, Trunc((iquantidade * aCedula.ToDouble) * 100));
      end;
    end
  end;
end;

//  Fun��o respons�vel por montar a impress�o do troco gerado pela m�quina de dinheiro.
function TMaquinaDinheiro.MontarImpressao(const aListTroco: TList; const aValorTotalTroco: Double): TStringList;
var
  I: Integer;
  cTroco: TTroco;
begin
  Result := TStringList.Create;
  Result.Add(ImprimirCabecalhoTroco(FormatFloat(',0.00', aValorTotalTroco)));

  for I := 0 to aListTroco.Count -1 do
  begin
    cTroco := aListTroco.Items[I];
    Result.Add(Ctroco.Troco);
  end;
  Result.Add(''.PadLeft(80, '-'));
end;

end.
