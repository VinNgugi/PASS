table 51513914 "Lenders Option Single CGC"
{
    DataClassification = CustomerContent;
    Caption = 'Lenders Option Single CGC';
    fields
    {
        field(1; "Seq. No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Seq. No.';
            AutoIncrement = true;

        }
        field(2; "Financial Institution Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Financial Institution Code';
            TableRelation = Customer;
        }
        field(3; "Reference No."; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Reference No.';

        }
        field(4; "Reference Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Reference Date';
        }
        field(5; Description; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(6; "From CGC No."; Text[200])
        {
            FieldClass = FlowField;
            Caption = 'From CGC No.';
            CalcFormula = min ("Guarantee Contracts"."CGC No." WHERE ("Reference No." = FIELD ("Reference No.")));
        }
        field(7; "To CGC No."; Text[200])
        {
            FieldClass = FlowField;
            Caption = 'To CGC No.';
            CalcFormula = max ("Guarantee Contracts"."CGC No." WHERE ("Reference No." = FIELD ("Reference No.")));
        }
        field(8; "No. of Loans"; Integer)
        {
            //DataClassification = CustomerContent;
            FieldClass = FlowField;
            Caption = 'No. of Loans';
            CalcFormula = Count ("Guarantee Contracts" WHERE ("Reference No." = FIELD ("Reference No.")));
        }
        field(9; "Total Principal Loan"; decimal)
        {
            FieldClass = FlowField;
            Caption = 'Total Principal Loan';
            CalcFormula = Sum ("Guarantee Contracts"."Approved Loan Amount" WHERE ("Reference No." = FIELD ("Reference No.")));
        }
        field(10; "Credit Guarantee %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Guarantee %';
        }
        field(11; "CGC Issued"; Boolean)
        {
            Caption = 'CGC Issued';
            DataClassification = CustomerContent;

        }
        field(16; "Global Dimension 1 Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (1));


        }
        field(17; "Global Dimension 2 Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (2));

        }
    }

    keys
    {
        key(PK; "Reference No.")
        {
            Clustered = true;
        }
        key(PK2; "Seq. No.")
        {
            Unique = true;
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

    procedure GetSeqNo(): Integer
    var
        LendersOptionSingleCGC: Record "Lenders Option Single CGC";
    begin
        IF LendersOptionSingleCGC.FINDLAST THEN
            EXIT(LendersOptionSingleCGC."Seq. No." + 1);
        EXIT(1);
    end;
}