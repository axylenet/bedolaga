unit unitSpAvtor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TFormSpAvtor }

  TFormSpAvtor = class(TForm)
    BtnAdd: TBitBtn;
    BtnDel: TBitBtn;
    BtnEdit: TBitBtn;
    BtnExit: TBitBtn;
    BtnSave: TBitBtn;
    Edit1: TEdit;
    Label2: TLabel;
    ListBox1: TListBox;
    procedure BtnAddClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure BtnEditClick(Sender: TObject);
    procedure BtnExitClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
  private

  public

  end;

var
  FormSpAvtor: TFormSpAvtor;

implementation

{$R *.lfm}

{ TFormSpAvtor }

procedure TFormSpAvtor.BtnAddClick(Sender: TObject);
begin
  ListBox1.Items.AddText(Edit1.Text);
  Edit1.Clear;
end;

procedure TFormSpAvtor.BtnDelClick(Sender: TObject);
begin
  ListBox1.Items.Delete(ListBox1.ItemIndex);
end;

procedure TFormSpAvtor.BtnEditClick(Sender: TObject);
begin
  if (ListBox1.ItemIndex >= 0 ) then
  ListBox1.Items[ListBox1.ItemIndex] := Edit1.Text;
end;

procedure TFormSpAvtor.BtnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFormSpAvtor.BtnSaveClick(Sender: TObject);
begin
  ListBox1.Items.SaveToFile('db\avtor.db');
end;

procedure TFormSpAvtor.FormShow(Sender: TObject);
begin
  ListBox1.Items.LoadFromFile('db\avtor.db');
end;

procedure TFormSpAvtor.ListBox1Click(Sender: TObject);
begin
  Edit1.Text:=ListBox1.Items[ListBox1.ItemIndex];
end;

end.

