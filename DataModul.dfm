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
    Top = 416
  end
  object queryPregledZahtevaZaNabavku: TFDQuery
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
    Active = True
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
    Left = 120
    Top = 16
  end
  object queryDobavljaciPorudzbenicePunjenje: TFDQuery
    Connection = FDConnection
    Left = 40
    Top = 16
  end
  object queryProizvodiPorudzbenicePunjenje: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'SELECT  Proizvod.IDTabele as IDProizvoda, Proizvod.ImeProizvoda,' +
        ' Dobavljac.IDTabele as IDDobavljaca, Dobavljac.ImeDobavljaca FRO' +
        'M Proizvod INNER JOIN Dobavljac ON Proizvod.IDDobavljaca = Dobav' +
        'ljac.IDTabele')
    Left = 80
    Top = 16
  end
  object queryPrikazProizvodaNoveP: TFDQuery
    Connection = FDConnection
    Left = 120
    Top = 72
  end
  object queryPregledPorudzbenica: TFDQuery
    Connection = FDConnection
    Left = 136
    Top = 528
  end
  object queryProizvodiNaZahtevu: TFDQuery
    Connection = FDConnection
    Left = 40
    Top = 128
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
    Top = 128
  end
  object queryInsert: TFDQuery
    Connection = FDConnection
    Left = 680
    Top = 472
  end
  object tableListaProizvodaZahtev: TFDTable
    Connection = FDConnection
    TableName = 'ListaProizvodaZahtevaTemp'
    Left = 168
    Top = 16
  end
end
