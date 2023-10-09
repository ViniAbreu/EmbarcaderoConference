inherited ModelCliente: TModelCliente
  PixelsPerInch = 120
  inherited Connection: TFDConnection
    Connected = True
  end
  inherited qryConsulta: TFDQuery
    SQL.Strings = (
      'select cli.cli_codigo, '
      '       cli.cli_fantasia, '
      '       cli.cli_razao_social, '
      '       cli.cli_cnpj'
      'from clientes cli')
    Left = 216
    Top = 72
    object qryConsultaCLI_CODIGO: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'CLI_CODIGO'
      Origin = 'CLI_CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryConsultaCLI_FANTASIA: TStringField
      FieldName = 'CLI_FANTASIA'
      Origin = 'CLI_FANTASIA'
      Size = 60
    end
    object qryConsultaCLI_RAZAO_SOCIAL: TStringField
      FieldName = 'CLI_RAZAO_SOCIAL'
      Origin = 'CLI_RAZAO_SOCIAL'
      Size = 100
    end
    object qryConsultaCLI_CNPJ: TStringField
      FieldName = 'CLI_CNPJ'
      Origin = 'CLI_CNPJ'
      Size = 18
    end
  end
end
