table 51513043 "Staff PGroups"
{
    // version FINANCE

    Caption = 'Staff PGroups';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Group';
            TableRelation = "Staff Posting Group";
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            TableRelation = IF (Type = CONST (Earning)) Earnings
            ELSE
            IF (Type = CONST (Deduction)) Deductions;

            trigger OnValidate();
            begin
                if Type = Type::Earning then begin
                    if EarningRec.GET(Code) then begin
                        Description := EarningRec.Description;
                    end;
                end;

                if Type = Type::Deduction then begin
                    if Deduction.GET(Code) then begin
                        Description := Deduction.Description;
                    end;
                end;
            end;
        }
        field(3; "G/L Account"; Code[10])
        {
            Caption = 'G/L Account';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
        }
        field(4; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            OptionMembers = Earning,Deduction;
        }
        field(6; "GL Account Employer"; Code[10])
        {
            Caption = 'GL Account Employer';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
        }
    }

    keys
    {
        key(Key1; "Posting Group", "Code", Type)
        {
        }
    }

    fieldgroups
    {
    }

    var
        EarningRec: Record Earnings;
        Deduction: Record Deductions;
}

