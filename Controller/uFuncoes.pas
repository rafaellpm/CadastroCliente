unit uFuncoes;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.DApt, System.SysUtils;

function CriarQuery(AFDConn: TFDConnection): TFDQuery;
function FormatarCPFCNPJ(AText: String): string;
function CpfValido(ACPF: string): boolean;
function CnpjValido(ACNPJ: string): boolean;
function SomenteNumeros(AText: string): string;
function FormatarTelefone(AText: String): string;
function EmailValido(AText: string): Boolean;

implementation


function CriarQuery(AFDConn: TFDConnection): TFDQuery;
var Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  Qry.Connection := AFDConn;

  Result := Qry;
end;

function FormatarCPFCNPJ(AText: String): string;
begin
  if Length(AText) <= 11 then
    Result := Copy(AText,1,3) + '.' + Copy(AText,4,3) + '.' + Copy(AText,7,3) + '-' + Copy(AText,10,2)
  else
    Result := Copy(AText,1,2) + '.' + Copy(AText,3,3) + '.' + Copy(AText,6,3) + '/' + Copy(AText,9,4) + '-' + Copy(AText,13,2);
end;

function FormatarTelefone(AText: String): string;
begin
  if Length(AText) = 11 then
    Result := '(' + Copy(AText, 1,2) + ')' + Copy(AText,3, 5) + '-' + Copy(AText, 8,4)
  else
  if Length(AText) = 10 then
    Result := '(' + Copy(AText, 1,2) + ')' + Copy(AText,3, 4) + '-' + Copy(AText, 7,4)
  else
  if Length(AText) = 14 then
    Result := '(' + Copy(AText, 3,2) + ')' + Copy(AText,5, 5) + '-' + Copy(AText, 10,4);
end;

function CpfValido(ACPF: string): boolean;
var  dig10, dig11: string;
    s, i, r, peso: integer;
begin
  if ((ACPF = '00000000000') or (ACPF = '11111111111') or (ACPF = '22222222222') or (ACPF = '33333333333') or (ACPF = '44444444444') or (ACPF = '55555555555') or (ACPF = '66666666666') or (ACPF = '77777777777') or (ACPF = '88888888888') or (ACPF = '99999999999') or (length(ACPF) <> 11)) then
  begin
    Result := false;
    exit;
  end;

  try
    s := 0;
    peso := 10;
    for i := 1 to 9 do
    begin
      s := s + (StrToInt(ACPF[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11)) then
      dig10 := '0'
    else
      str(r: 1, dig10);

    s := 0;
    peso := 11;
    for i := 1 to 10 do
    begin
      s := s + (StrToInt(ACPF[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11)) then
      dig11 := '0'
    else
      str(r: 1, dig11);

    if ((dig10 = ACPF[10]) and (dig11 = ACPF[11])) then
      Result := true
    else
      Result := false;
  except
    Result := false
  end;
end;

function CnpjValido(ACNPJ: string): boolean;
var
  dig13, dig14: string;
  sm, i, r, peso: integer;
begin
  if ((ACNPJ = '00000000000000') or (ACNPJ = '11111111111111') or (ACNPJ = '22222222222222')
      or (ACNPJ = '33333333333333') or (ACNPJ = '44444444444444') or (ACNPJ = '55555555555555')
      or (ACNPJ = '66666666666666') or (ACNPJ = '77777777777777') or (ACNPJ = '88888888888888')
      or (ACNPJ = '99999999999999') or (length(ACNPJ) <> 14)) then
  begin
    Result := false;
    exit;
  end;

  try
    sm := 0;
    peso := 2;

    for i := 12 downto 1 do
    begin
      sm := sm + (StrToInt(ACNPJ[i]) * peso);
      peso := peso + 1;
      if (peso = 10) then
        peso := 2;
    end;

    r := sm mod 11;
    if ((r = 0) or (r = 1)) then
      dig13 := '0'
    else
      str((11 - r): 1, dig13);

    sm := 0;
    peso := 2;
    for i := 13 downto 1 do
    begin
      sm := sm + (StrToInt(ACNPJ[i]) * peso);
      peso := peso + 1;
      if (peso = 10) then
        peso := 2;
    end;

    r := sm mod 11;

    if ((r = 0) or (r = 1)) then
      dig14 := '0'
    else
      str((11 - r): 1, dig14);

    if ((dig13 = ACNPJ[13]) and (dig14 = ACNPJ[14])) then
      Result := true
    else
      Result := false;

  except
    Result := false
  end;
end;

function SomenteNumeros(AText: string): string;
var
  vText : PChar;
begin
  vText := PChar(AText);
  Result := '';

  while (vText^ <> #0) do
  begin
    {$IFDEF UNICODE}
    if CharInSet(vText^, ['0'..'9']) then
    {$ELSE}
    if vText^ in ['0'..'9'] then
    {$ENDIF}
      Result := Result + vText^;

    Inc(vText);
  end;
end;


function EmailValido(AText: string): Boolean;
begin
  AText := Trim(UpperCase(AText));
  if Pos('@', AText) > 1 then
  begin
    Delete(AText, 1, pos('@', AText));
    Result := (Length(AText) > 0) and (Pos('.', AText) > 2) and (Pos(' ', AText) = 0);
  end
  else
  begin
    Result := False;
  end;
end;

end.
