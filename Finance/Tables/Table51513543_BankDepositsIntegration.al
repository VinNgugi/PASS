table 51513543 "Bank Payments Integration"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Receipt No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Receipt Date"; Date)
        {

        }
        field(3; "Pay Mode"; Text[20])
        {

        }
        field(4; "Received From"; Text[50])
        {

        }
        field(5; "On Behalf Of"; Text[50])
        {

        }
        field(6; "Cheque No."; Text[20])
        {

        }
        field(7; "Cheque Date"; Date)
        {

        }
        field(8; "Receipting Acc. Code"; Text[20])
        {

        }
        field(9; "Guarantee Application No."; Text[20])
        {

        }
        field(10; "Guarantee Entry Type"; Option)
        {
            OptionMembers = " ",Consultancy,"Risk Sharing Fee","Linkage Banking","Lenders Option","Booked Fee","Application Fee";
        }
        field(11; "Applies To Doc No."; Code[20])
        {

        }
        field(12; "Currency Code"; Code[20])
        {

        }
        field(13; "Pass Branch Code"; Code[20])
        {

        }
        field(14; Amount; Decimal)
        {

        }
        field(15; "Amount LCY"; Decimal)
        {

        }
    }

    keys
    {
        key(PK; "Receipt No.")
        {
            Clustered = true;
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