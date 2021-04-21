table 51513357 "Job Interviewers"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Recruitment Need"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Recruitment Need';
            TableRelation = "Recruitment Needs";
            Editable = false;

        }
        field(2; "Interview Type"; Option)
        {
            OptionMembers = " ","Oral Interview","Technical Interview";
            DataClassification = CustomerContent;
            Caption = 'Interview Type';
        }
        field(3; Interviewer; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Interviewer';
            TableRelation = "User Setup";

            trigger Onvalidate()
            var
                UserName: Record User;
            begin
                if UserID.Get(Interviewer) then begin
                    UserName.Reset();
                    UserName.SetRange("User Name", Interviewer);
                    if UserName.FindFirst() then
                        "Interviewer Name" := UserName."Full Name";
                    "Employee Number" := UserID."Employee No.";
                end;
            end;

        }
        field(4; "Interviewer Name"; text[200])

        {
            DataClassification = CustomerContent;
            Caption = 'Interviewer Name';
            Editable = false;
        }
        field(5; "Employee Number"; code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee Number';
        }
        field(6; "Directorate"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Directorate';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));
        }
        field(7; "Date Created"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date Created';
        }
        field(8; Chair; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Chair';
        }
        field(9; "Stage Code"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Stage Code';
            TableRelation = "Recruitment Stages"."Recruitment Stage";
        }
        field(10; Shortlisting; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Shortlisting';
        }
    }

    keys
    {
        key(PK; "Recruitment Need", Interviewer, "Interview Type", "Stage Code")
        {

        }
    }

    var
        UserID: Record "User Setup";

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