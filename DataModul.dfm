object mainDataModul: TmainDataModul
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 590
  Width = 753
  object FDConnection: TFDConnection
    Params.Strings = (
      
        'Database=D:\AS2022_Nabavka_Repromaterijala\Win32\Debug\Nabavka.d' +
        'b'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 680
    Top = 352
  end
  object queryPrikazZahtevaZaNabavku: TFDQuery
    Active = True
    Connection = FDConnection
    SQL.Strings = (
      
        'SELECT ZahtevZaNabavku.IDTabele as Indeks, ImePodnosioca, Stanje' +
        '.ImeStanja as Stanje, Hitnost.ImeHitnosti, DatumPodnosenja '
      'FROM ZahtevZaNabavku '
      'INNER JOIN Stanje '
      'ON ZahtevZaNabavku.IDStanja = Stanje.IDTabele '
      'INNER JOIN Hitnost '
      'ON ZahtevZaNabavku.IDHitnosti = Hitnost.IDTabele '
      'ORDER BY DatumPodnosenja DESC')
    Left = 81
    Top = 528
  end
  object querySviKlijenti: TFDQuery
    Connection = FDConnection
    Left = 32
    Top = 528
  end
  object queryPrikazProizvodaNovePorudzbenice: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'SELECT IDUnosa as Indeks, ImeDobavljaca, ImeProizvoda, ListaProi' +
        'zvodaZahtevaTemp.Kolicina as Kolicina, Proizvod.CenaKupovine as ' +
        'Cena '
      'from ListaProizvodaZahtevaTemp '
      'INNER JOIN Proizvod'
      'ON ListaProizvodaZahtevaTemp.IDProizvoda = Proizvod.IDTabele '
      'INNER JOIN Dobavljac'
      'ON Proizvod.IDDobavljaca = Dobavljac.IDTabele')
    Left = 200
    Top = 16
  end
  object queryDobavljaciZahtevPunjenje: TFDQuery
    Connection = FDConnection
    Left = 80
    Top = 16
  end
  object queryProizvodiZahtevPunjenje: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'SELECT  Proizvod.IDTabele as IDProizvoda, Proizvod.ImeProizvoda,' +
        ' Dobavljac.IDTabele as IDDobavljaca, Dobavljac.ImeDobavljaca FRO' +
        'M Proizvod INNER JOIN Dobavljac ON Proizvod.IDDobavljaca = Dobav' +
        'ljac.IDTabele')
    Left = 120
    Top = 16
  end
  object queryPrikazProizvodaNoveP: TFDQuery
    Connection = FDConnection
    Left = 120
    Top = 72
  end
  object queryPrikazPorudzbenica: TFDQuery
    Connection = FDConnection
    Left = 136
    Top = 528
  end
  object queryProizvodiNaZahtevu: TFDQuery
    Connection = FDConnection
    Left = 40
    Top = 184
  end
  object queryDobavljaciPorudzbenicaPunjenje: TFDQuery
    Connection = FDConnection
    Left = 80
    Top = 72
  end
  object queryStatusPorudzbeniePunjenje: TFDQuery
    Connection = FDConnection
    Left = 40
    Top = 72
  end
  object queryDelete: TFDQuery
    Connection = FDConnection
    Left = 680
    Top = 528
  end
  object queryProizvodiNaPorudzbenici: TFDQuery
    Connection = FDConnection
    Left = 80
    Top = 184
  end
  object queryInsert: TFDQuery
    Connection = FDConnection
    Left = 680
    Top = 440
  end
  object tableListaProizvodaZahtev: TFDTable
    Connection = FDConnection
    TableName = 'ListaProizvodaZahtevaTemp'
    Left = 240
    Top = 16
  end
  object queryPrikazDobavljaca: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT * FROM Dobavljac')
    Left = 40
    Top = 128
  end
  object queryUpdate: TFDQuery
    Connection = FDConnection
    Left = 680
    Top = 488
  end
  object queryLastIndex: TFDQuery
    Connection = FDConnection
    Left = 680
    Top = 400
  end
  object queryHitnostZahtevPunjenje: TFDQuery
    Connection = FDConnection
    Left = 40
    Top = 16
  end
  object queryStanjeZahtevPunjenje: TFDQuery
    Connection = FDConnection
    Left = 160
    Top = 16
  end
end
