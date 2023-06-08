unit unitMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  StdCtrls;

type

  { TFormMain }

  TFormMain = class(TForm)
    Image1: TImage;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
  private

  public

  end;

var
  FormMain: TFormMain;

implementation
 uses unitSpJanr, unitSpTip, unitSpPerepl, unitSpIzdat, unitSpAvtor,
      unitKnigaEdit, unitKnigList;
{$R *.lfm}

{ TFormMain }


procedure MyFileCreate(name : string);
var
  i : Integer;
begin
  if not FileExists(name) then begin
   i := FileCreate(name);
   FileClose(i);
  end;
end;


procedure TFormMain.FormCreate(Sender: TObject);
begin
  MyFileCreate('db/avtor.db');
  MyFileCreate('db/janr.db');
  MyFileCreate('db/tip.db');
  MyFileCreate('db/perepl.db');
  MyFileCreate('db/izdat.db');
  MyFileCreate('db/listknig.db');
end;

procedure TFormMain.Image1Click(Sender: TObject);
begin

end;

procedure TFormMain.MenuItem1Click(Sender: TObject);
begin
  Close;
end;

procedure TFormMain.MenuItem3Click(Sender: TObject);
begin
  // Автор
   FormSpAvtor.Show;
end;

procedure TFormMain.MenuItem4Click(Sender: TObject);
begin
  // Жанр
   FormSpJanr.Show;
end;

procedure TFormMain.MenuItem5Click(Sender: TObject);
begin
  // Тип
   FormSpTip.Show;
end;

procedure TFormMain.MenuItem6Click(Sender: TObject);
begin
  // Переплет
   FormSpPerepl.Show;
end;

procedure TFormMain.MenuItem7Click(Sender: TObject);
begin
  // Издателтство
   FormSpIzdat.Show;
end;

procedure TFormMain.MenuItem8Click(Sender: TObject);
begin
  // Список книг
  FormKnigList.Show;
end;

procedure TFormMain.MenuItem9Click(Sender: TObject);
begin

end;

end.

