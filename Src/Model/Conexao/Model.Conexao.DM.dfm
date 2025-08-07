object ModelConexaoDM: TModelConexaoDM
  OldCreateOrder = False
  Height = 299
  Width = 528
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\Code4D\Cursos\Vendas\Dados\DADOS.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 120
    Top = 48
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 112
    Top = 104
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 112
    Top = 160
  end
end
