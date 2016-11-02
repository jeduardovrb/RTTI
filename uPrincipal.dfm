object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Run-time type information (RTTI) '
  ClientHeight = 360
  ClientWidth = 485
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnGetMethod: TButton
    Left = 9
    Top = 8
    Width = 161
    Height = 33
    Caption = 'GetMethod'
    TabOrder = 0
    OnClick = btnGetMethodClick
  end
  object mmRtti: TMemo
    Left = 185
    Top = 8
    Width = 291
    Height = 344
    TabOrder = 1
  end
  object btnGetField: TButton
    Left = 9
    Top = 47
    Width = 161
    Height = 33
    Caption = 'GetField'
    TabOrder = 2
    OnClick = btnGetFieldClick
  end
  object btnGetProperty: TButton
    Left = 9
    Top = 86
    Width = 161
    Height = 33
    Caption = ' GetProperty'
    TabOrder = 3
    OnClick = btnGetPropertyClick
  end
  object btnGetPropertiesTypes: TButton
    Left = 8
    Top = 125
    Width = 161
    Height = 33
    Caption = ' GetProperty, Types e Valor'
    TabOrder = 4
    OnClick = btnGetPropertiesTypesClick
  end
  object btnSetValue: TButton
    Left = 9
    Top = 164
    Width = 161
    Height = 33
    Caption = 'SetValue'
    TabOrder = 5
    OnClick = btnSetValueClick
  end
  object btnTRttiMethodTypes: TButton
    Left = 9
    Top = 203
    Width = 161
    Height = 33
    Caption = 'Method, Parametros e Retorno'
    TabOrder = 6
    OnClick = btnTRttiMethodTypesClick
  end
  object btnInvoke: TButton
    Left = 9
    Top = 242
    Width = 161
    Height = 33
    Caption = 'Invocar um M'#233'todo'
    TabOrder = 7
    OnClick = btnInvokeClick
  end
  object btnRttiValidar: TButton
    Left = 9
    Top = 281
    Width = 161
    Height = 33
    Caption = 'Validar Nome do campo'
    TabOrder = 8
    OnClick = btnRttiValidarClick
  end
  object btnNomeTabela: TButton
    Left = 8
    Top = 320
    Width = 161
    Height = 33
    Caption = 'Nome tabela'
    TabOrder = 9
    OnClick = btnNomeTabelaClick
  end
end
