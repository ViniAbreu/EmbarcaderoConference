program SimpleCRUD;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  Sempare.Template,
  DataSet.Serialize.Config,
  Models.Connection in 'src\model\Models.Connection.pas',
  Models.Base in 'src\model\Models.Base.pas' {ModelBase: TDataModule},
  Models.Cliente in 'src\model\Models.Cliente.pas' {ModelCliente: TDataModule},
  Controlles.Cliente in 'src\controller\Controlles.Cliente.pas';

begin
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;

  TSempareServerPages.Instance.TemplateRootFolder := 'C:\Projetos\FullStack\src\view\';
  TSempareServerPages.Instance.TemplateFileExt := 'html';

  Controlles.Cliente.Registry;

  THorse.Listen(9000);
end.
