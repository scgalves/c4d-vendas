unit RTTI.FieldName;

interface

uses
  System.SysUtils;

type
  FieldName = class(TCustomAttribute)
  private
    FNome: string;
  public
    constructor Create(const AName: string);
    property Nome: string read FNome write FNome;
  end;

implementation

constructor FieldName.Create(const AName: string);
begin
  FNome := AName;
end;

end.
