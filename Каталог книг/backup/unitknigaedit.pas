unit unitKnigaEdit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ExtCtrls, unitKnigList;

   ///структура
  {
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
 }

type
  { TFormKnigaEdit }

  TFormKnigaEdit = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    Edit2: TEdit;
    Edit6: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private

  public

  end;

var
  FormKnigaEdit: TFormKnigaEdit;
  kng : Kniga;
    x : Integer;
implementation

{$R *.lfm}

{ TFormKnigaEdit }

procedure TFormKnigaEdit.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TFormKnigaEdit.Edit2Change(Sender: TObject);
begin

end;

procedure TFormKnigaEdit.FormShow(Sender: TObject);
begin
  ComboBox1.Items.LoadFromFile('db/avtor.db');
  ComboBox1.ItemIndex:= 0;

  ComboBox2.Items.LoadFromFile('db/janr.db');
  ComboBox2.ItemIndex:= 0;

  ComboBox3.Items.LoadFromFile('db/tip.db');
  ComboBox3.ItemIndex:= 0;

  ComboBox4.Items.LoadFromFile('db/perepl.db');
  ComboBox4.ItemIndex:= 0;

  ComboBox5.Items.LoadFromFile('db/izdat.db');
  ComboBox5.ItemIndex:= 0;

  if ( FormKnigList.reg = 2 ) then
  begin
   x := FormKnigList.StringGrid1.Row;

   ComboBox1.Text :=  FormKnigList.StringGrid1.Cells[0, x];
   Edit2.Text     :=  FormKnigList.StringGrid1.Cells[1, x];
   ComboBox2.Text :=  FormKnigList.StringGrid1.Cells[2, x];
   ComboBox3.Text :=  FormKnigList.StringGrid1.Cells[3, x];
   ComboBox4.Text :=  FormKnigList.StringGrid1.Cells[4, x];
   Edit6.Text     :=  FormKnigList.StringGrid1.Cells[5, x];
   ComboBox5.Text :=  FormKnigList.StringGrid1.Cells[6, x];

  end;

end;

procedure TFormKnigaEdit.Image1Click(Sender: TObject);
begin

end;

procedure TFormKnigaEdit.BitBtn1Click(Sender: TObject);
var
  f : Text;
begin
  kng.Avtor := ComboBox1.Text;
  kng.Nazvanie := Edit2.Text;
  kng.Janr := ComboBox2.Text;
  kng.Tip := ComboBox3.Text;
  kng.Pereplet := ComboBox4.Text;
  kng.GodIzdan := Edit6.Text;
  kng.Izdatelstvo := ComboBox5.Text;


  if ( FormKnigList.reg = 1 ) then begin
    FormKnigList.arrCount:=FormKnigList.arrCount+1;
    FormKnigList.arrKnig[FormKnigList.arrCount] := kng;
    FormKnigList.UpdateGrid(Sender);
    FormKnigList.WriteToFile('db/listknig.db', kng);
  end;

  if ( FormKnigList.reg = 2 ) then begin
    FormKnigList.arrKnig[x] := kng;
    FormKnigList.UpdateGrid(Sender);
    FormKnigList.WriteArrToFile('db/listknig.db', FormKnigList.arrCount, FormKnigList.arrKnig );
  end;

   Edit2.Clear;
   Edit6.Clear;


  Close;

end;

end.

