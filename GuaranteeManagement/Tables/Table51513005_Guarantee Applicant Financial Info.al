table 51513005 "Guarantee App Financial Info"
{
    DataClassification = CustomerContent;
    Caption = 'Guarantee Applicant Financial Information';

    fields
    {
        field(1; "Application No."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Application No.';
            TableRelation = "Guarantee Application";


        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';

        }
        field(3; "Financial Year Starting"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Financial Year Starting Date';
            //TableRelation = "Accounting Period" where ("New Fiscal Year" = const (true));
        }
        field(4; "Gross Income"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Gross Income';
            AutoFormatType = 1;
            NotBlank = true;
        }
        field(5; "Profit Before Tax"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Profit Before Tax';
            AutoFormatType = 1;
        }
        field(6; "Total Assets"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Assets';

        }
        field(7; "No. of Employments Created"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. of Employments Created';
            Editable = false;
        }
        field(8; "Total Production"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Production';

        }
        field(9; "Unit of Measure"; Code[20])
        {
            Caption = 'Unit of Measure';
            DataClassification = CustomerContent;
            TableRelation = "Unit of Measure";
        }
        field(10; "No. of Female Employees"; Integer)
        {
            Caption = 'No. of Female Employees';
            DataClassification = CustomerContent;

            trigger onvalidate()

            begin
                "No. of Employments Created" := "No. of Female Employees" + "No. of Male Employees";
            end;
        }
        field(11; "No. of Male Employees"; Integer)
        {
            Caption = 'No. of Male Employees';
            DataClassification = CustomerContent;

            trigger onvalidate()

            begin
                "No. of Employments Created" := "No. of Female Employees" + "No. of Male Employees";
            end;
        }
        field(12; "No. of Female Beneficiaries"; Integer)
        {
            Caption = 'No. of Female Beneficiaries';
            DataClassification = CustomerContent;
            trigger onvalidate()

            begin
                "Total No. of Beneficiaries" := "No. of Male Beneficiaries" + "No. of Female Beneficiaries";
            end;
        }
        field(13; "No. of Male Beneficiaries"; Integer)
        {
            Caption = 'No. of Male Beneficiaries';
            DataClassification = CustomerContent;

            trigger onvalidate()

            begin
                "Total No. of Beneficiaries" := "No. of Male Beneficiaries" + "No. of Female Beneficiaries";
            end;
        }

        field(14; "Total No. of Beneficiaries"; Integer)
        {
            Caption = 'Total No. of Beneficiaries';
            DataClassification = CustomerContent;
            Editable = false;

        }
        field(15; "Financial Year Ending"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Financial Year Ending Date';
            //TableRelation = "Accounting Period" where ("New Fiscal Year" = const (true));
        }
    }

    keys
    {
        key(key1; "Application No.", "Line No.", "Financial Year Starting")
        {

        }
    }


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