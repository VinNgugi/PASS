table 51513124 "Medical Cover Category"
{
    DataClassification = CustomerContent;
    Caption = 'Medical Cover Category';

    fields
    {
        field(1; Category; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Category';

        }
        field(2; Inpatient; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Inpatient';
        }
        field(3; Outpatient; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Outpatient';
        }
        field(4; "Dental"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Dental';
        }
        field(5; Optical; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Optical';
        }
        field(6; "Maternity CS"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Maternity CS';
        }
        field(7; "Maternity Normal"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Maternity Normal';
        }

    }

    keys
    {
        key(PK; Category)
        {
            Clustered = true;
        }
    }



}