unit Models.Base;

interface

uses
  System.SysUtils, System.Classes, Models.Connection, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.ConsoleUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, System.JSON, System.Generics.Collections, FireDAC.VCLUI.Wait, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef;

type
  TModelBase = class(TModelConnection)
    qryConsulta: TFDQuery;
  public
    constructor Create; reintroduce;
    function Append(const AJson: TJSONObject): Boolean; virtual;
    function ListAll(const AParams: TDictionary<string, string>): TFDQuery; virtual;
    function Update(const AJson: TJSONObject): Boolean; virtual;
    function Delete: Boolean; virtual;
    function GetById(const AId, ANameParam: string): TFDQuery; virtual;
    function BodyToJson(const ABody: string): TJSONObject;
  end;

var
  ModelBase: TModelBase;

implementation

uses DataSet.Serialize;

{$R *.dfm}

function TModelBase.Append(const AJson: TJSONObject): Boolean;
begin
  qryConsulta.SQL.Add('where 1 <> 1');
  qryConsulta.Open();
  qryConsulta.LoadFromJSON(AJson, False);
  Result := qryConsulta.ApplyUpdates(0) = 0;
end;

function TModelBase.BodyToJson(const ABody: string): TJSONObject;
var
  LLine: string;
  LJsonPair: TArray<string>;
begin
  Result := TJSONObject.Create;
  for LLine in ABody.Split(['&']) do
  begin
    LJsonPair := LLine.Split(['=']);
    Result.AddPair(LJsonPair[0], LJsonPair[1].Replace('+', ' '));
  end;
end;

constructor TModelBase.Create;
begin
  inherited Create(nil);
end;

function TModelBase.Delete: Boolean;
begin
  qryConsulta.Delete;
  Result := qryConsulta.ApplyUpdates(0) = 0;
end;

function TModelBase.GetById(const AId, ANameParam: string): TFDQuery;
begin
  qryConsulta.SQL.Add(Concat('where ', ANameParam, ' = :', ANameParam));
  qryConsulta.ParamByName(ANameParam).AsLargeInt := AId.ToInt64;
  qryConsulta.Open();
  Result := qryConsulta;
end;

function TModelBase.ListAll(const AParams: TDictionary<string, string>): TFDQuery;
begin
  if AParams.ContainsKey('limit') then
  begin
    qryConsulta.FetchOptions.RecsMax := StrToIntDef(AParams.Items['limit'], 50);
    qryConsulta.FetchOptions.RowsetSize := StrToIntDef(AParams.Items['limit'], 50);
  end;

  if AParams.ContainsKey('offset') then
    qryConsulta.FetchOptions.RecsSkip := StrToIntDef(AParams.Items['offset'], 50);

  qryConsulta.Open();
  Result := qryConsulta;
end;

function TModelBase.Update(const AJson: TJSONObject): Boolean;
begin
  qryConsulta.MergeFromJSONObject(AJson, False);
  Result := qryConsulta.ApplyUpdates(0) = 0;
end;

end.
