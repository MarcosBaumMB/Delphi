unit USubstitui;

interface

uses
  UISubstitui, System.SysUtils;

type
  TSubstitui = class(TInterfacedObject, ISubstitui)
  public
    function Substituir(const aStr, aVelho, aNovo: String): String;
  end;

implementation

//Fun��o utilizada para substituir parte de uma string por outra.
//Par�metros: 
//  aStr: � a string que sofrera itera��o para ser substituido parte de suas palavras.
//  aVelho: � a string que ser� procurada em aStr para ser substitu�da
//  aNovo ser� adicionada ao restultado quando for encontrada a entrada aVelho na aStr
function TSubstitui.Substituir(const aStr, aVelho, aNovo: String): String;
var
  strAddToResult,
  strTemp: string;
  iPosInicio,
  iPosFim,
  iTemp,
  iQtdIncrementar,
  I: Integer;
begin
  try
    if (aStr.Length < aVelho.Length) then
      Exit(aStr);

    Result := '';
    iPosInicio := 1;
    iPosFim := aStr.Length +1;
    while (iPosInicio < iPosFim) do
    begin      
      strAddToResult  := aStr[iPosInicio];
      iQtdIncrementar := 1;

      if aStr[iPosInicio] = aVelho[1] then
      begin
        strTemp := EmptyStr;
        iTemp := iPosInicio;
        for I := 1 to aVelho.Length do
        begin
          strTemp :=  Concat(strTemp, aStr[iTemp]);
          Inc(iTemp)
        end;
        if strTemp = aVelho then
        begin
          strAddToResult := aNovo;
          iQtdIncrementar := aVelho.Length;
        end;        
      end;
      
      Result := Concat(Result, strAddToResult);
      Inc(iPosInicio, iQtdIncrementar);
    end;
  except
    on E: Exception do
    begin
      E.Message := Concat('Ocorreu um erro durante o processamento da frase.', sLineBreak,
        'Detalhes: ', E.Message);
      raise;
    end;
  end;
end;

end.

