unit unitKnigList;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  Grids, Buttons, EditBtn;

type
  Kniga = record
    Avtor : String[50];
    Nazvanie : String[50];
    Janr : String[20];
    Tip  : String[20];
    Pereplet : String[50];
    GodIzdan : String[4];
    Izdatelstvo : String[50];
  end;


type
  { TFormKnigList }

  TFormKnigList = class(TForm)
    BitBtn1: TBitBtn;
    BtnAdd: TBitBtn;
    BtnEdit: TBitBtn;
    BtnDel: TBitBtn;
    ComboBox1: TComboBox;
    EditButton1: TEditButton;
    StringGrid1: TStringGrid;
    ToolBar1: TToolBar;
    procedure BitBtn1Click(Sender: TObject);
    procedure BtnAddClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure BtnEditClick(Sender: TObject);
    procedure EditButton1ButtonClick(Sender: TObject);
    procedure EditButton1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1Click(Sender: TObject);
    procedure UpdateGrid(Sender: TObject);
    procedure WriteToFile( namfile : string; kng : Kniga );
    procedure WriteArrToFile( namfile : string; count : integer;  kng : array of Kniga );
  private

  public
   arrKnig : array[1..100] of Kniga;
   arrCount : integer;
   reg : integer;
  end;

var
  FormKnigList: TFormKnigList;

implementation
 uses unitKnigaEdit;
{$R *.lfm}

{ TFormKnigList }


 procedure TFormKnigList.WriteToFile( namfile : string; kng : Kniga );
 var
   f : Text;
 begin
  AssignFile(f, namfile);
  Append(f);
  WriteLn(f, kng.Avtor);
  WriteLn(f, kng.Nazvanie);
  WriteLn(f, kng.Janr);
  WriteLn(f, kng.Tip);
  WriteLn(f, kng.Pereplet);
  WriteLn(f, kng.GodIzdan);
  WriteLn(f, kng.Izdatelstvo);
  WriteLn(f, '');
  CloseFile(f);
 end;

 procedure TFormKnigList.WriteArrToFile( namfile : string; count : integer;  kng : array of Kniga );
 var
   f : Text;
   i : integer;
 begin
  AssignFile(f, namfile);
  Rewrite(f);
  for i:=1 to  count do begin
      WriteLn(f, kng[i].Avtor);
      WriteLn(f, kng[i].Nazvanie);
      WriteLn(f, kng[i].Janr);
      WriteLn(f, kng[i].Tip);
      WriteLn(f, kng[i].Pereplet);
      WriteLn(f, kng[i].GodIzdan);
      WriteLn(f, kng[i].Izdatelstvo);
      WriteLn(f, '');
   END;
  CloseFile(f);
 end;



procedure TFormKnigList.FormShow(Sender: TObject);
 var
  f : Text;
  i : Integer;
begin
  i := 1;
  AssignFile(f, 'db/listknig.db');
  Reset(f);
  while not (EOF(f)) do begin
     ReadLn(f, arrKnig[i].Avtor);
     ReadLn(f, arrKnig[i].Nazvanie);
     ReadLn(f, arrKnig[i].Janr);
     ReadLn(f, arrKnig[i].Tip);
     ReadLn(f, arrKnig[i].Pereplet);
     ReadLn(f, arrKnig[i].GodIzdan);
     ReadLn(f, arrKnig[i].Izdatelstvo);
     ReadLn(f);
     i := i + 1;
  end;
    CloseFile(f);
 arrCount := i - 1 ;

 UpdateGrid(Sender);


end;

procedure TFormKnigList.StringGrid1Click(Sender: TObject);
begin
end;

procedure TFormKnigList.UpdateGrid(Sender: TObject);
var
 i : Integer;
begin
 StringGrid1.RowCount:= arrCount + 1;

 for i:=1 to arrCount do  begin
     StringGrid1.Cells[0, i] := arrKnig[i].Avtor;
     StringGrid1.Cells[1, i] := arrKnig[i].Nazvanie;
     StringGrid1.Cells[2, i] := arrKnig[i].Janr;
     StringGrid1.Cells[3, i] := arrKnig[i].Tip;
     StringGrid1.Cells[4, i] := arrKnig[i].Pereplet;
     if arrKnig[i].GodIzdan = '' then  StringGrid1.Cells[5, i] := 'Нет' else
        StringGrid1.Cells[5, i] := arrKnig[i].GodIzdan;
     StringGrid1.Cells[6, i] := arrKnig[i].Izdatelstvo;
   end;

end;

procedure TFormKnigList.BtnAddClick(Sender: TObject);
begin
 // Add
 reg := 1;
 FormKnigaEdit.ShowModal;
end;

procedure TFormKnigList.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure TFormKnigList.BtnDelClick(Sender: TObject);
var
 i : Integer;
 x : Integer;
begin

  x := StringGrid1.Row;


  for i:= x to arrCount-1 do begin
    arrKnig[x] := arrKnig[x+1];
  end;
  arrCount:=arrCount-1;

  for i:=1 to StringGrid1.RowCount-1 do
    StringGrid1.Rows[i].Clear;

  UpdateGrid(Sender);

  FormKnigList.WriteArrToFile('db/listknig.db', FormKnigList.arrCount, FormKnigList.arrKnig );

end;

procedure TFormKnigList.BtnEditClick(Sender: TObject);
begin
 // Edit
 reg := 2;
 FormKnigaEdit.ShowModal;
end;

procedure TFormKnigList.EditButton1ButtonClick(Sender: TObject);
var
 i, k : Integer;
begin

  for i:=1 to StringGrid1.RowCount-1 do
    StringGrid1.Rows[i].Clear;
  k:= 1;

  if ComboBox1.ItemIndex = 0 then
  for i:= 1 to arrCount do
    if ( arrKnig[i].Avtor = EditButton1.Text) then begin
       StringGrid1.Cells[0, k] := arrKnig[i].Avtor;
       StringGrid1.Cells[1, k] := arrKnig[i].Nazvanie;
       StringGrid1.Cells[2, k] := arrKnig[i].Janr;
       StringGrid1.Cells[3, k] := arrKnig[i].Tip;
       StringGrid1.Cells[4, k] := arrKnig[i].Pereplet;
       StringGrid1.Cells[5, k] := arrKnig[i].GodIzdan;
       StringGrid1.Cells[6, k] := arrKnig[i].Izdatelstvo;
       k := k +1;
       StringGrid1.RowCount:= k + 1;
  end;

  if ComboBox1.ItemIndex = 1 then
  for i:= 1 to arrCount do
    if ( arrKnig[i].Nazvanie = EditButton1.Text) then begin
       StringGrid1.Cells[0, k] := arrKnig[i].Avtor;
       StringGrid1.Cells[1, k] := arrKnig[i].Nazvanie;
       StringGrid1.Cells[2, k] := arrKnig[i].Janr;
       StringGrid1.Cells[3, k] := arrKnig[i].Tip;
       StringGrid1.Cells[4, k] := arrKnig[i].Pereplet;
       StringGrid1.Cells[5, k] := arrKnig[i].GodIzdan;
       StringGrid1.Cells[6, k] := arrKnig[i].Izdatelstvo;
       k := k +1;
       StringGrid1.RowCount:= k + 1;
  end;

  if ComboBox1.ItemIndex = 2 then
  for i:= 1 to arrCount do
    if ( arrKnig[i].Janr = EditButton1.Text) then begin
       StringGrid1.Cells[0, k] := arrKnig[i].Avtor;
       StringGrid1.Cells[1, k] := arrKnig[i].Nazvanie;
       StringGrid1.Cells[2, k] := arrKnig[i].Janr;
       StringGrid1.Cells[3, k] := arrKnig[i].Tip;
       StringGrid1.Cells[4, k] := arrKnig[i].Pereplet;
       StringGrid1.Cells[5, k] := arrKnig[i].GodIzdan;
       StringGrid1.Cells[6, k] := arrKnig[i].Izdatelstvo;
       k := k +1;
       StringGrid1.RowCount:= k + 1;
  end;


  if ComboBox1.ItemIndex = 3 then
  for i:= 1 to arrCount do
    if ( arrKnig[i].Tip = EditButton1.Text) then begin
       StringGrid1.Cells[0, k] := arrKnig[i].Avtor;
       StringGrid1.Cells[1, k] := arrKnig[i].Nazvanie;
       StringGrid1.Cells[2, k] := arrKnig[i].Janr;
       StringGrid1.Cells[3, k] := arrKnig[i].Tip;
       StringGrid1.Cells[4, k] := arrKnig[i].Pereplet;
       StringGrid1.Cells[5, k] := arrKnig[i].GodIzdan;
       StringGrid1.Cells[6, k] := arrKnig[i].Izdatelstvo;
       k := k +1;
       StringGrid1.RowCount:= k + 1;
  end;


  if ComboBox1.ItemIndex = 4 then
  for i:= 1 to arrCount do
    if ( arrKnig[i].Pereplet = EditButton1.Text) then begin
       StringGrid1.Cells[0, k] := arrKnig[i].Avtor;
       StringGrid1.Cells[1, k] := arrKnig[i].Nazvanie;
       StringGrid1.Cells[2, k] := arrKnig[i].Janr;
       StringGrid1.Cells[3, k] := arrKnig[i].Tip;
       StringGrid1.Cells[4, k] := arrKnig[i].Pereplet;
       StringGrid1.Cells[5, k] := arrKnig[i].GodIzdan;
       StringGrid1.Cells[6, k] := arrKnig[i].Izdatelstvo;
       k := k +1;
       StringGrid1.RowCount:= k + 1;
  end;

  if ComboBox1.ItemIndex = 5 then
  for i:= 1 to arrCount do
    if ( arrKnig[i].GodIzdan = EditButton1.Text) then begin
       StringGrid1.Cells[0, k] := arrKnig[i].Avtor;
       StringGrid1.Cells[1, k] := arrKnig[i].Nazvanie;
       StringGrid1.Cells[2, k] := arrKnig[i].Janr;
       StringGrid1.Cells[3, k] := arrKnig[i].Tip;
       StringGrid1.Cells[4, k] := arrKnig[i].Pereplet;
       StringGrid1.Cells[5, k] := arrKnig[i].GodIzdan;
       StringGrid1.Cells[6, k] := arrKnig[i].Izdatelstvo;
       k := k +1;
       StringGrid1.RowCount:= k + 1;
  end;

  if ComboBox1.ItemIndex = 6 then
  for i:= 1 to arrCount do
    if ( arrKnig[i].Izdatelstvo = EditButton1.Text) then begin
       StringGrid1.Cells[0, k] := arrKnig[i].Avtor;
       StringGrid1.Cells[1, k] := arrKnig[i].Nazvanie;
       StringGrid1.Cells[2, k] := arrKnig[i].Janr;
       StringGrid1.Cells[3, k] := arrKnig[i].Tip;
       StringGrid1.Cells[4, k] := arrKnig[i].Pereplet;
       StringGrid1.Cells[5, k] := arrKnig[i].GodIzdan;
       StringGrid1.Cells[6, k] := arrKnig[i].Izdatelstvo;
       k := k +1;
       StringGrid1.RowCount:= k + 1;
  end;

  if (EditButton1.Text = '' ) then  UpdateGrid(Sender);


  // 123123

end;

procedure TFormKnigList.EditButton1Change(Sender: TObject);
begin

end;

end.

