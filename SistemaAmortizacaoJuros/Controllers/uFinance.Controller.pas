unit uFinance.Controller;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections,
  uInstallment, uException.Validation, uFinancing, uIFinancing;

type
  TFinanceController = class
  private
    procedure ValidateBeforeCalculateFunding(const [ref] aFinancing: TFinancing);
  public
    procedure CalculateFinancing(const [ref] aFinancing: TFinancing);
    procedure GetDefaultInstallments(const [ref] aOutInstallments: TList<Integer>);

    constructor Create; overload;
    destructor Destroy; override;
  end;

implementation

{ TFinanceController }

constructor TFinanceController.Create;
begin
end;

destructor TFinanceController.Destroy;
begin
  inherited Destroy;
end;

// Retorna as parcelas dispon�veis para financiamento.
// Utiliza Instancia local de TFinancing por n�o utilizar em outros lugares..
// mas pode ser movida para escopo privado de classe caso necess�rio
procedure TFinanceController.GetDefaultInstallments(const [ref] aOutInstallments: TList<Integer>);
var
  LFinancing: TFinancing;
begin
  LFinancing := TFinancing.Create;
  try
    LFinancing.Installment.CloneDefaultInstallments(aOutInstallments);
    if (aOutInstallments.Count = 0) then
      raise EValidation.Create('N�o foi poss�vel carregar as parcelas dispon�veis.');
  finally
    LFinancing.Free;
  end;
end;

//M�todo para realizar a valida��o das entradas do usu�rio
procedure TFinanceController.ValidateBeforeCalculateFunding(const [ref] aFinancing: TFinancing);
begin
  if (aFinancing.InterestRate <= 0) or (aFinancing.InterestRate > 100) then
    raise EValidation.Create(Concat('Taxa de juros informada � inv�lida.', sLineBreak, 'Verifique!'));

  if (not aFinancing.Installment.InRange(aFinancing.QuantityInstallments)) then
    raise EValidation.Create(Concat('Quantidade de parcelas informadas � inv�lida.', sLineBreak, 'Verifique!'));

  if (aFinancing.Capital <= 0) then
    raise EValidation.Create(Concat('Capital informado � inv�lido.', sLineBreak, 'Verifique'));

  if (aFinancing.Capital > aFinancing.MAX_VALUE_CAPITAL) then
    raise EValidation.Create(Format(Concat('O capital informado � maior do que o dispon�vel para empr�stimo.', sLineBreak,
      '%s � o valor m�ximo para empr�stimo.'), ['9.999.999.999,99']));
end;

//Metodo para calcular o financiamento. Precisa de uma inst�ncia de TFinancing para
// que possa listar os dados na view.
procedure TFinanceController.CalculateFinancing(const [ref] aFinancing: TFinancing);
begin
  ValidateBeforeCalculateFunding(aFinancing);
  aFinancing.Calculate();
end;

end.
