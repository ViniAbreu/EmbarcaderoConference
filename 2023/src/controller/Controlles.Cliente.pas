unit Controlles.Cliente;

interface

procedure Registry;

implementation

uses Horse, Models.Cliente, Sempare.Template, System.JSON, System.SysUtils, DataSet.Serialize, Data.DB;

procedure Listar(Req: THorseRequest; Res: THorseResponse);
var
  LModel: TModelCliente;
begin
  LModel := TModelCliente.Create;
  try
    Res.Send(TSempareServerPages.Instance.Eval('Views.ConClientes', LModel.ListAll(Req.Params.Dictionary).ToJSONArray()));
  finally
    LModel.Free;
  end;
end;

procedure GetById(Req: THorseRequest; Res: THorseResponse);
var
  LModel: TModelCliente;
  LCliCodigo: string;
begin
  LModel := TModelCliente.Create;
  try
    LCliCodigo := Req.Params.Items['id'];
    if LModel.GetById(LCliCodigo, 'cli_codigo').IsEmpty then
      raise EHorseException.New.Error('Cliente não encontrado.').Status(THTTPStatus.NotFound);
    Res.Send(TSempareServerPages.Instance.Eval('Views.CadClientes', LModel.qryConsulta.ToJSONObject()));
  finally
    LModel.Free;
  end;
end;

procedure Alterar(Req: THorseRequest; Res: THorseResponse);
var
  LModel: TModelCliente;
  LCliCodigo: string;
  LCliente: TJSONObject;
begin
  LModel := TModelCliente.Create;
  try
    LCliCodigo := Req.Params.Items['id'];
    if LModel.GetById(LCliCodigo, 'cli_codigo').IsEmpty then
      raise EHorseException.New.Error('Cliente não encontrado.').Status(THTTPStatus.NotFound);

    LCliente := LModel.BodyToJson(Req.Body);
    try
      if LModel.Update(LCliente) then
        Res.RedirectTo('/clientes');
    finally
      LCliente.Free;
    end;
  finally
    LModel.Free;
  end;
end;

procedure Inserir(Req: THorseRequest; Res: THorseResponse);
var
  LModel: TModelCliente;
  LCliente: TJSONObject;
begin
  LModel := TModelCliente.Create;
  try
    LCliente := LModel.BodyToJson(Req.Body);
    try
      LCliente.RemovePair('cli_codigo').Free;
      if LModel.Append(LCliente) then
        Res.RedirectTo('/clientes');
    finally
      LCliente.Free;
    end;
  finally
    LModel.Free;
  end;
end;

procedure Excluir(Req: THorseRequest; Res: THorseResponse);
var
  LModel: TModelCliente;
  LCliCodigo: string;
begin
  LModel := TModelCliente.Create;
  try
    LCliCodigo := Req.Params.Items['id'];
    if LModel.GetById(LCliCodigo, 'cli_codigo').IsEmpty then
      raise EHorseException.New.Error('Cliente não encontrado.').Status(THTTPStatus.NotFound);
    if LModel.Delete then
      Res.Status(THTTPStatus.NoContent);
  finally
    LModel.Free;
  end;
end;

procedure Registry;
begin
  THorse.Get('/clientes', Listar);
  THorse.Get('/clientes/:id', GetById);
  THorse.Post('/clientes', Inserir);
  THorse.Post('/clientes/:id', Alterar);
  THorse.Delete('/clientes/:id', Excluir);
end;

end.
