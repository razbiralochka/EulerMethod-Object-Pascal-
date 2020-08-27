unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  TAGraph, TASeries, TAIntervalSources;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
    Chart1LineSeries2: TLineSeries;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure Edit2KeyPress(Sender: TObject; var Key: char);

  private

  public

  end;

var
  Form1: TForm1;
  h,X:real;
  size: integer;
  X_arr : array of Real;
  Y_arr : array of Real;
  Y_arr_Euler : array of Real;
  i:integer;
implementation

function y_func(xx: real): Real;
  begin
    y_func:= 9*exp(1 - xx)*xx;
  end;
{$R *.lfm}

{ TForm1 }



procedure TForm1.Button1Click(Sender: TObject);
begin
     X:=StrToFloat(Edit1.Text);
     h:=StrToFloat(Edit2.Text);

     size:= round(X / h) + 1;

     Edit3.Text:=IntToStr(size-1);

     SetLength(X_arr,size);
     SetLength(Y_arr,size);
     SetLength(Y_arr_Euler,size);

     X_arr[0]:= 0;
     Y_arr_Euler[0]:= 0;
     Y_arr[0]:= 0;

     Memo1.Lines.Add('X='+ FloatToStr(X_arr[0])+'   Y='+FloatToStr(Y_arr[0])
     +'   Y_0='+FloatToStr(Y_arr_Euler[0]));

     for i:=1 to size-1 do
         begin
               X_arr[i] := i * h;

	       Y_arr[i] := y_func(X_arr[i]);

	       Y_arr_Euler[i] := (9 * exp(1-X_arr[i-1]) - Y_arr_Euler[i - 1]) * h + Y_arr_Euler[i - 1];

               Memo1.Lines.Add('X='+ FloatToStr(round(X_arr[i] * 1000) / 1000)
               +'   Y='+FloatToStr(round(Y_arr[i]*100)/100)
               +'   Y_'+IntToStr(i)+'='
               +FloatToStr(round(Y_arr_Euler[i]*100) / 100));
         end;


           Chart1LineSeries1.Clear;
           Chart1LineSeries2.Clear;
     for i:=0 to size-1 do
     begin

          Chart1LineSeries1.AddXY(X_arr[i],Y_arr[i],'11',clRed);
          Chart1LineSeries2.AddXY(X_arr[i],Y_arr_Euler[i],'22',clBlue);

     end;

end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: char);
begin
     if Key='.' then  Key:=',';
end;

procedure TForm1.Edit2KeyPress(Sender: TObject; var Key: char);
begin
     if Key='.' then  Key:=',';
end;

end.

