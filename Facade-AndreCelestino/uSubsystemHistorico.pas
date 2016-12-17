unit uSubsystemHistorico;

interface

type
  { Subsystem }
  TSubsystemHistorico = class
  public
    procedure RegistrarHistoricoDoCalculo(const Fidelidade: integer;
      const Dolar, Preco, ValorVenda: real);
  end;

implementation

uses
  SysUtils;

{ TSubsystemHistorico }

procedure TSubsystemHistorico.RegistrarHistoricoDoCalculo(const Fidelidade: integer;
  const Dolar, Preco, ValorVenda: real);
var
  Arquivo: TextFile;
  sPathArquivo: string;
  Desconto: string;
begin
  // obt�m o caminho e nome do arquivo de hist�rico
  sPathArquivo := ExtractFilePath(ParamStr(0)) + 'Historico.txt';

  // associa a vari�vel "Arquivo" com o arquivo "Historico.txt"
  AssignFile(Arquivo, sPathArquivo);

  if FileExists(sPathArquivo) then
    // se o arquivo j� existe, coloca-o em modo de edi��o
    Append(Arquivo)
  else
    // caso contr�rio, cria o arquivo
    Rewrite(Arquivo);

  // obt�m a descri��o do desconto conforme fidelidade
  case Fidelidade of
    0: Desconto := 'Desconto de 2%';
    1: Desconto := 'Desconto de 6%';
    2: Desconto := 'Desconto de 10%';
    3: Desconto := 'Desconto de 18%';
  end;

  // escreve os dados no arquivo "Historico.txt"
  WriteLn(Arquivo, 'Data/Hora.........: ' + FormatDateTime('dd/mm/yyyy - hh:nn:ss', Now));
  WriteLn(Arquivo, 'Cota��o do D�lar..: ' + FormatFloat('###,###,##0.00', Dolar));
  WriteLn(Arquivo, 'Convers�o em R$...: ' + FormatFloat('###,###,##0.00', Dolar * Preco));
  WriteLn(Arquivo, 'Fidelidade........: ' + Desconto);
  WriteLn(Arquivo, 'Margem de venda...: 35%');
  WriteLn(Arquivo, 'Pre�o final.......: ' + FormatFloat('###,###,##0.00', ValorVenda));
  WriteLn(Arquivo, EmptyStr);

  // fecha o arquivo
  CloseFile(Arquivo);
end;

end.