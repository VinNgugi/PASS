table 51513821 "AIC Setup"
{
    DataClassification = ToBeClassified;


    fields
    {
        field(10; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(17; "Global Dimension 1 Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));
            CaptionClass = '1,1,1';
        }

        field(18; "Gen. Prod. Posting Group"; Code[20])
        {
            TableRelation = "Gen. Product Posting Group";
        }
        field(19; "VAT Prod. Posting Group"; Code[20])
        {
            TableRelation = "VAT Product Posting Group";
        }

        field(20; "Incubation Nos"; Code[20])
        {
            Caption = 'Incubation Nos';
            TableRelation = "No. Series";
        }
        field(21; "Resource Group"; Code[20])
        {
            TableRelation = "Resource Group";
        }

        field(30; "Incubation Application Nos."; Code[20])
        {
            Caption = 'Incubants Application Nos.';
            TableRelation = "No. Series";
        }
        field(40; "Posted Seminar Reg. Nos."; Code[20])
        {
            Caption = 'Posted Incubation App. Nos.';
            TableRelation = "No. Series";
        }


    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }




    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}