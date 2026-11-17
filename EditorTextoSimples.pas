program EditorTextoSimples;

uses sysutils;

const
    MAX = 500;

var
    texto: array[1..MAX] of string;
    linhas: integer;
    nomeArquivo: string;

procedure NovoTexto;
begin
    linhas := 0;
    nomeArquivo := '';
    writeln('Novo texto criado.');
end;

procedure MostrarTexto;
var
    i: integer;
begin
    if linhas = 0 then
    begin
        writeln('Nenhum texto escrito.');
        exit;
    end;

    writeln('--- Conteúdo do Texto ---');
    for i := 1 to linhas do
        writeln(texto[i]);
    writeln('-------------------------');
end;

procedure DigitarTexto;
var
    linha: string;
begin
    writeln('Digite seu texto. Escreva FIM para parar.');
    repeat
        readln(linha);
        if UpperCase(linha) <> 'FIM' then
        begin
            linhas := linhas + 1;
            texto[linhas] := linha;
        end;
    until UpperCase(linha) = 'FIM';

    writeln('Texto registrado.');
end;

procedure SalvarTexto;
var
    arq: Text;
    i: integer;
begin
    if nomeArquivo = '' then
    begin
        write('Digite o nome do arquivo para salvar: ');
        readln(nomeArquivo);
    end;

    Assign(arq, nomeArquivo);
    Rewrite(arq);

    for i := 1 to linhas do
        writeln(arq, texto[i]);

    Close(arq);
    writeln('Arquivo salvo com sucesso.');
end;

procedure AbrirTexto;
var
    arq: Text;
    linha: string;
begin
    write('Digite o nome do arquivo para abrir: ');
    readln(nomeArquivo);

    if not FileExists(nomeArquivo) then
    begin
        writeln('Arquivo não encontrado.');
        exit;
    end;

    Assign(arq, nomeArquivo);
    Reset(arq);

    linhas := 0;
    while not EOF(arq) do
    begin
        Readln(arq, linha);
        linhas := linhas + 1;
        texto[linhas] := linha;
    end;

    Close(arq);
    writeln('Arquivo carregado com sucesso.');
end;

procedure Menu;
begin
    writeln;
    writeln('===== EDITOR DE TEXTO =====');
    writeln('[1] Novo Texto');
    writeln('[2] Digitar Texto');
    writeln('[3] Mostrar Texto');
    writeln('[4] Salvar Arquivo');
    writeln('[5] Abrir Arquivo');
    writeln('[0] Sair');
    write('Escolha: ');
end;

var
    op: integer;

begin
    linhas := 0;

    repeat
        Menu;
        readln(op);

        case op of
            1: NovoTexto;
            2: DigitarTexto;
            3: MostrarTexto;
            4: SalvarTexto;
            5: AbrirTexto;
            0: writeln('Saindo...');
        else
            writeln('Opção inválida.');
        end;

    until op = 0;
end.
