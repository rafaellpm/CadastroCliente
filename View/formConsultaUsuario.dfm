object frmConsultaUsuario: TfrmConsultaUsuario
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'frmConsultaUsuario'
  ClientHeight = 275
  ClientWidth = 510
  Color = clGradientActiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 494
    Height = 265
    Caption = 'Consulta de Usuario'
    TabOrder = 0
    DesignSize = (
      494
      265)
    object Label1: TLabel
      Left = 7
      Top = 20
      Width = 91
      Height = 13
      Caption = 'Pesquisa Por Nome'
    end
    object DBGrid1: TDBGrid
      Left = 7
      Top = 64
      Width = 481
      Height = 195
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsConsulta
      DrawingStyle = gdsGradient
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'ROWID'
          Title.Alignment = taCenter
          Title.Caption = 'Cod. '
          Width = 63
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'USUARIO'
          Title.Alignment = taCenter
          Title.Caption = 'Nome de Usu'#225'rio'
          Width = 377
          Visible = True
        end>
    end
    object edtConsulta: TEdit
      Left = 7
      Top = 35
      Width = 399
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
    object BitBtn1: TBitBtn
      Left = 413
      Top = 33
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Consultar'
      TabOrder = 2
      OnClick = BitBtn1Click
    end
  end
  object memConsultaUsuario: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 256
    Top = 136
    object memConsultaUsuarioROWID: TIntegerField
      FieldName = 'ROWID'
    end
    object memConsultaUsuarioUSUARIO: TStringField
      FieldName = 'USUARIO'
      Size = 255
    end
  end
  object dsConsulta: TDataSource
    DataSet = memConsultaUsuario
    Left = 352
    Top = 120
  end
end
