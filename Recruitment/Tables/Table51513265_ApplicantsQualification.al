table 51513265 "Applicants Qualification"
{
    DataClassification = CustomerContent;
    Caption = 'Applicants Qualification';

    fields
    {
        field(1; "Applicant No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Applicants Qualification';
            NotBlank = true;
            TableRelation = "Job Applicants"."No.";

        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
            AutoIncrement = true;
        }
        field(3; "Qualification Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Qualification Code';
            TableRelation = Qualification.Code;
            NotBlank = true;
        }
        field(4; "From Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'From Date';
        }
        field(5; "To Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'ToDate';
        }
        field(6; Type; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = ,Internal,External,"Previous Position";
            Caption = 'Type';
        }
        field(7; Description; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(8; "Institution/Company"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Institution/Company';
        }
        field(9; Cost; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cost';
        }
        field(10; "Course Grade"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Grade';
        }
        field(11; "Employee Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Employee Status';
            OptionMembers = Active,Inactive,Terminated;
            Editable = false;
        }
        field(12; Comment; Boolean)
        {
            //DataClassification = CustomerContent;
            Caption = 'Comment';
            FieldClass = FlowField;
            CalcFormula = Exist ("Human Resource Comment Line" WHERE ("Table Name" = CONST ("Employee Qualification"), "No." = FIELD ("Applicant No."), "Table Line No." = FIELD ("Line No.")));
            Editable = false;


        }
        field(13; "Expiration Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Expiration Date';
        }
        field(50000; "Qualification Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Qualification Type';
            OptionMembers = ,Academic,Professional,Technical,Experience,"Personal Attributes","Professional Membership";
        }
        field(50001; Qualification; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Qualification';
            NotBlank = true;
        }
        field(50002; "Score ID"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Score ID';
            TableRelation = "Score Setup"."Score ID";
        }

    }

    keys
    {
        key(PK; "Applicant No.", "Line No.")
        {
            SumIndexFields = "Score ID";

        }
        key(QC; "Qualification Code")
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