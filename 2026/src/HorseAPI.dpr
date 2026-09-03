program HorseAPI;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.Classes,
  Horse;

begin
  // Habilita o relatório do FastMM ao fechar a aplicação (Excelente para demonstrar o vazamento)
  ReportMemoryLeaksOnShutdown := True;

  // 1. Rota de Load Test (Carga normal e rápida)
  THorse.Get('/ping',
    procedure(Req: THorseRequest; Res: THorseResponse)
    begin
      Res.Send('{"status":"ok"}');
    end);

  // 2. Rota de Stress/Spike Test (Simula Gargalo)
  THorse.Get('/heavy',
    procedure(Req: THorseRequest; Res: THorseResponse)
    begin
      // Trava a requisição por 200ms. Com milhares de VUs, a thread pool
      // esgota e a latência da API aumenta massivamente.
      Sleep(200); 
      Res.Send('{"status":"heavy processing done"}');
    end);

  // 3. Rota de Soak Test (Vazamento de Memória)
  THorse.Get('/leak',
    procedure(Req: THorseRequest; Res: THorseResponse)
    var
      List: TStringList;
      I: Integer;
    begin
      // Cria um objeto local e preenche na memória, mas de propósito 
      // NÃO chamamos o List.Free. Isso causa um memory leak genuíno e isolado nesta rota.
      List := TStringList.Create;
      for I := 1 to 10000 do
        List.Add('Memory leak simulation string data ' + IntToStr(I));
        
      Res.Send('{"status":"memory leaked"}');
    end);

  Writeln('API Horse rodando na porta 9000...');
  THorse.Listen(9000);
end.
