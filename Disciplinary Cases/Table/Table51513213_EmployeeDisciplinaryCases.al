table 51513213 "Employee Disciplinary Cases"
{
    // version HR

    Caption = 'Employee Disciplinary Cases';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            NotBlank = true;
            TableRelation = Employee."No.";
        }
        field(2; "Refference No"; Integer)
        {
            AutoIncrement = true;
            Description = '//INCREMENTAL';
            NotBlank = true;
        }
        field(3; Date; Date)
        {
        }
        field(4; "Disciplinary Case"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Disciplinary Offenses".Code;
        }
        field(5; "Recommended Action"; Code[20])
        {
            TableRelation = "Disciplinary Actions".Code;
        }
        field(6; "Case Description"; Text[250])
        {
        }
        field(7; "Accused Defence"; Text[250])
        {
        }
        field(8; "Witness #1"; Code[20])
        {
            TableRelation = Employee."No.";
        }
        field(9; "Witness #2"; Code[20])
        {
            TableRelation = Employee."No.";
        }
        field(10; "Action Taken"; Code[20])
        {
            TableRelation = "Disciplinary Actions".Code;
        }
        field(11; "Date Taken"; Date)
        {
        }
        field(12; "Document Link"; Text[200])
        {
        }
        field(13; "Disciplinary Remarks"; Code[50])
        {
            TableRelation = "Disciplinary Remarks".Remark;
        }
        field(14; Comments; Text[250])
        {
        }
        field(15; "Cases Discusion"; Boolean)
        {
        }
        field(16; Status; Option)
        {
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
        }
        field(17; "Employee USERID"; Code[40])
        {
            CalcFormula = Lookup ("User Setup"."User ID" WHERE ("Employee No." = FIELD ("Employee No")));
            FieldClass = FlowField;
        }
        field(18; "DG Recommendation"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Refference No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        if "Refference No" = 0 then begin
            casestb.RESET;
            casestb.FINDSET;
            if casestb.FINDLAST then begin
                "Refference No" := casestb."Refference No" + 10;
            end;
            if not casestb.FINDLAST then begin
                "Refference No" := 10;
            end;
        end;
    end;

    var
        casestb: Record "Employee Disciplinary Cases";
}

