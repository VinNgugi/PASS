table 51513310 "Document Link"
{
    // version HR
    Caption = 'Document Link';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No"; Code[20])
        {
            NotBlank = true;
            TableRelation = Employee."No.";
        }
        field(2; "Document Description"; Text[100])
        {
            NotBlank = true;
        }
        field(3; "Document Link"; Text[200])
        {
        }
        field(5; ggg; Text[30])
        {
        }
        field(6; "Attachment No."; Integer)
        {
        }
        field(7; "Language Code (Default)"; Code[10])
        {
            TableRelation = Language;
        }
        field(8; Attachement; Option)
        {
            OptionMembers = No,Yes;
        }
    }

    keys
    {
        key(Key1; "Employee No", "Document Description")
        {
        }
    }

    fieldgroups
    {
    }
}

