unit Financiamento.Service;

interface

uses
  Spring.Container,
  Spring.DesignPatterns,
  System.SysUtils,
  System.Generics.Collections,
  IIFinanciamento.Service, Financiamento.Model, Financiamento.Types, IIFinanciamento.PagamentoUnico;

type
  TFinanciamentoService = class(TInterfacedObject, IFinanciamentoService)
  private
    const
      FMinimoParcelas: Integer = 1;
      FMaximoParcelas: Integer = 24;
      FTaxaMinimaJuros: Integer = 1;
      FTaxaMaximaJuros: Integer = 100;
    var
      FQuantidadeParcelas: Integer;
      FCapital: Currency;
      FTaxaJuros: Currency;
      FParcela: Integer;
      FTotalDevedor: Currency;
  public
    constructor Create(const aTipoFinanciamento: TTipoFinanciamento; const aCapital: Currency; const aQuantidadeParcelas: Integer; const aTaxaJuros: Currency);
    function Financiamento(const aTipo: TTipoFinanciamento): IFinanciamentoBase;
  end;

implementation

{ TFinanciamentoService }

constructor TFinanciamentoService.Create(const aTipoFinanciamento: TTipoFinanciamento; const aCapital: Currency;const aQuantidadeParcelas: Integer; const aTaxaJuros: Currency);
var
  LFinanciamento: TFactoryMethod<IFinanciamentoBase>;
begin
  Assert(acapital > 0, 'Informe um valor positivo para o capital.');
  Assert(aQuantidadeParcelas >= FMinimoParcelas, Format('O m�nimo de parcelas � %d.', [ FMinimoParcelas ]));
  Assert(aQuantidadeParcelas <= FMaximoParcelas , Format('O m�ximo de parcelas � %d.', [ FMaximoParcelas ]));
  Assert(aTaxaJuros >= FTaxaMinimaJuros, Format('O m�nimo de juros � %d.', [ FTaxaMinimaJuros ]));
  Assert(aTaxaJuros <= FTaxaMaximaJuros, Format('O m�ximo de juros � %d.', [ FTaxaMaximaJuros ]));

  FCapital            := aCapital;
  FQuantidadeParcelas := aQuantidadeParcelas;
  FTaxaJuros          := aTaxaJuros;
  FParcela            := 0;
  FTotalDevedor       := aCapital;
end;

function TFinanciamentoService.Financiamento(const aTipo: TTipoFinanciamento): IFinanciamentoBase;
begin
  case aTipo of
    tfPagamentoUnico: Result := GlobalContainer.Resolve<IFinanciamentoPagamentoUnico>;
  end;
end;

end.
