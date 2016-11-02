unit uTabela;

interface


type
  TDataTableAttribute = class(TCustomAttribute)
  private
    FTabela: string;
  public
    constructor Create(ATabela: string);
    property Tabela: string read FTabela write FTabela;
  end;

implementation

{ TDataTable }

constructor TDataTableAttribute.Create(ATabela: string);
begin
  FTabela := ATabela;
end;

end.

