{
TlogDisk  Component Version 1.3 - Suite GLib
Copyright (©) 2009,  by Germán Estévez (Neftalí)

  Permite crear un fichero de los de la aplicación con operaciones mínimas
  por parte del programador. Basta con colocarel componente en el formulario
  y activarlo.
  Posee diferentes propiedades que permiten modificar la forma en que se graba,
  el nombre del fichero, su ubicación,...

Utilización/Usage:
  Basta con "soltar" el componente y activarlo.

  Place the component in the form and active it.

=========================================================================
IMPORTANTE PROGRAMADORES: Por favor, si tienes comentarios, mejoras, ampliaciones,
  errores y/o cualquier otro tipo de sugerencia envíame un mail a:
  german_ral@hotmail.com

IMPORTANT PROGRAMMERS: please, if you have comments, improvements, enlargements,
errors and/or any another type of suggestion send a mail to:
german_ral@hotmail.com
=========================================================================

@author Germán Estévez (Neftalí)
@cat Package GLib
}
unit CLogDisk;

{
=========================================================================

  CLogDisk.pas

  Componente

========================================================================
  Historia de las Versiones
------------------------------------------------------------------------

  04/32/2009    * Creación.
  11/05/2009    * Permitir grabación continua de ficheros (Accumulative).
                * Propiedades para permitir o no grabar pie y cabecera.

=========================================================================

  Errores detectados no corregidos

=========================================================================
}

//=========================================================================
//
// I N T E R F A C E
//
//=========================================================================
interface

uses
  {Generales} SysUtils, Classes;

type

  {: Format para el nombre de fichero
    @enum ffDateTimeFormat      Formato de fichero con fecha y hora.
    @enum ffAppNameFormat       Nombre de fichero igual a la aplicación.
    @enum ffDateFormat          Formato de fichero con la fecha.
    @enum ffAccumulative        Ficheros acumulativos, no por cada ejecución.
  }
  TFileNameFormat = (ffDateTimeFormat, ffAppNameFormat, ffDateFormat, ffAccumulative);

  {: Periodo a acumular en el fichero de Log.}
  TFileAccumulative = (faNotUsed, faFilexHour, faFilexDay);

  //: Ubicación del fichero de log
  TFileSavePath = (spLogDirectory, spAppDirectory);

  //: Tipo de evento para cuando se añade una nueva cadena.
  TOnAddStringEvent = procedure(AStr:string) of object;

  //: Clase
  TLogDisk = class(TComponent)
  private
    FFileNameFormat: TFileNameFormat;
    FFileSavePath: TFileSavePath;
    FLogFileName: TFileName;
    FTSLog: TStrings;
    FLogWithTime: Boolean;
    FContinuousWrite: Boolean;
    FActive: Boolean;
    FMaxLogFiles: Integer;
    FLogPath: string;
    FOnAddStringEvent: TOnAddStringEvent;
    FOnSaveEvent: TNotifyEvent;
    FFileAccumulative: TFileAccumulative;
    FSaveCab: Boolean;
    FSaveFooter: Boolean;

    procedure _Save();
    procedure _AddCab();
    procedure _AddPie();
    procedure _Log(AStr:string);
    procedure SetFileNameFormat(const Value: TFileNameFormat);
    procedure SetFileSavePath(const Value: TFileSavePath);
    procedure SetFileAccumulative(const Value: TFileAccumulative);
  protected
    // contenido del log
    property TSLog:TStrings read FTSLog write FTSLog;
    //: sobreescribir el método de carga
    procedure Loaded; override;
  public
    // redefinidos
    constructor Create(AOwner: TComponent); override;
    //: destructor
    destructor Destroy; override;
    //: Nombre del fichero de log
    property LogFileName:TFileName read FLogFileName;
    //: Devuelve el path donde se graba el Log
    property LogPath:string read FLogPath;

    //: Procedimientos de log.
    procedure Log(AStr:string); overload;
    procedure Log(AStrings:TStrings); overload;
    procedure Log(AStr:string; Value:string); overload;
    procedure Log(AStr:string; Value:integer); overload;
    procedure Log(AStr:string; Value:Boolean); overload;

    //: Grabar cambios a disco
    procedure SaveToDisk();
    //: permite acceder a las líneas del Log.
    function LogLines():TStrings;

  published
    //: formato para el nombre de fichero
    property FileNameFormat:TFileNameFormat read FFileNameFormat write SetFileNameFormat;
    property FileAccumulative: TFileAccumulative read FFileAccumulative write SetFileAccumulative;
    //: Ubicación del fichero de log.
    property FileSavePath:TFileSavePath read FFileSavePath write SetFileSavePath;
    //:Insertar hora
    property LogWithTime:Boolean read FLogWithTime write FLogWithTime;
    //: Grabar continuamente a disco.  ¡¡¡MAS LENTO!!!
    property ContinuousWrite:Boolean read FContinuousWrite
        write FContinuousWrite default False;
    //: Grabar la cabecera en el fichero
    property SaveCab:Boolean read FSaveCab write FSaveCab;
    // : Grabar el pie en el fichero
    property SaveFooter:Boolean read FSaveFooter write FSaveFooter;
    //: Activa/desactiva el componente.
    property Active:Boolean read FActive write FActive;
    //: Maximo de ficheros en el directorio
    property MaxLogFiles:Integer read FMaxLogFiles write FMaxLogFiles default 0;

    // Evento que se levanta al añadir una nueva cadena.
    property OnAddStringEvent:TOnAddStringEvent read FOnAddStringEvent write FOnAddStringEvent;
    // evento que salta al guardar
    property OnSaveEvent:TNotifyEvent read FOnSaveEvent write FOnSaveEvent;
  end;

// constantes varias
const
  FORMATDT_FNAME  = 'yyyy_mm_dd_hh_nn_ss';
  FORMATD_FNAME   = 'yyyy_mm_dd';
  FORMATDH_FNAME  = 'yyyy_mm_dd_hh';
  LOG_EXT         = '.log';
  LOG_DIR         = 'Logs';
  STR_EMPTY       = '';
  CHAR_CRLF       = #13#10;
  CHAR_BACKSLASH  = '\';
  MASK_ALL_FILES  = '*.*';
  MASK_LOGFILE    = '*.log';
  CHAR_POINT      = '.';



// Procedimiento de REGISTRO
procedure Register;


//=========================================================================
//
// I M P L E M E N T A T I O N
//
//=========================================================================
implementation

uses
  {Generales} Forms, Types, Windows;

// Procedimiento de REGISTRO
procedure Register();
begin
  RegisterComponents('GLib', [TLogDisk]);
end;

{: Devuelve una lista de nombres de fichero encontrados a partir de la carpeta
   inicial StartDir, que cumplen el patrón especificado por FileMask. Mediante
   recursively se indica si se desea hacer la busqueda en los subdirectorios.
  @param    StartDir    Carpeta desde la que empezar a buscar.
  @param    FileMask    Patrón que han de cumplir los ficheros.
  @param    recursively Si hay que continuar la b´suqueda en los subdirectorios.
  @param    FilesList   Lista con los nombres de fichero encontrados.)
}
procedure FindFiles(StartDir, FileMask: string; recursively: boolean; var FilesList: TStringList);
var
  SRec: TSearchRec;
  DirList: TStringList;
  IsFound: Boolean;
  i: integer;
begin
  if (StartDir[length(StartDir)] <> CHAR_BACKSLASH) then begin
    StartDir := StartDir + CHAR_BACKSLASH;
  end;

  // Crear la lista de ficheos en el directorio StartDir (no directorios!)
  IsFound := FindFirst(StartDir + FileMask, faAnyFile - faDirectory, SRec) = 0;
  // MIentras encuentre
  while IsFound do  begin
    FilesList.Add(StartDir + SRec.Name);
    IsFound := FindNext(SRec) = 0;
  end;

  SysUtils.FindClose(SRec);

  // Recursivo?
  if (recursively) then begin
    // Build a list of subdirectories
    DirList := TStringList.Create;
    // proteccion
    try
      IsFound := FindFirst(StartDir + MASK_ALL_FILES, faAnyFile, SRec) = 0;
      while IsFound do
      begin
        if ((SRec.Attr and faDirectory) <> 0) and
          (SRec.Name[1] <> CHAR_POINT) then
          DirList.Add(StartDir + SRec.Name);
        IsFound := FindNext(SRec) = 0;
      end;
      SysUtils.FindClose(SRec);

      // Scan the list of subdirectories
      for i := 0 to DirList.Count - 1 do
        FindFiles(DirList[i], FileMask, recursively, FilesList);
    finally
      DirList.Free;
    end;
  end;
end;

//: Permite obtener el nombre de la computadora
function GetComputerNameStr():String;
var
  dw:Dword;
  Buffer:array[0..MAX_PATH] of char;
begin
  dw := MAX_PATH;
  if GetComputerName(Buffer, dw) then begin
    Result := Buffer;
  end
  else begin
    Result := STR_EMPTY;
  end;
end;

//: Permite obtener el nombre de usuario
function GetUserNameStr():String;
var
  dw:Dword;
  Buffer:array[0..MAX_PATH] of char;
begin
  dw := MAX_PATH;
  if GetUserName(Buffer, dw) then begin
    Result := Buffer;
  end
  else begin
    Result := STR_EMPTY;
  end;
end;


{ TLogDisk }
{-------------------------------------------------------------------------------}

constructor TLogDisk.Create(AOwner: TComponent);
begin
  inherited;

  // Ini
  Self.FLogWithTime := True;
  Self.FFileAccumulative := faNotUsed;
  Self.FFileNameFormat := ffDateTimeFormat;
  Self.FFileSavePath := spLogDirectory;
  Self.FSaveCab := True;
  Self.FSaveFooter := True;

  // Crear la estructura de log
  Self.FTSLog := TStringList.Create();

end;

destructor TLogDisk.Destroy();
var
  TS:TStringList;
  i:integer;
begin
  // Añadir el pie al Log
  _AddPie();
  // Grabas
  _Save();
  // Liberar
  FreeAndNil(Self.FTSLog);

  // Hay que limitar los ficheros en disco?
  if (Self.FMaxLogFiles > 0) then begin
    // ficheros en disco...
    TS := TStringList.Create();
    // protecicon
    try
      //TS Buscar ficheros de log
      FindFiles(ExtractFilePath(Self.FLogFileName), MASK_LOGFILE, False, TS);
      // Ordenar para ordenar
      TS.Sorted := True;

      // El número mayor que el marcado en la propiedad
      if (TS.Count > Self.FMaxLogFiles) then begin
        // Borrar los sobrantes (los primeros)
        for i := 1 to (TS.Count - Self.FMaxLogFiles) do begin
          DeleteFile(PChar(TS[i - 1]));
        end;
      end;

    finally
      FreeAndNil(TS);
    end;
  end;

  // heredado
  inherited;
end;

// Sobrecargamos la rutina de Loaded.
procedure TLogDisk.Loaded();
var
  path:string;
begin

  inherited;

  // Nombre del fichero de log
  if (Self.FFileNameFormat = ffDateTimeFormat) then begin
    Self.FLogFileName := FormatDateTime(FORMATDT_FNAME, Now()) + LOG_EXT;
  end
  else if (Self.FFileNameFormat = ffAppNameFormat) then begin
    Self.FLogFileName := ChangeFileExt(ExtractFileName(Application.ExeName), LOG_EXT);
  end
  else if (Self.FFileNameFormat = ffDateFormat) then begin
    Self.FLogFileName := FormatDateTime(FORMATD_FNAME, Now()) + LOG_EXT;
  end
  else if (Self.FFileNameFormat = ffAccumulative) then begin

    // 1 fichero por hora
    if (Self.FileAccumulative = faFilexHour) then begin
      Self.FLogFileName := FormatDateTime(FORMATDH_FNAME, Now()) + LOG_EXT;
    end
    // 1 fichero por día
    else if (Self.FileAccumulative = faFilexDay) then begin
      Self.FLogFileName := FormatDateTime(FORMATD_FNAME, Now()) + LOG_EXT;
    end;
  end;

  // Path
  if (Self.FFileSavePath = spLogDirectory) then begin
    path := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) +
            LOG_DIR;
    path := IncludeTrailingPathDelimiter(path);
  end
  else if (Self.FFileSavePath = spAppDirectory) then begin
    path := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));
  end;

  // fileName
  Self.FLogFileName := path + Self.FLogFileName;

  // Está en diseño
  if (csDesigning	in Self.ComponentState) then begin
    Exit;
  end;

  // Hay que cargar el actual?
  if (Self.FileAccumulative = faFilexHour) or
     (Self.FileAccumulative = faFilexDay) then begin
     // Existe?
     if FileExists(Self.FLogFileName) then begin
      Self.LogLines.LoadFromFile(Self.FLogFileName);
     end;
  end;

  // Añadir la cabecera
  _AddCab();
  // Grabar
  _Save();
end;

procedure TLogDisk._Log(AStr: string);
var
  Str:string;
begin

  // Si no está activado => nada
  if not (Self.FActive) then Exit;

  // Leventar el evento de añadir un nuevo string
  if Assigned(Self.FOnAddStringEvent) then begin
    Self.FOnAddStringEvent(AStr);
  end;

  Str := STR_EMPTY;
  // Hay que añadir time?
  if (Self.FLogWithTime) then begin
    Str := FormatDateTime('hh:mm:ss:zzz', Now()) + ' -> ';
  end;

  Str := Str + AStr;
  Self.FTSLog.Add(Str);

  // Grabación continua a disco
  if (Self.FContinuousWrite) then begin
    _Save();
  end;

end;



procedure TLogDisk._Save();
begin

  // Si no está activado => nada
  if not (Self.FActive) then Exit;

  // No está en diseño
  if not (csDesigning	in Self.ComponentState) then begin
    // Hay algo en el nombre
    if (Self.FLogFileName <> STR_EMPTY) then begin
      // Directori
      ForceDirectories(ExtractFilePath(Self.FLogFileName));
      Self.FLogPath := ExtractFilePath(Self.FLogFileName);
      // Grabar
      Self.FTSLog.SaveToFile(Self.FLogFileName);
      // Asignado?
      if Assigned(Self.FOnSaveEvent) then begin
        Self.FOnSaveEvent(Self);
    end;
  end;
end;
end;


//: Procedimientos de log.
procedure TLogDisk.Log(AStr: string);
begin
  _Log(AStr);
end;

procedure TLogDisk.Log(AStrings:TStrings);
begin
  _Log(AStrings.Text);
end;

procedure TLogDisk.Log(AStr, Value: string);
begin
  _Log(AStr + ' ' + value);
end;
procedure TLogDisk.Log(AStr:string; Value: integer);
begin
  _Log(AStr + ' ' + IntToStr(value));
end;
procedure TLogDisk.Log(AStr:string; Value: boolean);
begin
  _Log(AStr + ' ' + BoolToStr(value, True));
end;


procedure TLogDisk._AddCab();
var
  Str:string;
begin

  // No se graba la cabecera?
  if not (Self.FSaveCab) then begin
    Exit
  end;

  // Añadir datos de cabecera
  Str := 'Aplicación:    ' + ExtractFileName(Application.ExeName);
  Self.FTSLog.Add(Str);
  Str := 'Path:          ' + ExtractFilePath(Application.ExeName);
  Self.FTSLog.Add(Str);
  Str := 'Usuario:       ' + GetUserNameStr();
  Self.FTSLog.Add(Str);
  Str := 'ComputerName:  ' + GetComputerNameStr();
  Self.FTSLog.Add(Str);
  Str := '-----------------------------------------------------------------';
  Self.FTSLog.Add(Str);
end;

procedure TLogDisk._AddPie();
var
  Str:string;
begin

  // No se graba El pie?
  if not (Self.FSaveFooter) then begin
    Exit
  end;


  // Añadir datos de pie (finalizacion)
  Str := '-----------------------------------------------------------------';
  Self.FTSLog.Add(Str);
  Str := 'El log ha finalizado correctamente.';
  Self.FTSLog.Add(Str);
  Str := '-----------------------------------------------------------------';
  Self.FTSLog.Add(Str);


end;
//: Grabar cambios a disco
procedure TLogDisk.SaveToDisk();
begin
  _Save();
end;

procedure TLogDisk.SetFileNameFormat(const Value: TFileNameFormat);
begin
  Self.FFileNameFormat := Value;
  // Nombre de los igual al de la aplicación, resetamos Maxlogfiles
  if (self.FFileNameFormat = ffAppNameFormat) then begin
    Self.FMaxLogFiles := 0;
  end;
  // Es valor accumulative?
  if (Self.FFileNameFormat = ffAccumulative) then begin
    Self.FFileAccumulative := faFilexHour;
  end
  else if (Self.FFileNameFormat <> ffAccumulative) then begin
    Self.FFileAccumulative := faNotUsed;
  end;
end;

procedure TLogDisk.SetFileSavePath(const Value: TFileSavePath);
begin
  Self.FFileSavePath := Value;
  // En el propio directorio resetamos Maxlogfiles
  if (self.FFileSavePath = spAppDirectory) then begin
    Self.FMaxLogFiles := 0;
  end;
end;

//: permite acceder a las líneas del Log.
function TLogDisk.LogLines(): TStrings;
begin
  // Lineas del Log.
  Result := Self.FTSLog;
end;

procedure TLogDisk.SetFileAccumulative(const Value: TFileAccumulative);
begin
  // Valor
  Self.FFileAccumulative := Value;
  // Es diferente del valor "nulo"?
  if (Self.FFileAccumulative <> faNotUsed) then begin
    Self.FFileNameFormat := ffAccumulative;
  end
  else if (Self.FFileAccumulative = faNotUsed) then begin
    Self.FFileNameFormat := ffDateTimeFormat;
  end;

end;

end.

