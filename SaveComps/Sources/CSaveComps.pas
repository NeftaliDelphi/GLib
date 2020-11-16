{
TSaveComps  Component Version 1.4 - Suite GLib
Copyright (©) 2005,  by Germán Estévez (Neftalí)

  Permite guardar la posicion de todos los controles que se encuentran en el
  formulario. Utiliza un fichero INI.
  Es indispensable para grabar la posición de un componente que tenga definida
  la propiedad Name (para controles creados en RunTime).

Utilización/Usage:
  Coloque el componente en el frmulario y activelo.
  Place the component in the form and enable it.  

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
unit CSaveComps;
{
=========================================================================

  CSaveComps.pas

  Componente

========================================================================
  Historia de las Versiones
------------------------------------------------------------------------


  23/03/2006  * Version 1.5
              Añadidas propiedades para seleccionar los controles que se quieren
              almacenar... (SelectTaggedControls y SelectTag)
  15/01/2006  * Version 1.4
              Se ha añadido evento para detectar componentes no existentes en el
              formulario; Está pensado para componentes creados en ejecución.

  21/12/2005  * Version 1.3
              Se ha añadido la caracteristica de guardar propiedades de tipo Ttrings

  20/12/2005  * version 1.2
              Se ha añadido la posibilidad de guardar otras propiedades.
              Prop. SavedProperties.

  18/11/2005  * Creación.


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
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type

  //: Tipo para el evento OnNotExistComponent
  TNotExistComponentEvent = procedure(TObject:TObject;
                                      ComponentName:String;
                                      ComponentClassName:String;
                                      ComponentParent:String;
                                      Props:TStrings) of Object;

  //: Perimite grabar la posición de los componentes del formulario.
  TSaveComps = class(TComponent)
  private
    FOldOnDestroy: TNotifyEvent;
    FIniFileName: string;
    FActive: boolean;
    FSavedProperties: TStrings;
    FOnNotExistComponentEvent: TNotExistComponentEvent;
    FSelectTaggedControls: Boolean;
    FSelectTag: Integer;

    // propcedimiento para sustituir la destroy del form
    procedure MyOnDestroy(Sender: TObject);
    procedure SetIniFileName(const Value: string);
    function GetIniFileName: string;
    procedure SetSavedProperties(const Value: TStrings);

  protected
    //: Sobreescribimos el Loadde.
    procedure Loaded; override;
  public
    //: Carga las porpiedades de los componentes de fichero.
    procedure LoadComponentsProps;
    // Graba las porpiedades de los componentes en fichero.
    procedure SaveComponentsProps;
    //: Redefinimos el contructor de la clase
    constructor Create(AOwner: TComponent); override;
    //: Redefinimos el destructor
    destructor Destroy(); override;

  published
    //: Si Grabar y Leer se hace de forma automática
    property Active: boolean read FActive write FActive default True;
    //: Nombre del fichero
    property IniFileName: string read GetIniFileName write SetIniFileName;
    //: Nombre de las propiedades a guardar
    property SavedProperties:TStrings read FSavedProperties write SetSavedProperties;
    //: Evento al recuperar propiedades para un componente que no existe (para crear en Runtime)
    property OnNotExistComponentEvent:TNotExistComponentEvent
      read FOnNotExistComponentEvent write FOnNotExistComponentEvent;
    //: Activa que sólo se guarden los controles con un determinado TAG
    property SelectTaggedControls:Boolean read FSelectTaggedControls
        write FSelectTaggedControls default False;
    // TAG para los controles a guardar (depende de la prop. SelectTaggedControls)
    property SelectTag:Integer read FSelectTag write FSelectTag default 999;
  end;



const
  STR_EMPTY = '';

procedure Register;

//=========================================================================
//
// I M P L E M E N T A T I O N
//
//=========================================================================
implementation

uses
  TypInfo, IniFiles;

procedure Register;
begin
  RegisterComponents('GLib', [TSaveComps]);
end;


{: Constructor de la clase redefinido. }
constructor TSaveComps.Create(AOwner: TComponent);
begin
  // Heredado
  inherited Create(AOwner);
  // Inicializaciones
  Self.FActive := True;
  Self.FIniFileName := STR_EMPTY;
  Self.FSelectTag := 9999;

  // Propiedades que se van a guardar
  Self.FSavedProperties := TStringList.Create();

  // Por defecto añadimos
  // Rellenar las propiedades (por ahora se pueden añadir sólo de tipo Integer)
  Self.FSavedProperties.Add('Left');
  Self.FSavedProperties.Add('Top');
  Self.FSavedProperties.Add('Width');
  Self.FSavedProperties.Add('Height');

end;

//: método de escritura para la propiedad.
procedure TSaveComps.SetIniFileName(const Value: string);
begin
  // Ha cambiado?
  if (Self.FIniFileName <> Value) then begin
    Self.FIniFileName := Value;
  end;
end;

//: Sobreescribimos el Loaded.
procedure TSaveComps.Loaded();
begin
  // Heradado
  inherited Loaded;

  // no está en diseño?
  if not (csDesigning in ComponentState) then begin
    // Cargar las posiciones almacenadas
    Self.LoadComponentsProps();

    // Activado y el owner es un form?
    if (Self.FActive) and (Owner is TForm) then begin
      // Capturar el evento de destruir.
      Self.FOldOnDestroy := (Owner as TForm).OnDestroy;
      // Asignar el nuevo
      (Owner as TForm).OnDestroy := Self.MyOnDestroy;
    end;
  end;
end;

//: Evento que reemplaza al que había en el form.
procedure TSaveComps.MyOnDestroy(Sender: TObject);
begin
  // Grabar el estado
  if (Self.FActive) then begin
    // Grebar
    Self.SaveComponentsProps();
  end;

  // Asignada la lista de propiedades
  if Assigned(FSavedProperties) then begin
    FreeAndNil(FSavedProperties);
  end;

  // Asignado el evento antiguo? => Lanzarlo
  if Assigned(Self.FOldOnDestroy) then begin
    Self.FOldOnDestroy(Self);
  end;
end;

//: Permite cargar las posiciones almacenadas en el fichero.
procedure TSaveComps.LoadComponentsProps();
var
  IniFile: TIniFile;
  prop: PPropInfo;
  i, j, k, Value, Index: Integer;
  s, ValueStr, compName, ClassStr, ParentStr: string;
  comp: TComponent;
  TS, TSValues: TStrings;
  CompNotExist:TStringList;
begin

  // Crear el fichero
  IniFile := TIniFile.Create(Self.IniFileName);
  TS := TStringList.Create();
  TSValues := TStringList.Create();
  CompNotExist := TStringList.Create();
  CompNotExist.Sorted := True;

  // Cargar los de disco
  IniFile.ReadSections(CompNotExist);

  // Proteccion para liberar
  try
    // Para todos los componentes del owner.
    for i := 0 to (Owner.ComponentCount - 1) do begin
      // Componente actual
      comp := Owner.Components[i];
      // tiene nombre? (creados en runtime)
      if (comp.Name <> STR_EMPTY) then begin

        // Buscarlo en la lista y eliminarlo
        if (CompNotExist.Find(comp.Name, Index)) then begin
          CompNotExist.Delete(Index);
        end;

        // Activada la porp. SelectTaggedControls?
        if not (FSelectTaggedControls) or
           ((FSelectTaggedControls) and (comp.Tag = FSelectTag)) then begin

          // Para todas las propiedades que se deben almacenar
          for j := 0 to (Self.FSavedProperties.Count - 1) do begin
            // Acceder a la propiedad.
            prop := GetPropInfo(Owner.Components[i].ClassInfo, Self.FSavedProperties[j]);
            // Encontrada la info.
            if (prop <> nil) then begin
              if (prop^.PropType^.Kind in [tkInteger, tkEnumeration]) then begin
                // Cargar el valor
                Value := IniFile.ReadInteger(comp.Name, Self.FSavedProperties[j], -99);
                // se ha encontrado?
                if (Value <> -99) then begin
                  // Asignarla
                  SetOrdProp(Owner.Components[i], Self.FSavedProperties[j], Value);
                end;
              end
              // TIPO STRING
              else if (prop^.PropType^.Kind in [tkLString, tkWString, tkString]) then begin
                // Cargar el valor
                ValueStr := IniFile.ReadString(comp.Name, Self.FSavedProperties[j], STR_EMPTY);
                // se ha encontrado?
                if (ValueStr <> STR_EMPTY) then begin
                  // Asignarla
                  SetStrProp(Owner.Components[i], Self.FSavedProperties[j], ValueStr);
                end;
              end
              // Tipo TStrings
              else if (prop^.PropType^.Kind = tkClass) and (prop^.PropType^.Name = 'TStrings') then begin
                // Obtener
                IniFile.ReadSectionValues(comp.Name + '@#$' + Self.FSavedProperties[j], TS);

                TSValues.Clear;
                for k := 0 to (TS.Count - 1) do begin
                  TSValues.Add(TS.Values[TS.Names[k]]);
                end;
                // Encontrado?
                if (TSValues.Count > 0) then begin
                  // Asignar
                  SetObjectProp(Owner.Components[i], Self.FSavedProperties[j], TSValues);
                end;
              end;
            end; // prop <> nil
          end;
        end; // if TaggedControls
      end; // comp.Name <> STR_EMPTY
    end;

    // Los que han quedado
    for Index := 0 to (CompNotExist.Count - 1) do begin
      //MessageDlg('Comp ' +  + ' no existe', mtInformation, [mbOK], 0);
      CompName := CompNotExist[Index];
      TSValues.Clear;
      // Asignado el evento?
      if Assigned(Self.FOnNotExistComponentEvent) then begin

        ClassStr := IniFile.ReadString(compName, 'ClassName', STR_EMPTY);
        ParentStr := IniFile.ReadString(compName, 'Parent', STR_EMPTY);
        // Seccion con las propiedades
        IniFile.ReadSectionValues(compName, TSValues);

        // levantar el evento
        Self.FOnNotExistComponentEvent(Self, CompName, ClassStr, ParentStr, TSValues);
      end;
    end;


  // Liberar
  finally
    FreeAndNil(CompNotExist);
    IniFile.Free;
    FreeAndNil(TS);
    FreeAndNil(TSValues);
  end;
end;

//: Graba las porpiedades de los componentes.
procedure TSaveComps.SaveComponentsProps();
var
  IniFile: TIniFile;
  prop: PPropInfo;
  i, j, k: Integer;
  comp: TComponent;
  TS:TStrings;
begin

  // Si existe el fichero, renombrarlo...
  if FileExists(Self.IniFileName) then begin
    MoveFile(PChar(IniFileName), PChar(ChangeFileExt(IniFileName, '.bak')));
  end;

  // Crear el fichero
  IniFile := TIniFile.Create(Self.IniFileName);

  // Propteccion para liberar
  try
    // Para todos los componntes del Owner...
    for i := 0 to (Owner.ComponentCount - 1) do begin
      // Componente actual
      comp := Owner.Components[i];

      // Activada la porp. SelectTaggedControls?
      if not (FSelectTaggedControls) or
         ((FSelectTaggedControls) and (comp.Tag = FSelectTag)) then begin

        // tiene nombre?
        if (comp.Name <> '') then begin
          // Para las propiedades a leer...
          for j := 0 to (Self.FSavedProperties.Count - 1) do begin
            // Acceso a la propiedad
            prop := GetPropInfo(Owner.Components[i].ClassInfo, Self.FSavedProperties[j]);
            // Encontrada la info. de propiedad?
            if (prop <> nil) then begin
              // Tipo Integer (por seguridad)
              if (prop^.PropType^.Kind in [tkInteger, tkEnumeration]) then begin
                // Escribir
                IniFile.WriteInteger(comp.Name, Self.FSavedProperties[j],
                                     GetOrdProp(Owner.Components[i], prop));
              end
              else if (prop^.PropType^.Kind in [tkLString, tkWString, tkString]) then begin
                // Escribir
                IniFile.WriteString(comp.Name, Self.FSavedProperties[j],
                                    GetStrProp(Owner.Components[i], prop));
              end
              // Tipo TStrings
              else if (prop^.PropType^.Kind = tkClass) and (prop^.PropType^.Name = 'TStrings') then begin
                // Escribir TStrings
                TS := TStrings(GetObjectProp(Owner.Components[i], prop));
                // Hay algo?
                if (TS.Count > 0) then begin
                  // Borrar la seccion
                  IniFile.EraseSection(comp.Name + '@#$' + Self.FSavedProperties[j]);
                  // Guardar los Strings
                  for k := 0 to (TS.Count - 1) do begin
                    IniFile.WriteString(comp.Name + '@#$' + Self.FSavedProperties[j],
                                        Self.FSavedProperties[j] + '@#$' + IntToStr(k),
                                        TS[k]);
                  end;
                end;
              end;
            end;
          end; // para cada prop.

          // Escribir la prop. className de forma manual
          IniFile.WriteString(comp.Name, 'ClassName', comp.ClassName);
          // Parent "a mano"
          if (comp is TControl) then begin
            // Asignado el parent?
            if Assigned(TControl(comp).Parent) then begin
              IniFile.WriteString(comp.Name, 'Parent', TControl(comp).Parent.Name);
            end;
          end;

        end;
      end; // TaggedControls
    end; // para cada comp.

    // Actuaalizar
    IniFile.UpdateFile;

  // liberar
  finally
    IniFile.Free;
  end;
end;

//: funcion para lectura de la porpiedad.
function TSaveComps.GetIniFileName(): string;
begin

  // No estamos en diseño
  if not (csDesigning in ComponentState) then begin
    // No se ha rellenado?
    if (Self.FIniFileName = STR_EMPTY) and (Self.Active) then begin
      Result := ChangeFileExt(Application.ExeName, '.INI');
      Exit;
    end;
  end;

  // Tiene algo...
  Result := Trim(Self.FIniFileName);
  // No estamos en diseño
  if not (csDesigning in ComponentState) then begin
    // No se ha definido extension? ==> Añadimos la ext. INI
    if (Pos('.', Result) = 0) then begin
      Result := Result + '.INI';
    end;
  end;
end;

procedure TSaveComps.SetSavedProperties(const Value: TStrings);
begin
  // Asignar el valor.
  Self.FSavedProperties.Assign(Value);
end;

//: Redefinimos el destructor
destructor TSaveComps.Destroy();
begin

  inherited;

end;

end.

