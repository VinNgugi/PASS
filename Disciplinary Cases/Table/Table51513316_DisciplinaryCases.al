table 51513316 "Disciplinary Cases"
{
    // version HR

    caption = 'Disciplinary Cases';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Case No"; Code[20])
        {
        }
        field(2; "Case Description"; Text[250])
        {
        }
        field(3; "Date of the Case"; Date)
        {
        }
        field(4; "Offense Type"; Code[20])
        {
            TableRelation = "Disciplinary Offenses";

            trigger OnValidate();
            begin
                if offenserec.GET("Offense Type") then begin
                    "Offense Name" := offenserec.Description;
                end;
            end;
        }
        field(5; "Offense Name"; Text[250])
        {
        }
        field(6; "Employee No"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate();
            begin
                if emprec.GET("Employee No") then begin
                    "Employee Name" := emprec."First Name" + ' ' + emprec."Middle Name" + ' ' + emprec."Last Name";
                    userrec.RESET;
                    userrec.SETFILTER(userrec."Employee No.", "Employee No");
                    if userrec.FINDSET then begin
                        userrec2.RESET;
                        if userrec2.GET(userrec.HOD) then begin
                            "HOD Name" := userrec2."User ID"; //MESSAGE(userrec2."User ID");
                            if "HOD Name" <> '' then begin
                                userrec2.GET(userrec2."User ID");
                                emprec.GET(userrec2."Employee No.");
                                "HOD Name" := emprec."First Name" + ' ' + emprec."Middle Name" + ' ' + emprec."Last Name";
                            end;
                        end;

                    end;
                    //get previous case
                    DisciplinaryCasesRec.RESET;
                    DisciplinaryCasesRec.SETRANGE(DisciplinaryCasesRec."Employee No", "Employee No");
                    if DisciplinaryCasesRec.FINDLAST then
                        "Previous Disciplinary Case" := DisciplinaryCasesRec."Offense Name";

                end;
            end;
        }
        field(7; "Employee Name"; Text[250])
        {
        }
        field(8; "Case Status"; Option)
        {
            OptionMembers = New,Ongoing,Appealed,Closed,Court;
        }
        field(9; "HOD Recommendation"; Text[250])
        {
        }
        field(10; "HR Recommendation"; Text[250])
        {
        }
        field(11; "Commitee Recommendation"; Text[250])
        {
        }
        field(12; "Action Taken"; Text[250])
        {
            TableRelation = "Disciplinary Actions".Code;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                DisciplinaryActions.Reset();
                DisciplinaryActions.SetRange(Code, "Action Taken");
                if DisciplinaryActions.Find('-') then begin
                    "Action Taken Description" := DisciplinaryActions.Description;
                end
                else
                    "Action Taken Description" := '';
            end;
        }
        field(13; Appealed; Boolean)
        {
        }
        field(14; "Committee Recon After Appeal"; Text[250])
        {
        }
        field(15; "HOD File Path"; Text[250])
        {
        }
        field(16; "HR File Path"; Text[250])
        {
        }
        field(17; "Committe File Path"; Text[250])
        {
        }
        field(18; "Committee File-After Appeal"; Text[250])
        {
        }
        field(19; "No. series"; Code[10])
        {
        }
        field(20; "HOD Name"; Text[250])
        {
        }
        field(21; "No. of Appeals"; Integer)
        {
        }
        field(22; "CEO Recommendation"; Text[250])
        {
        }
        field(23; "Court's Decision"; Text[250])
        {
        }
        field(24; "Levels of Discipline"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Levels of Discipline".Level;
        }
        field(25; "Previous Disciplinary Case"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Action Taken Description"; Text[100])
        {
            Editable = false;
        }
        field(27; "Warning Letter Attachment Path"; Text[250])
        {

        }
    }

    keys
    {
        key(Key1; "Case No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        if "Case No" = '' then begin
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD(HumanResSetup."Disciplinary Nos");
            NoSeriesMgt.InitSeries(HumanResSetup."Disciplinary Nos", xRec."No. series", 0D, "Case No", "No. series");
        end;
    end;

    var
        emprec: Record Employee;
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        offenserec: Record "Disciplinary Offenses";
        userrec: Record "User Setup";
        userrec2: Record "User Setup";
        DisciplinaryCasesRec: Record "Disciplinary Cases";
        DisciplinaryActions: Record "Disciplinary Actions";
}

