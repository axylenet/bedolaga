unit unitSpJanr;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TFormSpJanr }

  TFormSpJanr = class(TForm)
    BtnAdd: TBitBtn;
    BtnEdit: TBitBtn;
    BtnDel: TBitBtn;
    BtnSave: TBitBtn;
    BtnExit: TBitBtn;
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
  FormSpJanr: TFormSpJanr;

implementation

{$R *.lfm}

{ TFormSpJanr }

procedure TFormSpJanr.BtnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFormSpJanr.BtnDelClick(Sender: TObject);
begin
  ListBox1.Items.Delete(ListBox1.ItemIndex);
end;

procedure TFormSpJanr.BtnAddClick(Sender: TObject);
begin
  ListBox1.Items.AddText(Edit1.Text);
  Edit1.Clear;
end;

procedure TFormSpJanr.BtnEditClick(Sender: TObject);
begin
  if (ListBox1.ItemIndex >= 0 ) then
  ListBox1.Items[ListBox1.ItemIndex] := Edit1.Text;
end;

procedure TFormSpJanr.BtnSaveClick(Sender: TObject);
begin
  ListBox1.Items.SaveToFile('db\janr.db');
end;

procedure TFormSpJanr.FormShow(Sender: TObject);
begin
  ListBox1.Items.LoadFromFile('db\janr.db');
end;

procedure TFormSpJanr.ListBox1Click(Sender: TObject);
begin
  Edit1.Text:=ListBox1.Items[ListBox1.ItemIndex];
end;

end.

