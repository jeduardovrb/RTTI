unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Rtti, Pessoa, uTabela, Attributes;

type
  TfrmPrincipal = class(TForm)
    btnGetMethod: TButton;
    mmRtti: TMemo;
    btnGetField: TButton;
    btnGetProperty: TButton;
    btnGetPropertiesTypes: TButton;
    btnSetValue: TButton;
    btnTRttiMethodTypes: TButton;
    btnInvoke: TButton;
    btnRttiValidar: TButton;
    btnNomeTabela: TButton;
    procedure btnGetMethodClick(Sender: TObject);
    procedure btnGetFieldClick(Sender: TObject);
    procedure btnGetPropertyClick(Sender: TObject);
    procedure btnGetPropertiesTypesClick(Sender: TObject);
    procedure btnSetValueClick(Sender: TObject);
    procedure btnTRttiMethodTypesClick(Sender: TObject);
    procedure btnInvokeClick(Sender: TObject);
    procedure btnNomeTabelaClick(Sender: TObject);
    procedure btnRttiValidarClick(Sender: TObject);
  private
    procedure PropertyTypeValue(AObj: TPessoa);
    procedure PropertySetValeu(AObj: TObject);
    procedure Invoke(AObj: TObject);
    function Valida(AObj: TObject): boolean;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.btnGetFieldClick(Sender: TObject);
var
  VCtx  : TRttiContext;
  VType : TRttiType;
  VField: TRttiField;
begin
  VCtx := TRttiContext.Create;
  try
    VType := VCtx.GetType(TPessoa);

    for VField in VType.GetFields do
      mmRtti.Lines.Add(VField.Name);
  finally
    VCtx.Free
  end;
end;

procedure TfrmPrincipal.btnGetMethodClick(Sender: TObject);
var
  VCtx : TRttiContext;
  VType: TRttiType;
  VMet : TRttiMethod;
begin
  VCtx := TRttiContext.Create;
  try
    VType := VCtx.GetType(TPessoa);

    for VMet in VType.GetMethods do
      mmRtti.Lines.Add(VMet.Name);
  finally
    VCtx.Free;
  end;
end;

procedure TfrmPrincipal.btnGetPropertiesTypesClick(Sender: TObject);
var
  VPessoa: TPessoa;
begin
  VPessoa := TPessoa.Create;
  try
    VPessoa.Codigo := 1;
    VPessoa.Nome   := 'Edimilson';

    Self.PropertyTypeValue(VPessoa);
  finally
    VPessoa.Free;
  end;
end;

procedure TfrmPrincipal.btnGetPropertyClick(Sender: TObject);
var
  VCtx : TRttiContext;
  VType: TRttiType;
  VProp: TRttiProperty;
begin
  VCtx := TRttiContext.Create;
  try
    VType := VCtx.GetType(TPessoa);

    for VProp in VType.GetProperties do
      mmRtti.Lines.Add(VProp.Name);
  finally
    VCtx.Free
  end;
end;

procedure TfrmPrincipal.btnInvokeClick(Sender: TObject);
var
  VPessoa: TPessoa;
begin
  VPessoa := TPessoa.Create;
  try
    VPessoa.Codigo := 15;
    VPessoa.Nome   := 'Gabriel';

    Self.Invoke(VPessoa);
  finally
    VPessoa.Free;
  end;
end;

procedure TfrmPrincipal.btnNomeTabelaClick(Sender: TObject);
var
  VCtx : TRttiContext;
  VType: TRttiType;
  VAtt : TCustomAttribute;
begin
  VCtx   := TRttiContext.Create();

  VType  := VCtx.GetType(TPessoa.ClassInfo);

  for VAtt in VType.GetAttributes() do
  begin
    if VAtt is TDataTableAttribute then
      mmRtti.Lines.Add(TDataTableAttribute(VAtt).Tabela);
  end;
end;

procedure TfrmPrincipal.btnRttiValidarClick(Sender: TObject);
var
  VPessoa: TPessoa;
begin
  VPessoa := TPessoa.Create;
  try
    VPessoa.Codigo := 100;
    VPessoa.Nome   := 'Jacinto';

    Self.Valida(VPessoa);
  finally
    VPessoa.Free;
  end;
end;

procedure TfrmPrincipal.btnSetValueClick(Sender: TObject);
var
  VPessoa: TPessoa;
begin
  VPessoa := TPessoa.Create;
  try
    VPessoa.Codigo := 10;
    VPessoa.Nome   := 'Vazio';

    mmRtti.Lines.Add(VPessoa.Nome);

    Self.PropertySetValeu(VPessoa);

    mmRtti.Lines.Add(VPessoa.Nome);
  finally
    FreeAndNil(VPessoa);
  end;
end;

procedure TfrmPrincipal.btnTRttiMethodTypesClick(Sender: TObject);
var
  VCtx : TRttiContext;
  VType: TRttiType;
  VMet : TRttiMethod;
  VPar : TRttiParameter;
begin
  VCtx := TRttiContext.Create;
  try
    VType := VCtx.GetType(TPessoa);

    for VMet in VType.GetMethods do
    begin
      //Ignora métodos que não foram implementados diretamente em TPessoa
      if VMet.Parent.Name <> 'TPessoa' then
        Continue;

      mmRtti.Lines.Add('Método ' + VMet.Name);

      if VMet.ReturnType <> nil then
        mmRtti.Lines.Add(' Retorno ' + VMet.ReturnType.ToString)
      else
        mmRtti.Lines.Add(' Retorno ' + 'Não tem.');

      mmRtti.Lines.Add(' Parâmetros');

      for VPar in VMet.GetParameters do
        mmRtti.Lines.Add('   ' + VPar.Name + ': ' + VPar.ParamType.ToString) ;

      mmRtti.Lines.Add('');
    end;
  finally
    VCtx.Free;
  end;
end;

procedure TfrmPrincipal.Invoke(AObj: TObject);
var
  VCtx : TRttiContext;
  VType: TRttiType;
  VMet : TRttiMethod;
  VPar : Array of TValue;
begin
  VCtx := TRttiContext.Create;
  try
    VType := VCtx.GetType(AObj.ClassType);
    VMet := VType.GetMethod('Insert');

    SetLength(VPar, 1);

    VPar[0] := 1;

    VMet.Invoke(AObj, VPar);
  finally
    VCtx.Free;
  end;
end;

procedure TfrmPrincipal.PropertySetValeu(AObj: TObject);
var
  VCtx : TRttiContext;
  VType: TRttiType;
  VProp: TRttiProperty;
begin
  VCtx := TRttiContext.Create;
  try
    VType := VCtx.GetType(AObj.ClassType);

    VProp := VType.GetProperty('Nome');

    VProp.SetValue(AObj, 'Octávio Augusto');
  finally
    VCtx.Free;
  end;
end;

procedure TfrmPrincipal.PropertyTypeValue(AObj: TPessoa);
var
  VCtx : TRttiContext;
  VType: TRttiType;
  VProp: TRttiProperty;
begin
  VCtx := TRttiContext.Create;
  try
    VType := VCtx.GetType(AObj.ClassType);

    for VProp in VType.GetProperties do
      mmRtti.Lines.Add(VProp.Name + ': ' + VProp.PropertyType.ToString + '= ' + VProp.GetValue(AObj).ToString);
  finally
    VCtx.Free
  end;
end;

function TfrmPrincipal.Valida(AObj: TObject): Boolean;
var
  VCtx  : TRttiContext;
  VType : TRttiType;
  VProp : TRttiProperty;
  VAtrib: TCustomAttribute;
begin
  Result := True;

  VCtx := TRttiContext.Create;
  try
    VType := VCtx.GetType(AObj.ClassInfo);

    for VProp in VType.GetProperties do
    begin
      for VAtrib in VProp.GetAttributes do
      begin
        if VAtrib is TDataFieldAttribute then
        begin
          if not (VAtrib as TDataFieldAttribute).Validar(VProp.GetValue(AObj)) then
            Result := False;

          mmRtti.Lines.Add(TDataFieldAttribute(VAtrib).Campo);

          if TDataFieldAttribute(VAtrib).CampoObrigatorio then
            raise Exception.Create(TDataFieldAttribute(VAtrib).Mensagem);
        end;
      end;
    end;
  finally
    VCtx.Free;
  end;
end;

end.
