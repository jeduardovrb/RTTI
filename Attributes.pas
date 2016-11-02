unit Attributes;

interface

uses
  System.Rtti, System.SysUtils;

type
  TDataFieldAttribute = class(TCustomAttribute)
  private
    FCampo: string;
    FValidarCampo: Boolean;
    FMensagem: string;
    FCampoObrigado: Boolean;
  public
    constructor Create(ACampo, AMsg: string; AValidar: Boolean);

    function Validar(AValue : TValue) : Boolean; virtual;

    property Campo: string read FCampo write FCampo;
    property ValidarCampo: Boolean read FValidarCampo write FValidarCampo;
    property Mensagem: string read FMensagem write FMensagem;
    property CampoObrigatorio: Boolean read FCampoObrigado write FCampoObrigado;
  end;

implementation

{ TDataFieldAttribute }

constructor TDataFieldAttribute.Create(ACampo, AMsg: string; AValidar: Boolean);
begin
  FCampo := ACampo;
  FValidarCampo := AValidar;
  FMensagem := AMsg;
end;

function TDataFieldAttribute.Validar(AValue: TValue): Boolean;
begin
  Result := False;

  if FValidarCampo then
  begin
    FCampoObrigado := AValue.AsString = EmptyStr;

    Result := FCampoObrigado;
  end;
end;

{ TDataTableAttribute }

end.
