table 51513309 "Medical History"
{
    // version HR
    Caption = 'Medical History';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; Description; Text[220])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = "Medical Information".Description;
        }
        field(3; Results; Text[250])
        {
            Caption = 'Results';
            DataClassification = CustomerContent;
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(5; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee No", Description)
        {
        }
    }


}

