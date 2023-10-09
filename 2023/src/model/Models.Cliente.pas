unit Models.Cliente;

interface

uses
  System.SysUtils, System.Classes, Models.Base, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.ConsoleUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.VCLUI.Wait, FireDAC.Phys.FB, FireDAC.Phys.FBDef;

type
  TModelCliente = class(TModelBase)
    qryConsultaCLI_CODIGO: TIntegerField;
    qryConsultaCLI_FANTASIA: TStringField;
    qryConsultaCLI_RAZAO_SOCIAL: TStringField;
    qryConsultaCLI_CNPJ: TStringField;
  end;

var
  ModelCliente: TModelCliente;

implementation

{$R *.dfm}

end.
