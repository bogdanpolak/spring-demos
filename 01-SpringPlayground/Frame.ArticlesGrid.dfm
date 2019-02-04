object FrameArticlesGrid: TFrameArticlesGrid
  Left = 0
  Top = 0
  Width = 515
  Height = 282
  TabOrder = 0
  object Splitter1: TSplitter
    Left = 378
    Top = 52
    Width = 5
    Height = 230
    Align = alRight
    ExplicitLeft = 386
    ExplicitTop = 68
    ExplicitHeight = 172
  end
  object grbxNavigation: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 509
    Height = 46
    Align = alTop
    Caption = 'grbxNavigation'
    TabOrder = 0
    object DBNavigator1: TDBNavigator
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 268
      Height = 23
      DataSource = DataSource1
      Align = alLeft
      TabOrder = 0
    end
    object Button2: TButton
      AlignWithMargins = True
      Left = 386
      Top = 18
      Width = 118
      Height = 23
      Action = actCloseFrame
      Align = alRight
      TabOrder = 1
    end
  end
  object DBGrid1: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 55
    Width = 132
    Height = 224
    Margins.Right = 1
    Align = alLeft
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object grbxShowList: TGroupBox
    AlignWithMargins = True
    Left = 384
    Top = 55
    Width = 128
    Height = 224
    Margins.Left = 1
    Align = alRight
    Caption = 'grbxShowList'
    TabOrder = 2
    ExplicitTop = 71
    ExplicitHeight = 208
    object Button1: TButton
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 118
      Height = 25
      Action = actShowList
      Align = alTop
      TabOrder = 0
      ExplicitLeft = 40
      ExplicitTop = 72
      ExplicitWidth = 75
    end
    object Memo1: TMemo
      AlignWithMargins = True
      Left = 5
      Top = 49
      Width = 118
      Height = 170
      Align = alClient
      Lines.Strings = (
        'Memo1')
      TabOrder = 1
      ExplicitLeft = -40
      ExplicitTop = 40
      ExplicitWidth = 185
      ExplicitHeight = 89
    end
  end
  object DataSource1: TDataSource
    Left = 184
    Top = 176
  end
  object tmrFrameReady: TTimer
    Interval = 1
    OnTimer = tmrFrameReadyTimer
    Left = 184
    Top = 64
  end
  object ActionList1: TActionList
    Left = 184
    Top = 120
    object actShowList: TAction
      Caption = 'actShowList'
      OnExecute = actShowListExecute
    end
    object actCloseFrame: TAction
      Caption = 'actCloseFrame'
      OnExecute = actCloseFrameExecute
    end
  end
end
