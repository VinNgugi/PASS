table 51513996 "Validation Lines"
{
    DataClassification = ToBeClassified;

    fields
    {

        field(1; "Contract No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Contract No.';

        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(5; "Loan No"; Code[50])
        {
            Caption = 'Loan No.';
            DataClassification = CustomerContent;
        }
        field(6; "Customer Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer Name';
        }
        field(7; "Account No."; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Account No.';
        }
        field(8; "Approved Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Approved Amount';
        }
        field(9; "Disbursed Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Disbursed Amount';
        }
        field(10; "Outstanding Principal Amt"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Outstanding Principal Amt';
        }
        field(11; "Repayment Installment Amt"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Repayment Installment Amt';
        }
        field(12; "Total Exposure"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Total Exposure';
        }
        field(13; "Total Principal Amt Paid "; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Principal Amt';
        }
        field(14; "Interest Amt Accrued"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Interest Amt Accrued';
        }
        field(15; "Principal Amt In Arrears"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Principal Amt In Arrears';
        }
        field(16; "Interest Amt In Arrears"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Interest Amt In Arrears';
        }
        field(17; "Total No. of Installments"; integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Total No. of Installments';
        }
        field(18; "No. of Installments In Arrears"; integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. of Installments In Arrears';
        }
        field(19; "Guarantee"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Guarantee';
        }
        field(20; "Guarantee Amt"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Guarantee Amt';
        }
        field(21; "System Classification"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Classification';
            OptionMembers = " ","Unclassified(Current)","Especially Mentioned","Sub-Standard",Doubtful,Loss;
        }
        field(22; "Loan Disbursed Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Loan Disbursed Date';
        }
        field(23; "Loan Maturity Date"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Loan Maturity Date';
        }
        field(24; "Days Past Due"; Integer)
        {
            DataClassification = CustomerContent;
            caption = 'Days Past Due';
        }
        field(25; "Reporting Date"; Date)
        {
            Caption = 'Reporting Date';
            DataClassification = CustomerContent;
        }


        field(26; "Global Dimension 1 Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (1));


        }
        field(27; "Global Dimension 2 Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (2));

        }
        field(28; "Bank Brach Name"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank Brach Name';
        }

        field(29; "Bank"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank';
            TableRelation = Customer;
        }
        field(30; "Loan Value Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Loan Value Date';
        }
        field(31; "Header No"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(32; "Repeated Entry"; Boolean)
        {
            Editable = false;
        }
        field(33; "Product Type"; Code[20])
        {
            TableRelation = Products.Code;
        }
        field(50000; Validated; Boolean)
        {
            Caption = 'Validated';
            Editable = false;
        }
        field(50001; "Risk Sharing Fee"; Decimal)
        {

        }

    }
    keys
    {
        key(PK; "Header No", "Loan No", "Reporting Date", "Line No.")
        {
            Clustered = true;
        }
        key(PK2; "Line No.")
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