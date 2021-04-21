table 51513222 "Appraisal Grades"
{
    // version HR

    //LookupPageID = "SMS Listing";
    Caption = 'Appraisal Grades';
    DataClassification = CustomerContent;
    fields
    {
        field(1; Grade; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[200])
        {
        }
        field(3; "Lowest Points Awarded"; Decimal)
        {
        }
        field(4; "Highest Points Awarded"; Decimal)
        {
        }
        field(5; Remark; Text[100])
        {
        }
        field(6; "Salary Increament Perc"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Grade)
        {
        }
        key(Key2; "Lowest Points Awarded")
        {
        }
    }

    fieldgroups
    {
    }
}

