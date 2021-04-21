table 51513263 "HR Human Resource Comments"
{
    DataClassification = CustomerContent;
    Caption = 'HR Human Resource Comments';

    fields
    {
        field(1; "Table Name"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Employee,Relative,"Relation Management","Correspondence History",Images,"Absence and Holiday","Cost to Company","Pay History","Bank Details",Maternity,"SAQA Training History","Absence Information","Incident Report","Emp History","Medical History","Career History",Appraisal,Disciplinary,"Exit Interviews",Grievances,"Existing Qualifications","Proffesional Membership","Education Assistance","Learning Intervention","NOSA or other Training","Company Skills Plan","Development Plan","Skills Plan","Emp Salary",Unions;
            Caption = 'Table Name';
        }
        field(2; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            /*TableRelation = IF ("Table Name" = CONST (Employee)) "HR Employee"."No." ELSE
            IF ("Table Name" = CONST (Relative)) Table52008.Field1 ELSE
            IF ("Table Name" = CONST ("Relation Management")) Table52011.Field1
            ELSE
            IF ("Table Name" = CONST ("Correspondence History")) Table52014.Field1 ELSE
            IF ("Table Name" = CONST (Images)) Table52015.Field1
            ELSE
            IF ("Table Name" = CONST ("Absence and Holiday")) Table52019.Field1 ELSE
            IF ("Table Name" = CONST ("Cost to Company")) Table52021.Field1
            ELSE
            IF ("Table Name" = CONST ("Bank Details")) Table52022.Field1 ELSE
            IF ("Table Name" = CONST (Maternity)) Table52025.Field1
            ELSE
            IF ("Table Name" = CONST ("SAQA Training History")) Table52026.Field1 ELSE
            IF ("Table Name" = CONST ("Absence Information")) Table52035.Field1;*/
        }
        field(3; "Table Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Table Line No.';
        }
        field(4; "Key Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Key Date';
        }
        field(5; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(6; Date; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date';
        }
        field(7; Code; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(8; Comment; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Comment';
        }
        field(9; User; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'User';
        }
    }

    keys
    {
        key(PK; "No.", "Table Name", "Table Line No.")
        {

        }
    }



    trigger OnInsert()

    var
        lRec_UserTable: Record "User Setup";
    begin
        lRec_UserTable.GET(USERID);
        //User := ;
        Date := WORKDATE;
    end;

    trigger OnModify()
    var
        lRec_UserTable: Record "User Setup";
    begin
        lRec_UserTable.GET(USERID);
        //User := lRec_UserTable.Name;
        Date := WORKDATE;
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure SetUpNewLine()
    var
        HumanResCommentLine: Record "HR Human Resource Comments";
    begin
        HumanResCommentLine := Rec;
        HumanResCommentLine.SETRECFILTER;
        HumanResCommentLine.SETRANGE("Line No.");
        IF NOT HumanResCommentLine.FIND('-') THEN
            Date := WORKDATE;
    end;
}



