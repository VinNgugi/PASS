table 51513412 "Files Path Management"
{
    // version PROC
    Caption = 'Files Path Management';
    DataClassification = CustomerContent;

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = CustomerContent;
        }
        field(3; Path; Text[250])
        {
            Caption = 'Path';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; No, "Line No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        /*  rfprec.RESET;
          rfprec.SETFILTER(rfprec.No, No);
          rfprec.SETFILTER(rfprec.Status, '<>%1', rfprec.Status::Open);
          if rfprec.FINDSET then begin
              ERROR('You can Only Delete Open Entries!!');
          end;*/
    end;

    trigger OnInsert();
    begin
        /*rfprec.RESET;
        rfprec.SETFILTER(rfprec.No, No);
        rfprec.SETFILTER(rfprec.Status, '<>%1', rfprec.Status::Open);
        if rfprec.FINDSET then begin
            ERROR('You can Only Add to Open Entries!!');
        end;*/
    end;

    trigger OnModify();
    begin
        /* rfprec.RESET;
         rfprec.SETFILTER(rfprec.No, No);
         rfprec.SETFILTER(rfprec.Status, '<>%1', rfprec.Status::Open);
         if rfprec.FINDSET then begin
             ERROR('You can Only Modify Open Entries!!');
         end;*/
    end;

    var
    //rfprec: Record "Procurement Request";
}

