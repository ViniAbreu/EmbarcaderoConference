unit Models.Connection;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.VCLUI.Wait, FireDAC.Phys.FB, FireDAC.Phys.FBDef;

type
  TModelConnection = class(TDataModule)
    Connection: TFDConnection;
  end;

var
  ModelConnection: TModelConnection;

implementation

{$R *.dfm}

end.
