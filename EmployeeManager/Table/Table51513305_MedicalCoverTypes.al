table 51513305 "Medical Cover Types"
{
    // version HR

    DrillDownPageID = "Medical Cover List";
    LookupPageID = "Medical Cover List";
    Caption = 'Medical Cover Types';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; Type; Option)
        {
            OptionMembers = "  ","In House",Outsourced;
            Caption = 'Type';
            DataClassification = CustomerContent;

        }
        field(4; Provider; Code[20])
        {
            TableRelation = Vendor;
            Caption = 'Provider';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if vend.GET(Provider) then begin
                    "Name of Provider" := vend.Name;
                end;
            end;
        }
        field(5; "Name of Provider"; Text[50])
        {
            Caption = 'Name of Provider';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }



    var
        vend: Record Vendor;
}

