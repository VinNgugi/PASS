table 51513811 "Residential Selection Lines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Applicant No."; Code[20])
        {

        }
        field(3; "First Name"; Text[30])
        {
            Caption = 'Name';
        }
        field(4; "Middle Name"; Text[30])
        {

        }
        field(5; "Last Name"; Text[30])
        {

        }
        field(6; Selection; Option)
        {
            OptionMembers = " ","Business Skills","Technical Training","Face to Face Interviews";
        }
        field(17; "Global Dimension 1 Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));
            CaptionClass = '1,1,1';
            Editable = false;
        }
        field(18; "Global Dimension 2 Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));
            CaptionClass = '1,1,2';

            Editable = false;
        }
        field(19; "Global Dimension 4 Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (4));
            CaptionClass = '1,2,4';
            Editable = false;

        }

    }

    keys
    {
        key(PK; "Document No", "Applicant No.")
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