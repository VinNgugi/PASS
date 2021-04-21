table 51513041 "Hotels List"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Hotels List";
    DrillDownPageId = "Hotels List";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Hotel Name"; Text[50])
        {

        }
        field(3; "Hotel Location"; Text[20])
        {

        }
        field(4; "Hotel Class"; Text[20])
        {
            //OptionMembers=
        }
        field(5; "Vendor No."; Code[20])
        {

        }
        field(6; Blocked; Boolean)
        {

        }
        field(7; "PASS Category"; Option)
        {
            OptionMembers = " ",A,B;
        }

    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(Dropdown; "No.", "Hotel Name", "Hotel Class")
        {

        }
        fieldgroup(Brick; "No.", "Hotel Name", "Hotel Class")
        {

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