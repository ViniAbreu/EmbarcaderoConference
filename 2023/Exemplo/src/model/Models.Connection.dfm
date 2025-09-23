object ModelConnection: TModelConnection
  Height = 216
  Width = 270
  PixelsPerInch = 120
  object Connection: TFDConnection
    Params.Strings = (
      'Database=C:\Projetos\FullStack\CONFERENCE.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Port=3050'
      'Server=127.0.0.1'
      'DriverID=FB')
    LoginPrompt = False
    Left = 110
    Top = 70
  end
end
