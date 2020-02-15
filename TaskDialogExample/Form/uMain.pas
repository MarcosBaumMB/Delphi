unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Service.TaskDialogProgress;

type
  TFTaskDialogExample = class(TForm)
    btnIncrementProc: TButton;
    btnUndeterminedProgress: TButton;
    btnUserCanAbort: TButton;
    BtnWithException: TButton;
    btnProcessoLento: TButton;
    procedure btnIncrementProcClick(Sender: TObject);
    procedure btnUndeterminedProgressClick(Sender: TObject);
    procedure BtnWithExceptionClick(Sender: TObject);
    procedure btnUserCanAbortClick(Sender: TObject);
    procedure btnProcessoLentoClick(Sender: TObject);
  private
    procedure ProcessoLento;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTaskDialogExample: TFTaskDialogExample;

implementation

{$R *.dfm}

procedure TFTaskDialogExample.btnIncrementProcClick(Sender: TObject);
begin
  FTaskDialogProgress.Config.Caption := 'Aguarde o processo de atualiza��o';
  FTaskDialogProgress.Config.AutoClose := False;
  FTaskDialogProgress.Config.UserCanAbort := False;
  FTaskDialogProgress.Start(
    procedure(const AStatus: TTaskStatus)
    begin
      AStatus.SetProgress(1, 100);
      AStatus.SetMessage('Fazendo backup f�sico do banco de dados...');
      Sleep(3000);

      AStatus.SetProgress(33, 100);
      AStatus.SetMessage('Executando SQL Script no banco de dados no banco de dados no banco de dados no banco de dados no banco de dados...');
      Sleep(3000);

      AStatus.SetProgress(66, 100);
      AStatus.SetMessage('Atualizando a aplica��o e suas depend�ncias...');
      Sleep(3000);

      AStatus.SetProgress(95, 100);
      AStatus.SetMessage('Removendo arquivos tempor�rios...');
      Sleep(1000);

      AStatus.SetProgress(100, 100);
      AStatus.SetMessage('Atualiza��o completa!');
    end);
end;

procedure TFTaskDialogExample.btnUndeterminedProgressClick(Sender: TObject);
begin
  FTaskDialogProgress.Config.Caption := 'Aguarde o processo de atualiza��o';
  FTaskDialogProgress.Start(
    procedure(const AStatus: TTaskStatus)
    begin
      AStatus.SetMessage('Fazendo backup f�sico do banco de dados...');
      Sleep(3000);

      AStatus.SetMessage('Executando SQL Script no banco de dados...');
      Sleep(3000);

      AStatus.SetMessage('Atualizando a aplica��o e suas depend�ncias...');
      Sleep(3000);

      AStatus.SetMessage('Atualiza��o completa!');
    end);
end;

procedure TFTaskDialogExample.btnUserCanAbortClick(Sender: TObject);
begin
  FTaskDialogProgress.Config.Caption := 'Aguarde o processo de atualiza��o';
  FTaskDialogProgress.Config.AutoClose := False;
  FTaskDialogProgress.Config.UserCanAbort := True;
  FTaskDialogProgress.Start(
    procedure(const AStatus: TTaskStatus)
    begin
      AStatus.SetMessage('Fazendo backup f�sico do banco de dados...');
      Sleep(3000);

      if (AStatus.UserRequestAbort) then
        raise Exception.Create('Processo abortado pelo usu�rio');

      AStatus.SetMessage('Executando SQL Script no banco de dados...');
      Sleep(3000);

      if (AStatus.UserRequestAbort) then
        raise Exception.Create('Processo abortado pelo usu�rio');

      AStatus.SetMessage('Atualizando a aplica��o e suas depend�ncias...');
      Sleep(3000);

      if (AStatus.UserRequestAbort) then
        raise Exception.Create('Processo abortado pelo usu�rio');

      Sleep(1000);

      AStatus.SetMessage('Atualiza��o completa!');
    end);
end;

procedure TFTaskDialogExample.BtnWithExceptionClick(Sender: TObject);
begin
  FTaskDialogProgress.Config.AutoClose := False;
  FTaskDialogProgress.Config.Caption := 'Aguarde o processo de atualiza��o';
  FTaskDialogProgress.Start(
    procedure(const AStatus: TTaskStatus)
    begin
      AStatus.SetMessage('Fazendo backup f�sico do banco de dados...');
      Sleep(3000);

      raise Exception.Create('Ocorreu uma exce��o no meio do procedimento!');

      AStatus.SetMessage('Executando SQL Script no banco de dados...');
      Sleep(3000);

      AStatus.SetMessage('Atualizando a aplica��o e suas depend�ncias...');
      Sleep(3000);

      AStatus.SetMessage('Atualiza��o completa!');
    end);
end;

procedure TFTaskDialogExample.btnProcessoLentoClick(Sender: TObject);
begin
  FTaskDialogProgress.Config.AutoClose := False;
  FTaskDialogProgress.Config.Caption := 'Aguarde o processo de atualiza��o';
  FTaskDialogProgress.Start(ProcessoLento);
end;

procedure TFTaskDialogExample.ProcessoLento;
begin
  FTaskDialogProgress.Status.SetMessage('Fazendo backup f�sico do banco de dados...');
  Sleep(3000);

  FTaskDialogProgress.Status.SetMessage('Executando SQL Script no banco de dados...');
  Sleep(3000);

  FTaskDialogProgress.Status.SetMessage('Atualizando a aplica��o e suas depend�ncias...');
  Sleep(3000);

  FTaskDialogProgress.Status.SetMessage('Atualiza��o completa!');
end;



end.
