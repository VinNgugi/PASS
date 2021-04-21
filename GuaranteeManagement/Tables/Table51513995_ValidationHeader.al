table 51513995 "Validation Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; Banks; Code[20])
        {

            TableRelation = Customer."No." where ("Customer Posting Group" = filter ('BANKS'));
            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                if Customer.get(Banks) then
                    "Bank Name" := Customer.Name
                else
                    "Bank Name" := '';
            end;
        }
        field(3; "Total Entries"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count ("Validation Lines" where ("Header No" = field ("No.")));
            Editable = false;

        }
        field(4; "Validated Entries"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count ("Validation Lines" where (Validated = filter (true), "Header No" = field ("No.")));
            Editable = false;
        }
        field(5; "Bank Name"; text[100])
        {
            Editable = false;
        }
        Field(6; Quarter; Text[50])
        {

        }
        field(7; "Repeated Entries"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count ("Validation Lines" where ("Repeated Entry" = filter (true), "Header No" = field ("No.")));
            Editable = false;
        }
        field(8; "Validate Contract No."; Boolean)
        {

        }
        field(9; "Validate Names"; Boolean)
        {

        }
        field(10; "Split Number"; Boolean)
        {

        }
        field(11; "Validate Loan No"; Boolean)
        {

        }
    }

    keys
    {
        key(PK; "No.")
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