program VerificarTightVNC;

uses
  SysUtils, WinSock;

function VerificarPortaAberta(const Host: string; Porta: Word): Boolean;
var
  WSAData: TWSAData;
  Sock: TSocket;
  Addr: TSockAddrIn;
begin
  Result := False;
  if WSAStartup(MakeWord(2, 2), WSAData) <> 0 then
    Exit;

  Sock := socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
  if Sock = INVALID_SOCKET then
    Exit;

  Addr.sin_family := AF_INET;
  Addr.sin_port := htons(Porta);
  Addr.sin_addr.S_addr := inet_addr(PChar(Host));

  if connect(Sock, Addr, SizeOf(Addr)) = 0 then
    Result := True;

  closesocket(Sock);
  WSACleanup;
end;

const
  HostParaVerificar = 'localhost'; 

begin
  if VerificarPortaAberta(HostParaVerificar, 5900) then
    Writeln('O serviço TightVNC Server está ativo na máquina.')
  else
    Writeln('O serviço TightVNC Server não está ativo na máquina.');
end.
