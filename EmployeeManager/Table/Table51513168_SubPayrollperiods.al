table 51513168 "Sub Payroll periods"
{
    Caption = 'Sub Payroll periods';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Payroll Category"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll Subcategories"."Payroll Subcategory";

            trigger OnValidate();
            begin
                Category.RESET;
                Category.SETRANGE("Payroll Subcategory", "Payroll Category");
                if Category.FIND('-') then
                    "Payroll Group" := Category."Payroll Group";
                VALIDATE("Payroll Group");
            end;
        }
        field(3; "Pay Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Batch No"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Closed By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Date Closed"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Payroll Group"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate();
            begin
                if Posting.GET("Payroll Group") then begin
                    if Posting."Allow Batches" then
                        "Drop Entries" := true;
                    if Posting."Run per Salary Group" then
                        "Allow Categories" := true;
                end;
            end;
        }
        field(9; "Drop Entries"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Allow Categories"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Payroll Period", "Payroll Category", "Batch No", "Pay Date")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Posting: Record "Staff Posting Group";
        Category: Record "Payroll Subcategories";
}

