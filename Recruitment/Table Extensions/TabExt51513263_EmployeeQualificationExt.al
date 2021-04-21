tableextension 51513263 "Employee Qualification Ext" extends "Employee Qualification"
{
    fields
    {
        field(50000; "Qualification Type"; Option)
        {
            OptionMembers = ,Academic,Professional,Technical,Experience,"Personal Attributes";
            DataClassification = CustomerContent;
            Caption = 'Qualification Type';
        }
        field(50001; "CourseType"; Option)
        {
            OptionMembers = "Short Course","Long Course";
            DataClassification = CustomerContent;
            Caption = 'CourseType';
        }
        field(50002; Weight; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Weight';
        }
        field(50003; "Score ID"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Score ID';
        }
        field(50004; "Grad. Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Grad. Date';
        }
    }

    var
        myInt: Integer;
}