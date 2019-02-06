object FrameConsole: TFrameConsole
  Left = 0
  Top = 0
  Width = 320
  Height = 240
  TabOrder = 0
  object grbxCommands: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 314
    Height = 46
    Align = alTop
    Caption = 'grbxCommands'
    TabOrder = 0
    ExplicitLeft = -189
    ExplicitWidth = 509
    object Button2: TButton
      AlignWithMargins = True
      Left = 191
      Top = 18
      Width = 118
      Height = 23
      Align = alRight
      Caption = 'Button2'
      TabOrder = 1
      ExplicitLeft = 386
    end
    object Button1: TButton
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 116
      Height = 23
      Align = alLeft
      Caption = 'Button1'
      TabOrder = 0
    end
  end
  object Memo1: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 55
    Width = 185
    Height = 182
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Consolas'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object ActionList1: TActionList
    Left = 248
    Top = 64
    object actClearLog: TAction
      Caption = 'actClearLog'
      OnExecute = actClearLogExecute
    end
    object actCloseFrame: TAction
      Caption = 'actCloseFrame'
      OnExecute = actCloseFrameExecute
    end
  end
end
