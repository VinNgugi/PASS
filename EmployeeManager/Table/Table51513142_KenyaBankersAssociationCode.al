table 51513142 "Kenya Bankers Association Code"
{
    // version PAYROLL
    Caption = 'Bankers Association Code';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; "Bank Code"; Code[10])
        {
            TableRelation = "KBA Bank Names";

            trigger OnValidate();
            begin
                if KBABankNames.GET("Bank Code") then
                    "Bank Name" := KBABankNames."Bank Name";
            end;
        }
        field(3; "Branch Code"; Code[10])
        {

            trigger OnValidate();
            begin
                if STRLEN("Branch Code") = 1 then
                    "Branch Code" := '00' + '' + "Branch Code";
                if STRLEN("Branch Code") = 2 then
                    "Branch Code" := '0' + '' + "Branch Code";
                Code := "Bank Code" + '' + "Branch Code";
            end;
        }
        field(4; "Bank Name"; Text[120])
        {
        }
        field(5; "Branch Name"; Text[120])
        {
        }
    }

    keys
    {
        key(Key1; "Code", "Bank Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        if STRLEN("Branch Code") = 1 then
            "Branch Code" := '00' + '' + "Branch Code";
        if STRLEN("Branch Code") = 2 then
            "Branch Code" := '0' + '' + "Branch Code";
        if Code = '' then
            Code := "Bank Code" + '' + "Branch Code";
        if Code = '' then
            Code := 'RR0001';
    end;

    var
        KBABankNames: Record "KBA Bank Names";
}

