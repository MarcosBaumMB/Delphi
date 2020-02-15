#Desenvolvimento Delphi

#Projeto Máquina de dinheiro

Máquina de dinheiro. Trata-se de uma máquina que precisa calcular a quantidade de diheiro que será dada de troco para uma operação financeira. Rotina implementada será apenas a verificação das notas dadas como troco. Para isso deverá ser criada uma classe TMaquinaDinheiro que implemente a interface IMaquina:

IMaquina = interface function MontarTroco(aTroco: Double): TList; end;

O método MontarTroco recebe um parâmetro double, que poderá no máximo ter duas casas decimais, e então calculará quantas notas de dinheiro e quantas moedas conseguirá para compor o troco. Cada tipo de nota ou moeda terá uma determinada quantidade, e deverão estar emcapsulados na lista de Troco. O sistema deverá usar a menor quantidade possível de notas e moedas possíveis. Notas disponíveis: 100, 50, 20, 10, 5, 2; Moedas disponíveis: 1, 0.50, 0.25, 0.10, 0.05, 0.01;

TCedula = (ceNota100, ceNota50, ceNota20, ceNota10, ceNota5, ceNota2, ceMoeda100, ceMoeda50, ceMoeda25, ceMoeda10, ceMoeda5, ceMoeda1);

TTroco = class private FTipo: TCedula; FQuantidade: Integer; public constructor Create(aTipo: TCedula; aQuantidade: Integer);

property Tipo: TCedula read FTipo;
property Quantidade: Integer read FQuantidade write FQuantidade;
end;

Ex: A entrada é 125,15 e a saída é: 1 nota de 100 - TTroco(ceNota100, 1); 1 nota de 20 - TTroco(ceNota20, 1); 1 nota de 5 - TTroco(ceNota5, 1); 1 moeda de 0.10 - TTroco(ceMoeda10, 1); 1 moeda de 0.05 - TTroco(ceMoeda5, 1);