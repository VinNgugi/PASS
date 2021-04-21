table 51513701 "Employee Experience Rating"
{
    // version HR
    Caption = 'Employee Experience Rating';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Exit Interview Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Rating; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Strongly Disagree,Disagree,Neither Agree nor Disagree,Agree,Strongly Agree';
            OptionMembers = ,"Strongly Disagree",Disagree,"Neither Agree nor Disagree",Agree,"Strongly Agree";
        }
        field(3; Description; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Exit Interview Code", "Line No.", Description)
        {
        }
    }

    fieldgroups
    {
    }
}

