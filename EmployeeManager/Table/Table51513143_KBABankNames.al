table 51513143 "KBA Bank Names"
{
    // version PAYROLL

    LookupPageID = "KBA Bank Names";

    fields
    {
        field(1; "Bank Code"; Code[10])
        {

            trigger OnValidate();
            begin
                if STRLEN("Bank Code") < 2 then
                    "Bank Code" := '0' + '' + "Bank Code";
            end;
        }
        field(2; "Bank Name"; Text[130])
        {
        }
        field(3; Location; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Bank Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        KBABankNames: Record "KBA Bank Names";
}

