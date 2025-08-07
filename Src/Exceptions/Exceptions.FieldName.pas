unit Exceptions.FieldName;

interface

uses
  System.SysUtils;

type
  ExceptionsFieldName = class(Exception)
  private
    FFieldName: String;
  public
    constructor Create(const AMessage, AFieldName: string); reintroduce;
    property FieldName: String read FFieldName write FFieldName;
  end;

implementation

constructor ExceptionsFieldName.Create(const AMessage, AFieldName: string);
begin
  Self.Message := AMessage;
  FFieldName := AFieldName;
end;

end.
