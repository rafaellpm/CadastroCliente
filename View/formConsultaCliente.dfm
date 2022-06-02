object frmConsultaCliente: TfrmConsultaCliente
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Tela Principal'
  ClientHeight = 600
  ClientWidth = 1024
  Color = clGradientActiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  DesignSize = (
    1024
    600)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1024
    Height = 81
    Align = alTop
    BevelOuter = bvNone
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      1024
      81)
    object btnNovo: TSpeedButton
      Left = 10
      Top = 5
      Width = 75
      Height = 68
      Caption = 'Novo'
      ImageIndex = 0
      Images = dm.ImageList1
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 1116996
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Layout = blGlyphTop
      NumGlyphs = 4
      ParentFont = False
      Transparent = False
      OnClick = btnNovoClick
    end
    object btnEditar: TSpeedButton
      Left = 91
      Top = 5
      Width = 75
      Height = 68
      Caption = 'Editar'
      ImageIndex = 1
      Images = dm.ImageList1
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 1116996
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Layout = blGlyphTop
      ParentFont = False
      Transparent = False
      OnClick = btnEditarClick
    end
    object btnExcluir: TSpeedButton
      Left = 172
      Top = 5
      Width = 75
      Height = 68
      HelpType = htKeyword
      Caption = 'Excluir'
      ImageIndex = 2
      Images = dm.ImageList1
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 1116996
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Layout = blGlyphTop
      ParentFont = False
      Transparent = False
      OnClick = btnExcluirClick
    end
    object btnImprimir: TSpeedButton
      Left = 253
      Top = 5
      Width = 75
      Height = 68
      Caption = 'Imprimir'
      ImageIndex = 3
      Images = dm.ImageList1
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 1116996
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Layout = blGlyphTop
      ParentFont = False
      Transparent = False
      OnClick = btnImprimirClick
    end
    object btnFinalizar: TSpeedButton
      Left = 938
      Top = 5
      Width = 75
      Height = 68
      Anchors = [akTop, akRight]
      Caption = 'Finalizar'
      ImageIndex = 5
      Images = dm.ImageList1
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 1116996
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Layout = blGlyphTop
      ParentFont = False
      OnClick = btnFinalizarClick
      ExplicitLeft = 801
    end
    object btnUsuarios: TSpeedButton
      Left = 857
      Top = 5
      Width = 75
      Height = 68
      Anchors = [akTop, akRight]
      Caption = 'Usu'#225'rios'
      ImageIndex = 4
      Images = dm.ImageList1
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 1116996
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Layout = blGlyphTop
      ParentFont = False
      OnClick = btnUsuariosClick
      ExplicitLeft = 720
    end
  end
  object GroupBox1: TGroupBox
    Left = 10
    Top = 91
    Width = 1003
    Height = 501
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Consulta de Cliente'
    TabOrder = 1
    DesignSize = (
      1003
      501)
    object Label1: TLabel
      Left = 7
      Top = 20
      Width = 91
      Height = 13
      Caption = 'Pesquisa Por Nome'
    end
    object DBGrid1: TDBGrid
      Left = 3
      Top = 64
      Width = 990
      Height = 431
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
      Columns = <
        item
          Expanded = False
          FieldName = 'ROWID'
          Title.Alignment = taCenter
          Title.Caption = 'Cod. '
          Width = 51
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOME_CLIENTE'
          Title.Alignment = taCenter
          Title.Caption = 'Nome / Raz'#227'o Social'
          Width = 269
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CPF_CNPJ'
          Title.Alignment = taCenter
          Title.Caption = 'Cpf / Cnpj'
          Width = 141
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ENDERECO'
          Title.Alignment = taCenter
          Title.Caption = 'Endereco'
          Width = 182
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'CELULAR'
          Title.Alignment = taCenter
          Title.Caption = 'Celular'
          Width = 117
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EMAIL'
          Title.Alignment = taCenter
          Title.Caption = 'Email'
          Width = 195
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CIDADE'
          Title.Caption = 'Cidade'
          Width = 140
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UF'
          Width = 37
          Visible = True
        end>
    end
    object edtConsulta: TEdit
      Left = 7
      Top = 35
      Width = 908
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
    object BitBtn1: TBitBtn
      Left = 922
      Top = 33
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Consultar'
      TabOrder = 2
      OnClick = BitBtn1Click
    end
  end
  object dsConsulta: TDataSource
    DataSet = memConsultaCliente
    Left = 800
    Top = 168
  end
  object memConsultaCliente: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 704
    Top = 184
    object memConsultaClienteROWID: TIntegerField
      FieldName = 'ROWID'
    end
    object memConsultaClienteNOME_CLIENTE: TStringField
      FieldName = 'NOME_CLIENTE'
      Size = 255
    end
    object memConsultaClienteCPF_CNPJ: TStringField
      FieldName = 'CPF_CNPJ'
      Size = 255
    end
    object memConsultaClienteENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 255
    end
    object memConsultaClienteCELULAR: TStringField
      FieldName = 'CELULAR'
    end
    object memConsultaClienteEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 100
    end
    object memConsultaClienteCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 255
    end
    object memConsultaClienteUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
  end
end
